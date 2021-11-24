//
//  TestBlock.h
//  Search
//
//  Created by Jobs on 2020/8/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestBlock : NSObject

@property(readonly)TestBlock *(^testBlock)(int t);

@end

NS_ASSUME_NONNULL_END
