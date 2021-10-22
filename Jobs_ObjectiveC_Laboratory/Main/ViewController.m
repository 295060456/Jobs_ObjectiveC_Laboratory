//
//  ViewController.m
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import "ViewController.h"
#import "NSBundle+XYQInfomation.h"
#import "DataTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self test_Objc_GetClassList];
}
/// 测试：
-(void)test_Objc_GetClassList {
    
    //全部类
    //NSArray *classes = [NSBundle xyq_bundleAllClassesInfo];
    
    //自定义类
    NSArray *classes = [NSBundle xyq_bundleOwnClassesInfo];
    for (NSString *className in classes) {
        NSLog(@"className = %@",className);
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DataTableViewController.new.isqqEnable;
    [self presentViewController:DataTableViewController.new animated:YES completion:nil];
}

@end
