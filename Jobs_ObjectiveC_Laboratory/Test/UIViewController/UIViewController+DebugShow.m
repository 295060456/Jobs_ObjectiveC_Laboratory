//
//  UIViewController+DebugShow.m
//  TEST
//
//  Created by mac on 2019/6/7.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIViewController+DebugShow.h"
#import <objc/runtime.h>

/***
 用于调试时候出现的控制器.
 ***/
@implementation UIViewController (DebugShow)

+ (void)load {
#ifdef DEBUG
    //防止多次交换
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //原本的viewWillAppear方法
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        
        //需要替换成 能够输出日志的viewWillAppear
        Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
        
        //两方法进行交换
        method_exchangeImplementations(viewWillAppear, logViewWillAppear);
    });

#endif
}


- (void)logViewWillAppear:(BOOL)animated {
    
    NSString *className = NSStringFromClass([self class]);
    
    //在这里，你可以进行过滤操作，指定哪些viewController需要打印，哪些不需要打印
    if ([className hasPrefix:@"TYBaseNavigation"] == YES) {
        return;//如果控制器前缀TYBaseNavigation，不打印，跳过
    }else{
        NSLog(@"出现的控制器 -- %@ -- ",className);
        //下面方法的调用，其实是调用viewWillAppear
        [self logViewWillAppear:animated];
    }
}

@end
