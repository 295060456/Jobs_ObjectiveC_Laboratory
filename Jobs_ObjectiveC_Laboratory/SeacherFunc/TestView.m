//
//  TestView.m
//  Search
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TestView.h"

@implementation TestView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [TestView addButtonAnimation:self];
}

+ (void)print:(id)firstArg, ... NS_REQUIRES_NIL_TERMINATION {//第一个参数写：有多少个实际参数 用NSNumber表示 @1
    if (firstArg) {
        // 取出第一个参数
//        NSLog(@"%@", firstArg);
        // 定义一个指向个数可变的参数列表指针；
        va_list args;
        // 用于存放取出的参数
        id arg = nil;
        // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
        va_start(args, firstArg);
        // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
        if ([firstArg isKindOfClass:NSNumber.class]) {
            NSNumber *num = (NSNumber *)firstArg;
            for (int i = 0; i < num.intValue; i++) {
                arg = va_arg(args, id);
                NSLog(@"KKK = %@", arg);
            }
        }
        // 清空参数列表，并置参数指针args无效
        va_end(args);
    }
}

+ (void)addButtonAnimation:(UIView *)sender{
    sender.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0
                                 options:0
                              animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0
                                relativeDuration:1 / 3.0
                                      animations: ^{
            sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0
                                relativeDuration:1/3.0
                                      animations: ^{
            sender.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0
                                relativeDuration:1/3.0
                                      animations: ^{

            sender.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}


@end
