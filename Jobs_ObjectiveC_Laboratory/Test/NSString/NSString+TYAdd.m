//
//  NSString+TYAdd.m
//  Project
//
//  Created by Hoard on 01/03/2019.
//  Copyright © 2019 com.tianyu.mobiledev. All rights reserved.
//

#import "NSString+TYAdd.h"

@implementation NSString (TYAdd)
#pragma --helper
/**
判断是不是九宫格
@return YES(是九宫格拼音键盘)
*/
-(BOOL)isNineKeyBoard
{
   NSString *other = @"➋➌➍➎➏➐➑➒";
   int len = (int)self.length;
   for(int i=0;i<len;i++)
   {
       if(!([other rangeOfString:self].location != NSNotFound))
           return NO;
   }
   return YES;
}
- (BOOL)validateRealName {
    // ^([\u4e00-\u9fa5]{1,20}|[a-zA-Z\\·\\s]{1,20})$
//    NSString *regex = @"^([\u4e00-\u9fa5]{1,20}|[a-zA-Z\\·\\s]{1,20})$";
    
    // 验证是中英文字符· , 且首尾必须是中英文字符, 长度为 2-24 个字符
    NSString *regex = @"^[a-zA-Z\\u4e00-\\u9fa5][a-zA-Z\\u4e00-\\u9fa5\\·]{0,22}[a-zA-Z\\u4e00-\\u9fa5]$";
    
    /* 如果只有一个字,报错 */
    if (self.length == 1) {
        return NO;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) {
        return NO;
    };
    
    // 验证是否有 · . 和 空格连续
    regex = @"^.*[\\s\\.\\·][\\s\\.\\·].*$";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return NO;
    };
    
    //如果有中文则不允许出现空格
    regex = @"^.*[\\u4e00-\\u9fa5].*[\\s].*[\\u4e00-\\u9fa5]*.*$";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return NO;
    };
    
    return YES;
}
- (BOOL)isRealNameValid {
    NSString *regex = @"^[\u4E00-\u9FA5A-Za-z ·]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
- (BOOL)validateSimpleRealName {
    // ^([\u4e00-\u9fa5]{1,20}|[a-zA-Z\\·\\s]{1,20})$
//    NSString *regex = @"^([\u4e00-\u9fa5]{1,20}|[a-zA-Z\\·\\s]{1,20})$";
    
    // 验证是中英文字符或空格 . · , 且首尾必须是中英文字符, 长度为 2-24 个字符
    NSString *regex = @"^[a-zA-Z\\u4e00-\\u9fa5][a-zA-Z\\u4e00-\\u9fa5\\.\\ \\·]{0,22}[a-zA-Z\\u4e00-\\u9fa5]$";
    
    // 如果只有一个字，验证是否为中文或英文
    if (self.length == 1) { regex = @"[a-zA-Z\\u4e00-\\u9fa5]"; }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) { return NO; };
    
    // 验证是否有 · . 和 空格连续
    regex = @"^.*[\\s\\.\\·][\\s\\.\\·].*$";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) { return NO; };
    
    //如果有中文则不允许出现空格
    regex = @"^.*[\\u4e00-\\u9fa5].*[\\s].*[\\u4e00-\\u9fa5]*.*$";
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) { return NO; };
    
    return YES;
}
- (BOOL)validateNumber {
    if (self.length == 0) {
        return YES;
    }
    NSString *regex = @"^[0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateABC{
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateText {
    if (self.length == 0) {
        return YES;
    }
    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateNewText {
    if (self.length == 0) {
        return YES;
    }
    NSString *regex = @"^[A-Za-z0-9_-]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateAccountText {
    NSString *regex = @"^[A-Za-z0-9]{4,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validatePasswordText {
    NSString *regex = @"[A-Za-z0-9]{6,12}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

// 严谨方式:^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$
// 不太严谨方式：^[1]([3-9])[0-9]{9}$

// 严谨方式
- (BOOL)validatePhoneNumberByStrict {
    NSString *regex = @"^[1]([3-9])[0-9]{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

// 不严谨的当输入12345678901也可以通过
- (BOOL)validatePhoneNumber {
    NSString *regex = @"^1[0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
/* 去掉[A-Z0-9a-z._%+-]中的. */
- (BOOL)validateEmail {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateBankCard {
    NSString *regex = @"^\\d{16,19}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

-(BOOL)validate32LengthPrice{
    NSString *regex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,31}(([.]\\d{0,2})?)))?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

-(BOOL)validate13LengthPrice {
    NSString *regex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,12}(([.]\\d{0,2})?)))?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

-(BOOL)validatePrice{
    NSString *regex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL )isNotNilOrWhiteSpaceString {
    NSString *string = [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    return string.length > 0;
}
+(BOOL)isEmptySring:(id)string {
    if (string == nil) {
        return YES;
    }
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    return ![((NSString *)string) isNotNilOrWhiteSpaceString];
}
+(BOOL)isNotEmptySring:(id)string {
    return ![NSString isEmptySring:string];
}

- (NSString *)secretBankCardNum {
    
     NSInteger length = self.length;
    
     NSInteger countPerGroup = length/4 + ((length%4)?1:0);
    
    if (length <= 4) {
        return self;
    }
    
    NSString *lastForthString = [self substringWithRange:NSMakeRange(length - 4, 4)];

    NSMutableString  *bankCard = [NSMutableString string];

    for (NSInteger i = 0; i < (countPerGroup * 4); i++) {
        [bankCard appendString:@"*"];
        
        if ((i + 1)%4 == 0 && (i + 1) != (countPerGroup * 4)) {
            [bankCard appendString:@" "];
        }
    }
    
    [bankCard replaceCharactersInRange:NSMakeRange(bankCard.length - 4, 4) withString:lastForthString];
   
    return bankCard;
}
- (NSAttributedString *)attributedStringWithDefalutColor:(UIColor *)defaultColor
										   subStrings:(NSArray <NSString *> *)subStrings
											subColors:(NSArray <UIColor *> *)subColors {
	NSParameterAssert(subStrings.count == subColors.count);
	
	NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName: defaultColor}];
	[subStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSRange range = [self rangeOfString:obj];
		[mStr addAttribute:NSForegroundColorAttributeName value:subColors[idx] range:range];
	}];
	
	return [mStr copy];
}
- (NSAttributedString *)attributedChangeAttributeText:(NSString *)attrStr color:(UIColor *)attrColor defaultTextColor:(UIColor *)detault font:(nullable UIFont *)font
{
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:self];
    if(font){
        [attText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    }
    if (attrStr.length == 0) { return attText; }
    NSRange range = [self rangeOfString:attrStr];
    if (range.length == 0 ) {
        [attText addAttribute:NSForegroundColorAttributeName value:detault range:NSMakeRange(0, self.length)];
    }else{
        [attText addAttribute:NSForegroundColorAttributeName value:detault range:NSMakeRange(0, self.length)];
        [attText addAttribute:NSForegroundColorAttributeName value:attrColor range:range];
    }
    return attText;
}

- (CGSize)attributedStringSizeWithMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight lineSpece:(CGFloat)lineSpece font:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if (maxHeight == 0) {
        maxHeight = CGFLOAT_MAX;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpece;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: paraStyle,
                                 }.copy;
    size = [self boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
                                options:(NSStringDrawingUsesLineFragmentOrigin |
                                         NSStringDrawingTruncatesLastVisibleLine)
                             attributes:attributes
                                context:nil].size;
    return size;
}

