//
//  UIDevice+TYHardware.h
//  YaboGames
//
//  Created by windy on 21/04/2019.
//  Copyright © 2019 com.tianyu.mobiledev. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  KNavBarHeight      ([UIDevice ty_fringeScreen] ? 88 : 64)
#define  KStatusHeight      ([UIDevice ty_fringeScreen] ? 44 : 20)
#define  KTabBarHeight      ([UIDevice ty_fringeScreen] ? 83 : 49)
#define  KSafeAreaHeight    ([UIDevice ty_fringeScreen] ? 34 : 0.1)

NS_ASSUME_NONNULL_BEGIN


@interface UIDevice (TYHardware)

/// iPhone4,4s
+ (BOOL)iPhone4S;
/// iPhone5,5s,5c,SE
+ (BOOL)iPhone5CS;
/// iPhone6,6s,7,8
+ (BOOL)iPhone678;
/// iPhone6+,6s+,7+,8+
+ (BOOL)iPhone678P;
/// iPhoneX,Xs
+ (BOOL)iPhoneXS;
/// iPhone XR
+ (BOOL)iPhoneXR;
/// iPhone Xs Max
+ (BOOL)iPhoneXSMax;
/// iPhone SE 第二代最新版
+ (BOOL)iPhoneSEGen2;

+ (BOOL)iPhone12Mini;
+ (BOOL)iPhone12;
+ (BOOL)iPhone12ProMax;
// 手机是否刘海屏
+ (BOOL)ty_fringeScreen;

/// 手机型号-原始 eg: iPhone10,1
+ (NSString *)ty_platform;
/// 手机型号 eg:iPhone XS
+ (NSString *)ty_platformString;
/// 手机模型d eg:iPhone 11,1
+ (NSString *)deviceModel;
/// mac地址
+ (NSString *)ty_macAddress;

//Return the current device CPU frequency
+ (NSUInteger)ty_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)ty_busFrequency;
//current device RAM size
+ (NSUInteger)ty_ramSize;
//Return the current device CPU number
+ (NSUInteger)ty_cpuNumber;
//Return the current device total memory

/// 获取iOS系统的版本号
+ (NSString *)ty_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)ty_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)ty_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)ty_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)ty_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)ty_totalDiskSpaceBytes;

@end

NS_ASSUME_NONNULL_END
