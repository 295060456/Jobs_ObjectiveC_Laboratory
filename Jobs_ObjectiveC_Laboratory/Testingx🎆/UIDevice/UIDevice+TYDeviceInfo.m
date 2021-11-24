//
//  UIDevice+TYDeviceInfo.m
//  TYNetworking
//
//  Created by eagle on 2019/3/14.
//  Copyright © 2019 com.ty. All rights reserved.
//

#import "UIDevice+TYDeviceInfo.h"
#import <AdSupport/ASIdentifierManager.h>
#import <AVFoundation/AVFoundation.h>
#import "NSString+TYHash.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <sys/utsname.h>
#include <net/if.h>
#include <net/if_dl.h>

static NSString * const TYFoundationKeychainServiceName = @"TYFoundationKeychainServiceName";
static NSString * const TYFoundationNetworkUDIDName = @"TYFoundationNetworkUDIDName";
static NSString * const TYFoundationPasteboardType  = @"TYFoundationPasteboardType";

@interface TYFBundleFinder : NSObject
@end

@implementation TYFBundleFinder
@end

@interface UIDevice(TYPrivate)
- (NSString *) localMAC;
@end

@implementation UIDevice (TYDeviceInfo)

#pragma mark -
#pragma mark Public Methods

/** APP 外部版本号*/
- (NSString *) ty_appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: @"";
}
- (NSString *)ty_appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
/** APP 编译号*/
- (NSString *) ty_buildNumber {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] ?: @"";
}

/** App Bundle id */
- (NSString *) ty_bundleIdentifier {
    return [[NSBundle mainBundle] bundleIdentifier] ?: @"" ;
}

/** 手机操作系统版本 */
- (NSString *) ty_system_version {
    return [[UIDevice currentDevice] systemVersion];
}

/** 磁盘大小 */
- (long) ty_diskTotalSize {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *diskTotalSize = [systemAttributes objectForKey:NSFileSystemSize];
    return (long)(diskTotalSize.floatValue / 1024.f / 1024.f);
}

/** 获取磁盘剩余空间大小 */
- (long) ty_diskFreeSize {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSNumber *diskFreeSize = [systemAttributes objectForKey:NSFileSystemFreeSize];
    return (long)(diskFreeSize.floatValue / 1024.f / 1024.f);
}

/** 获取电量 */
- (CGFloat)ty_batteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [[UIDevice currentDevice] batteryLevel];
}

/** 获取电池状态 */
- (NSString *)ty_batteryState {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
    switch (batteryState) {
            case UIDeviceBatteryStateUnplugged:
            return @"未充电";
            case UIDeviceBatteryStateCharging:
            return @"充电中";
            case UIDeviceBatteryStateFull:
            return @"已充满";
        default:
            return @"未知";
    }
}

/** 获取屏幕尺寸 */
- (CGSize)ty_screenSize {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize screenSize = CGSizeMake(screenBounds.size.width * screenScale, screenBounds.size.height * screenScale);
    return screenSize;
}

/** 获取屏幕亮度 */
- (CGFloat)ty_screenBrightness {
    return [UIScreen mainScreen].brightness;
}

/** 是否使用了代理 */
- (BOOL)ty_isViaProxy {
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com/"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = proxies[0];
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        return YES;
    }
    return NO;
}

/** 获取 uuid */
- (NSString *) ty_uuid {
    NSString *key = @"TYNetworkingUUID";
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (uuid.length == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:[self ty_createUUID] forKey:key];
        return [[[NSUserDefaults standardUserDefaults] objectForKey:key] copy];
    } else {
        return uuid;
    }
}

