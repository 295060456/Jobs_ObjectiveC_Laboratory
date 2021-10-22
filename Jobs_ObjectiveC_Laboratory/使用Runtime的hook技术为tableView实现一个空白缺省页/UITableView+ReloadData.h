//
//  UITableView+ReloadData.h
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import <UIKit/UIKit.h>
#import "NoDataEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ReloadData)

@property (nonatomic, strong) NoDataEmptyView *emptyView;

@end

NS_ASSUME_NONNULL_END