- (BOOL)isString {
    NSString *string = [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    return string.length > 0;
}

- (BOOL)isChinese{
    NSString *regex = @"^[\u4E00-\u9FA5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

-(BOOL)validateAmount {
    NSString *regex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

-(BOOL)validate32LengthAmount {
    NSString *regex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,31}(([.]\\d{0,2})?)))?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (NSAttributedString *)attributedChangeAttributeText:(NSString *)attrStr color:(UIColor *)attrColor defaultTextColor:(UIColor *)detault {
    
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:self];
    if (attrStr.length == 0) { return attText; }
    NSRange range = [self rangeOfString:attrStr];
    if (range.length == 0 ) {
        [attText addAttribute:NSForegroundColorAttributeName value:detault range:NSMakeRange(0, self.length)];
    }else{
        [attText addAttribute:NSForegroundColorAttributeName value:detault range:NSMakeRange(0, self.length)];
        [attText addAttribute:NSForegroundColorAttributeName value:attrColor range:range];
    }
    return attText;
}


- (CGFloat)attributedStringHeightWithMaxWidth:(CGFloat)width lineSpece:(CGFloat)lineSpece fontSize:(CGFloat)fontSize{
    CGFloat height = 0;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = lineSpece;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName: [UIFont systemFontOfSize:fontSize],
                                 NSParagraphStyleAttributeName: paraStyle,
                                 }.copy;
    height = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                options:(NSStringDrawingUsesLineFragmentOrigin |
                                         NSStringDrawingTruncatesLastVisibleLine)
                             attributes:attributes
                                context:nil].size.height;
    
    return height;
}
- (NSMutableAttributedString *)attributedStringWithDefalutColor:(UIColor *)defaultColor
                                              subStrings:(NSArray <NSString *> *)subStrings
                                               subColors:(NSArray <UIColor *> *)subColors
                                               subFonts:(NSArray <UIFont *> *)subFonts {
    NSParameterAssert(subStrings.count == subColors.count);
    
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName: defaultColor}];
    [subStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [self rangeOfString:obj];
        if(subColors.count > idx){
            [mStr addAttribute:NSForegroundColorAttributeName value:subColors[idx] range:range];
        }
        if (subFonts.count > idx) {
            [mStr addAttribute:NSFontAttributeName value:subFonts[idx] range:range];
        }
    }];
    
    return mStr;
}

