//
//  NSBundle+XYQInfomation.h
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// https://www.jianshu.com/p/534eccb63974
/// https://www.cnblogs.com/XYQ-208910/p/11661872.html
@interface NSBundle (XYQInfomation)

///获取当前工程下自己创建的所有类
+ (NSArray <Class> *)xyq_bundleOwnClassesInfo;
///获取当前工程下所有类（含系统类、cocoPods类）
+ (NSArray <NSString *> *)xyq_bundleAllClassesInfo;

@end

NS_ASSUME_NONNULL_END