/** 获取 idfa */
- (NSString *) ty_idfa {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

/** 获取 udid */
- (NSString *) ty_udid {
    static NSString *udid = nil;
    if (!udid) {
        udid = [self getUDID];
        if (udid.length==0) {
            udid = [self ty_uuid];
            [self saveUDID:udid];
        }
    }
    return udid;
}

/** mac 地址*/
- (NSString *) ty_macaddress {
    NSString *key = @"TYMacAddress";
    NSString *macAddress = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (macAddress.length == 0) {
        macAddress = [self localMAC];
        if (macAddress.length>0){
            [[NSUserDefaults standardUserDefaults] setObject:macAddress forKey:key];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TYMacAddressMD5"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return macAddress;

}

/** mac 地址 MD5*/
- (NSString *) ty_macaddressMD5 {
    NSString *key = @"TYMacAddressMD5";
    NSString *macid = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (macid.length == 0) {
        NSString *macaddress = [[UIDevice currentDevice] ty_macaddress];
        macid = [macaddress ty_md5];
        if (!macid){
            macid = @"macaddress_empty";
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:macid forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return macid;
}

/** 获取iOS 设备类型 */
- (NSString *) ty_machineType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *plistPath = [[NSBundle bundleForClass:[TYFBundleFinder class]] pathForResource:@"iPhoneTypeDefine" ofType:@"plist"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSString *type = dictionary[machineType];
    if (type) {
        return type;
    } else {
        return machineType;
    }
}

/** 是否是有留海 */
- (BOOL)ty_isIphoneXGroup {
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    if (CGSizeEqualToSize(screenSize, (CGSize){375.0, 812.0}) /// X XS
        || CGSizeEqualToSize(screenSize, (CGSize){414.0, 896.0})) { /// XMax XR
        return true;
    }
    return false;
}

#pragma mark -
#pragma mark Private Methods
- (NSString *) localMAC {
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *)ty_createUUID {
    
//    CFUUIDRef uuid = CFUUIDCreate(NULL);
//    CFStringRef string = CFUUIDCreateString(NULL, uuid);
//    CFRelease(uuid);
//    return (__bridge_transfer NSString *)string;
    
    NSString *identifier = [[UIDevice.currentDevice identifierForVendor] UUIDString];
    return identifier.length ? identifier : @"";
}

- (NSString *)getUDID {
    NSData *udidData = [self searchKeychainCopyMatching:TYFoundationNetworkUDIDName];
    NSString *udid = nil;
    if (udidData != nil) {
        NSString *temp = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
        udid = [NSString stringWithFormat:@"%@", temp];
    }
    if (udid.length == 0) {
        udid = [self readPasteBoradforIdentifier:TYFoundationNetworkUDIDName];
    }
    return udid;
}

- (void)saveUDID:(NSString *)udid {
    BOOL saveOk = NO;
    NSData *udidData = [self searchKeychainCopyMatching:TYFoundationNetworkUDIDName];
    if (udidData == nil) {
        saveOk = [self createKeychainValue:udid forIdentifier:TYFoundationNetworkUDIDName];
    } else {
        saveOk = [self updateKeychainValue:udid forIdentifier:TYFoundationNetworkUDIDName];
    }
    if (!saveOk) {
        [self createPasteBoradValue:udid forIdentifier:TYFoundationNetworkUDIDName];
    }
}

- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier {

    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];

    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:TYFoundationKeychainServiceName forKey:(__bridge id)kSecAttrService];

    return searchDictionary;
}

- (NSData *)searchKeychainCopyMatching:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];

    CFDataRef result = nil;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary,
                        (CFTypeRef *)&result);
    return (__bridge NSData *)result;
}

- (BOOL)createKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setValue:passwordData forKey:(__bridge id)kSecValueData];

    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    return status == errSecSuccess;
}

- (BOOL)updateKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setValue:passwordData forKey:(__bridge id)kSecValueData];
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                    (__bridge CFDictionaryRef)updateDictionary);
    return status == errSecSuccess;
}

- (void)deleteKeychainValue:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
}


- (void)createPasteBoradValue:(NSString *)value forIdentifier:(NSString *)identifier {
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:TYFoundationKeychainServiceName create:YES];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:value forKey:identifier];
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [pb setData:dictData forPasteboardType:TYFoundationPasteboardType];
}

- (NSString *)readPasteBoradforIdentifier:(NSString *)identifier {
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:TYFoundationKeychainServiceName create:YES];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[pb dataForPasteboardType:TYFoundationPasteboardType]];
    return [dict objectForKey:identifier];
}

@end
