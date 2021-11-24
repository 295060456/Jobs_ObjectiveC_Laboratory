//
//  SeacherFuncVC.h
//  Search
//
//  Created by Jobs on 2020/7/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestBlock.h"
#import "SearchVC.h"
#import "TestView.h"
#import "UIView+SuspendView.h"
#import "SuspendBtn.h"
#import "NSString+Extras.h"
#import "GTProxy.h"
#import "FileFolderHandleTool.h"

#if __has_include(<BRPickerView/BRPickerView.h>)
#import <BRPickerView/BRPickerView.h>
#else
#import "BRPickerView.h"
#endif

@interface SeacherFuncVC : UIViewController

@property(nonatomic,strong)TestBlock *tsb;

@end

