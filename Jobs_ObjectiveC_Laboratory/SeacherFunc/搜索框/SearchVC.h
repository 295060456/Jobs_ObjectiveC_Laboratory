//
//  SearchVC.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+Margin.h"
#import "UIViewController+BaseVC.h"
#import "MacroDef_Cor.h"
#import "MacroDef_Size.h"
#import "MacroDef_App.h"
#import "UIView+Extras.h"

#if __has_include(<GKNavigationBar/GKNavigationBar.h>)
#import <GKNavigationBar/GKNavigationBar.h>
#else
#import "GKNavigationBar.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface SearchTBVCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;

@end

@interface SearchVC : UIViewController

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataMutArr;

@end

NS_ASSUME_NONNULL_END
