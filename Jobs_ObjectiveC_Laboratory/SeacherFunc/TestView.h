//
//  TestView.h
//  Search
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestView : UIView

+ (void)print:(id)firstArg, ... NS_REQUIRES_NIL_TERMINATION;//第一个参数写：有多少个实际参数 用NSNumber表示 @1

@end

NS_ASSUME_NONNULL_END
