//
//  GTProxy.h
//  Search
//
//  Created by Jobs on 2020/8/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTProxy : NSProxy

- (id)transformToObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
