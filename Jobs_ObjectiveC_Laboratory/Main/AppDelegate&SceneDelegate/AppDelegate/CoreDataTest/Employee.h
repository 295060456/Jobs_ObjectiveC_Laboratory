//
//  Employee.h
//  Jobs_ObjectiveC_Laboratory
//
//  Created by Jobs on 2021/12/1.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSManagedObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *height;
@property(nonatomic,strong)NSDate *brithday;

@end

NS_ASSUME_NONNULL_END
