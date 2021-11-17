//
//  UIDevice+TYDeviceInfo.h
//  TYNetworking
//
//  Created by eagle on 2019/3/14.
//  Copyright © 2019 com.ty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (TYDeviceInfo)

/** APP 外部版本号*/
- (NSString *) ty_appVersion;
/** APP 编译号*/
- (NSString *) ty_buildNumber;
/** App Bundle id */
- (NSString *) ty_bundleIdentifier;
/** 手机操作系统版本 */
- (NSString *) ty_system_version;
/** App CFBundleDisplayName app打包后的名称*/
- (NSString *)ty_appName;

/** 获取磁盘大小*/
- (long) ty_diskTotalSize;
/** 获取磁盘剩余空间大小 */
- (long) ty_diskFreeSize;
/** 获取电量 */
- (CGFloat)ty_batteryLevel;
/** 获取电池状态 */
- (NSString *)ty_batteryState;
/** 获取屏幕尺寸 */
- (CGSize)ty_screenSize;
/** 获取屏幕亮度 */
- (CGFloat)ty_screenBrightness;
/** 是否使用了代理 */
- (BOOL)ty_isViaProxy;
/** 获取 uuid */
- (NSString *) ty_uuid;
/** 获取 idfa */
- (NSString *) ty_idfa;
/** 获取 udid */
- (NSString *) ty_udid;
/** mac 地址*/
- (NSString *) ty_macaddress;
/** mac 地址 MD5*/
- (NSString *) ty_macaddressMD5;
/** 获取iOS 设备类型 */
- (NSString *) ty_machineType;
/** 是否是有留海 */
- (BOOL)ty_isIphoneXGroup;

@end

NS_ASSUME_NONNULL_END
