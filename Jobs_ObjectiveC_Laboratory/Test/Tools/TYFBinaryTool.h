//
//  TYFBinaryTool.h
//  FirefoxGames
//
//  Created by charlie on 2020/8/13.
//  Copyright © 2020 FirefoxGames. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYFBinaryTool : NSObject
+ (NSString *)convertDataToHexStr:(NSData *)data;
+ (NSString *)getBinaryByHex:(NSString *)hex;
#pragma mark 二进制转十进制
+ (NSInteger )convertDecimalSystemFromBinarySystem:(NSString *)binary;

@end

NS_ASSUME_NONNULL_END
