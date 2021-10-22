//
//  UITableView+ReloadData.m
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import "UITableView+ReloadData.h"
#import <objc/message.h>

static NSString *const NoDataEmptyViewKey = @"NoDataEmptyViewKey";

@implementation UITableView (ReloadData)

#pragma mark - 交换方法 hook
+(void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method currentMethod = class_getInstanceMethod(self, @selector(xyq_reloadData));
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(originMethod, currentMethod);
    });
}

#pragma mark - 刷新数据
-(void)xyq_reloadData {
    [self xyq_reloadData];
    [self fillEmptyView];
}

#pragma mark - 填充空白页
-(void)fillEmptyView {
    
    NSInteger sections = 1;
    NSInteger rows = 0;
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        
        sections = [dataSource numberOfSectionsInTableView:self];
        
        if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (int i=0; i<sections; i++) {
                rows += [dataSource tableView:self numberOfRowsInSection:i];
            }
        }
    }
    
    if (rows == 0) {
        if (![self.subviews containsObject:self.emptyView]) {
            self.emptyView = [[NoDataEmptyView alloc] initWithFrame:self.bounds];
            [self addSubview:self.emptyView];
        }
    }
    else{
        [self.emptyView removeFromSuperview];
    }
}


#pragma mark - 关联对象
-(void)setEmptyView:(NoDataEmptyView *)emptyView {
    objc_setAssociatedObject(self, &NoDataEmptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NoDataEmptyView *)emptyView {
    return objc_getAssociatedObject(self, &NoDataEmptyViewKey);
}

@end