+ (NSString *)dateStrFormatBy188TimeStr:(NSString *)timeStr timeFormat:(NSString *)timeFormat {
    
    if (timeStr.length == 0) {
        return timeStr;
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = timeFormat;
    NSDate *date = [fmt dateFromString:timeStr];
    
    fmt.dateFormat = @"MM/dd HH:mm";
    NSString *timString = [fmt stringFromDate:date];
    
    return timString;
}
+ (NSString *)dateStrFormat:(NSString *)timeStr timeFormFormat:(NSString *)timeFormat toFormat:(NSString *)toBeFormat {
    
    if (timeStr.length == 0) {
        return timeStr;
    }
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = timeFormat;
    NSDate *date = [fmt dateFromString:timeStr];
    if (!date) {
        return timeStr;
    }
    fmt.dateFormat = toBeFormat;
    NSString *timString = [fmt stringFromDate:date];
    
    return timString;
}

- (NSMutableAttributedString *)attributedStringWithsubStrings:(NSArray <NSString *> *)subStrings
                                                       subFonts:(NSArray <UIFont *> *)subFonts {
    
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:self];
    [subStrings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [self rangeOfString:obj];
        if (subFonts.count > idx) {
            [mStr addAttribute:NSFontAttributeName value:subFonts[idx] range:range];
        }
    }];
    return mStr;
}

+ (NSString *)dateStrFormatBy188TimeStr:(NSString *)timeStr {
    
    if (timeStr.length == 0) {
        return timeStr;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"dd / MM yyyy HH:mm:ss";
    NSDate *date = [fmt dateFromString:timeStr];
    
    fmt.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSString *timString = [fmt stringFromDate:date];
    
    return timString;
}

- (NSString *)ty_urlAddQueryWithKey:(NSString *)key value:(NSString *)value {
    NSString *urlStr = self;
    if ([NSString isEmptySring:key] || [NSString isEmptySring:value]) {
        return urlStr;
    }
    
    NSArray *pathComponents = nil;
    if ([urlStr rangeOfString:@"?"].location != NSNotFound) {
        NSString *query = [urlStr componentsSeparatedByString:@"?"].lastObject;
        NSArray *tempPathComponents = [query componentsSeparatedByString:@"&"];
        NSMutableArray *pathComponentsM = [NSMutableArray array];
        for (NSString *item in tempPathComponents) {
            if ([NSString isNotEmptySring:item]) {
                [pathComponentsM addObject:item];
            }
        }
        pathComponents = pathComponentsM;
        
    }
    if (pathComponents == nil) {
        // 没有问号 如：http://www.baidu.com
        urlStr = [NSString stringWithFormat:@"%@?%@=%@", urlStr, key,value];
    }else if (pathComponents.count == 0) {
        // 有问号但没有具体参数，这个情况及其少见如：http://www.baidu.com?
        urlStr = [NSString stringWithFormat:@"%@%@=%@", urlStr, key,value];
    }
    else{
       // 有问号有参数如：http://www.baidu.com?name=who
        NSString *findItem;
        for (NSString *item in pathComponents) {
            if ([item hasPrefix:[NSString stringWithFormat:@"%@=",key]]) {
                findItem = item;
                break;
            }
        }
        if ([NSString isNotEmptySring:findItem]) {
            // 找到了同名参数
            urlStr = [urlStr stringByReplacingOccurrencesOfString:findItem withString:[NSString stringWithFormat:@"%@=%@",key,value]];
        }else{
            // 未找到同名参数
           urlStr = [NSString stringWithFormat:@"%@&%@=%@", urlStr, key,value];
        }
    }
        
    return urlStr;
}
- (NSString *)ty_floatValWithPoint:(NSInteger)pointNum {
    NSString *floatValStr = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *format = [NSString stringWithFormat:@"%%.%ldf",pointNum];
    return [NSString stringWithFormat:format,floatValStr.floatValue];
}

- (NSString *)ty_floatValWithTwoPoint {
    return [self ty_floatValWithPoint:2];
}

- (CGFloat)ty_floatValue {
    NSString *text = self;
    // 解决英文逗号
    text = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
    // 解决中文逗号
    text = [text stringByReplacingOccurrencesOfString:@"，" withString:@""];
    // 解决美元逗号
    text = [text stringByReplacingOccurrencesOfString:@"$" withString:@""];
    // 解决人民币逗号
    text = [text stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    return text.floatValue;
}
- (NSString *)ty_trimPreTxt:(NSString *)preTxt {
    NSString *txt = self;
    while (txt.length>0 && [txt hasPrefix:preTxt]) {
        txt = [txt substringFromIndex:preTxt.length];
    }
    return txt;
}
@end
