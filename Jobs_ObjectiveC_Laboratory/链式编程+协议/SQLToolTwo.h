//
//  SQLToolTwo.h
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SQLToolTwo;

typedef SQLToolTwo *_Nullable(^SelectTwo)(NSArray *_Nullable columns);
typedef SQLToolTwo *_Nullable(^FromTwo)(NSString *_Nullable tableName);
typedef SQLToolTwo *_Nullable(^WhereTwo) (NSString *_Nullable conditionStr);

@protocol ISelectable
@property (nonatomic, copy, readonly) SelectTwo selectTwo;
@end

@protocol IFromable
@property (nonatomic, copy, readonly) FromTwo fromTwo;
@end

@protocol IWhereable
@property (nonatomic, copy, readonly) WhereTwo whereTwo;
@end

@interface SQLToolTwo : NSObject<ISelectable,IFromable,IWhereable>

+ (NSString *)makeSQL:(void(^)(SQLToolTwo *tool))block;

@end

NS_ASSUME_NONNULL_END
