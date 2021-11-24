//
//  TestBlock.m
//  Search
//
//  Created by Jobs on 2020/8/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TestBlock.h"

@implementation TestBlock

-(TestBlock * _Nonnull (^)(int))testBlock{
    return ^(int t){
        NSLog(@"%d",t);
        return self;
    };
}

@end
