//
//  NSString+TYAdd.h
//  Project
//
//  Created by Hoard on 01/03/2019.
//  Copyright © 2019 com.tianyu.mobiledev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define EMPTY_IF_NIL(str) (str == nil ? @"" : (str == (id)[NSNull null] ? @"" : str))

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TYAdd)
-(BOOL)isNineKeyBoard;
/// 验证真实姓名
- (BOOL)validateRealName;
- (BOOL)validateSimpleRealName;
- (BOOL)isRealNameValid;

/// 验证数字
- (BOOL)validateNumber;
///验证字符
- (BOOL)validateABC;
/// 验证字母和数字
- (BOOL)validateText;
///验证字母和数字 _-
- (BOOL)validateNewText;
/// 用户名校验
- (BOOL)validateAccountText;
/// 密码校验
- (BOOL)validatePasswordText;
// 手机号校验严谨方式
- (BOOL)validatePhoneNumberByStrict;
/// 手机号校验
- (BOOL)validatePhoneNumber;
/// 验证银行卡
- (BOOL)validateBankCard;
/// 邮箱校验
- (BOOL)validateEmail;
/// 验证金额- 9位
- (BOOL)validateAmount;
/// 验证金额- 32位
-(BOOL)validate32LengthAmount;
/// 验证金额- 13位
-(BOOL)validate13LengthPrice;
/// 非空校验
- (BOOL)isString;
///是否中文
- (BOOL)isChinese;

- (BOOL)validatePrice;

- (BOOL )isNotNilOrWhiteSpaceString;

-(BOOL)validate32LengthPrice;

/// 判断是否是空，如果是nil或NSNull或不是NSString类型或""都会返回YES
+(BOOL)isEmptySring:(id)string;
+(BOOL)isNotEmptySring:(id)string;
/// 将全数字的银行卡号按四位一组进行分组，除最后一组外，其他组的每个数字用*代替，每组间用空格连接
- (NSString *)secretBankCardNum;

- (NSString *)digitFormat;

/// 给特定的文案赋予颜色，其余为detaultColor
- (NSAttributedString *)attributedChangeAttributeText:(NSString *)attrStr
                                                color:(UIColor *)attrColor
                                     defaultTextColor:(UIColor *)detault;

- (NSAttributedString *)attributedChangeAttributeText:(NSString *)attrStr color:(UIColor *)attrColor defaultTextColor:(UIColor *)detault font:(nullable UIFont *)font;
/**
 属性字符串size

 @param maxWidth 最大宽度
 @param maxHeight 最大高度
 @param lineSpece 行间距
 @param font 字体
 @return size
 */
- (CGSize)attributedStringSizeWithMaxWidth:(CGFloat)maxWidth
                                 maxHeight:(CGFloat)maxHeight
                                 lineSpece:(CGFloat)lineSpece
                                      font:(UIFont *)font;
/**
 给特定的文案[数组]赋予颜色[数组]

 @param defaultColor 默认颜色
 @param subStrings 文案数组
 @param subColors 颜色数组
 @return return value description
 */
- (NSAttributedString *)attributedStringWithDefalutColor:(UIColor *)defaultColor
                                              subStrings:(NSArray <NSString *> *)subStrings
                                               subColors:(NSArray <UIColor *> *)subColors;

- (NSMutableAttributedString *)attributedStringWithDefalutColor:(UIColor *)defaultColor
                                            subStrings:(nullable NSArray <NSString *> *)subStrings
                                             subColors:(nullable NSArray <UIColor *> *)subColors
                                              subFonts:(nullable NSArray <UIFont *> *)subFonts;
/**
 属性字符串高度获取
 
 @param width 最大宽度
 @param lineSpece 行间距
 @param fontSize 字体大小
 @return 高度
 */
- (CGFloat)attributedStringHeightWithMaxWidth:(CGFloat)width
                                    lineSpece:(CGFloat)lineSpece
                                     fontSize:(CGFloat)fontSize;
/**
 属性字符串高度获取
 
 @param timeStr 目前时间字符串
 @param timeFormat 原有改成的时间格式
 */
+ (NSString *)dateStrFormatBy188TimeStr:(NSString *)timeStr timeFormat:(NSString *)timeFormat;
/**
 @param timeStr 目前时间字符串
 @param timeFormat 原有改成的时间格式
 @param toBeFormat 想要变的时间格式
**/
+ (NSString *)dateStrFormat:(NSString *)timeStr timeFormFormat:(NSString *)timeFormat toFormat:(NSString *)toBeFormat;
- (NSMutableAttributedString *)attributedStringWithsubStrings:(NSArray <NSString *> *)subStrings subFonts:(NSArray <UIFont *> *)subFonts;
//默认188数据时间格式
+ (NSString *)dateStrFormatBy188TimeStr:(NSString *)timeStr;
- (NSString *)ty_floatValWithPoint:(NSInteger)pointNum;
- (NSString *)ty_floatValWithTwoPoint;
- (NSString *)ty_urlAddQueryWithKey:(NSString *)key value:(NSString *)value;
// 去掉千分位等影响
- (CGFloat)ty_floatValue;
- (NSString *)ty_trimPreTxt:(NSString *)preTxt;
@end

static inline NSString * TwoPointText(NSString *text){
    return EMPTY_IF_NIL([text ty_floatValWithTwoPoint]);
}

static inline CGFloat FloatValFromText(NSString *text){
    if ([text isKindOfClass:[NSNumber class]]) {
        return text.floatValue;
    }
    if ([text isKindOfClass:[NSString class]]) {
        text = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
        return text.floatValue;
    }
    return 0.0;
}

static inline NSString * TwoPointNumber(CGFloat text){
    return EMPTY_IF_NIL([@(text).stringValue ty_floatValWithTwoPoint]);
}

static inline NSString * PointText(NSString *text,NSInteger count){
    return EMPTY_IF_NIL([text ty_floatValWithPoint:count]);
}

static inline NSString * TYErrorCodeMessage(NSString *message,NSInteger code) {
    NSString *codeMsg = [NSString stringWithFormat:@"%ld", code * 2 + 3];
    NSString *fMessage = message;
    NSString *innerCode = nil;
    if([message containsString:@"("] && [message containsString:@")"]){
       NSString *tempCode = [message componentsSeparatedByString:@"("].lastObject;
        tempCode = [tempCode componentsSeparatedByString:@")"].firstObject;
        if ([tempCode integerValue] != 0) {
            innerCode = tempCode;
        }
    }
    if (![fMessage containsString:codeMsg] && code>0 && innerCode == nil) {
        fMessage= [NSString stringWithFormat:@"%@(%ld)", message, code * 2 + 3];
    }
    return fMessage;
}

NS_ASSUME_NONNULL_END
