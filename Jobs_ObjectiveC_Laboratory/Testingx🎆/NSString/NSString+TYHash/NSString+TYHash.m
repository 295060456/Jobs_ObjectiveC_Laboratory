//
//  NSString+TYHash.m
//  TYNetworking
//
//  Created by eagle on 2019/3/14.
//  Copyright © 2019 com.ty. All rights reserved.
//

#import "NSString+TYHash.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (TYHash)

- (NSString *)ty_md5 {
    NSData* inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString* hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
    [hashStr appendFormat:@"%02x", outputData[i]];
    return hashStr;
}

@end
