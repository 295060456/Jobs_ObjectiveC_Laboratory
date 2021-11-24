//
//  SeacherFuncVC+Category.h
//  Search
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SeacherFuncVC.h"

struct ClickSize {
    CGFloat top;
    CGFloat left;
    CGFloat bottom;
    CGFloat right;
};
typedef struct ClickSize ClickSize;

CG_INLINE ClickSize
ClickSizeMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
{
    ClickSize clickSize;
    clickSize.top = top;
    clickSize.left = left;
    clickSize.bottom = bottom;
    clickSize.right = right;
    return clickSize;
};

NS_ASSUME_NONNULL_BEGIN

@interface SeacherFuncVC (Category)

@property(nonatomic,strong)NSString *ly_name;

/**
 扩大button的点击范围

 @param size 设置点击区域，控制上、左、下、又的扩大外围
 */
- (void)enlargeClickAreaWithClickArea:(ClickSize)size;

- (void)EnlargeClickAreaWithClickArea:(CGRect)size;

@end

NS_ASSUME_NONNULL_END
