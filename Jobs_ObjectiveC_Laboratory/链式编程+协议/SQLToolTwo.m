//
//  SQLToolTwo.m
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import "SQLToolTwo.h"

@interface SQLToolTwo()

@property (nonatomic, strong) NSString *sql;

@end

@implementation SQLToolTwo

+ (NSString *)makeSQL:(void(^)(SQLToolTwo *tool))block {
    if (block) {
        SQLToolTwo *tool = SQLToolTwo.new;
        block(tool);
        return tool.sql;
    }return nil;
}

- (SelectTwo)selectTwo {
    return ^(NSArray *columns) {
        self.sql = @"select 筛选的结果";
        return self;
    };
}

- (FromTwo)fromTwo{
    return ^(NSString *tableName) {
        self.sql = @"from 筛选的结果";
        return self;
    };
}

- (WhereTwo)whereTwo{
    return ^(NSString *conditionStr){
        self.sql = @"where 筛选的结果";
        return self;
    };
}

@end
