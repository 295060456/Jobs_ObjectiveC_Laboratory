//
//  SeacherFuncVC.m
//  Search
//
//  Created by Jobs on 2020/7/31.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SeacherFuncVC.h"
#import "SeacherFuncVC+Category.h"

@interface SeacherFuncVC ()

@property(nonatomic,strong)BRDatePickerView *datePickerView;//时间选择器
@property(nonatomic,strong)BRPickerStyle *customStyle;
@property(nonatomic,strong)BRAddressPickerView *addressPickerView;//地址选择器
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)TestView *testView;

@property(nonatomic,strong)SuspendBtn *spButton;

@end

@implementation SeacherFuncVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
    
    self.btn.alpha = 1;
    self.testView.alpha = 1;
    
    self.spButton = SuspendBtn.new;
    self.spButton.vc = self;
    self.spButton.frame = CGRectMake(SCREEN_WIDTH - 71,
                                     300,
                                     66,
                                     66);
    
    [self.view addSubview:self.spButton];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
//    NSString *fileFolderPathStr = [FileFolderHandleTool BundleFile:@"Others"
//                                                       ToLocalFile:@"QQQ"
//                                                   localFileSuffix:@"/QQQ.mp4"
//                                                          fileType:VIDEO];
    
    NSString *fileFolderPathStr = [FileFolderHandleTool bundleFile:nil
                                                       toLocalFile:@"QQQ"
                                                   localFileSuffix:@"/QQQ.mp4"
                                                          fileType:VIDEO
                                                             error:nil];
    
    [self KKK:fileFolderPathStr];

}
///写文件并删除
-(void)KKK:(NSString *)fileFolderPathStr{
    BOOL d = [NSString isNullString:fileFolderPathStr];
    if (!d) {
        [FileFolderHandleTool delFile:@[fileFolderPathStr]
                           fileSuffix:@"mp4"
                                error:nil];//删除文件夹📂路径下的文件

        [self getVedioDuringTimeWithfilePath:[NSString stringWithFormat:@"%@%@",fileFolderPathStr,@"/kkk.mp4"]];
    }
}
///获取视频文件的总时长
-(CGFloat)getVedioDuringTimeWithfilePath:(NSString *)filePathStr{
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePathStr];
    AVURLAsset *sourceAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    CMTime duration = sourceAsset.duration;
    CGFloat second = (float)duration.value / (float)duration.timescale;
    return second;
}

-(CGFloat)getVedioDuringTimeWithUrlAsset:(AVURLAsset *)urlAsset{
    CMTime duration = urlAsset.duration;
    CGFloat second = (float)duration.value / (float)duration.timescale;
    return second;
}

-(void)search{
    [UIViewController comingFromVC:self
                              toVC:SearchVC.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:nil
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {
        
    }];
}
//datePickerView
-(void)DatePickerView{
    //    [self.datePickerView show];
}
//可变参数的使用
-(void)variableParameter{
    //    NSNumber *b = [NSNumber numberWithShort:4.5];
    //    [TestView print:@3,
    //     @"1",
    //     b,
    //     @[@"1",@"2"],
    //     nil];
}
//runtime
-(void)RT{
    //    self.ly_name = @"hello world";
    //
    //    NSLog(@"%@",self.ly_name);
}
//block的高级使用
-(void)block{
    //    self.tsb.testBlock(1);//?
}
//Proxy 的使用
-(void)Proxy{
    GTProxy *px = [GTProxy alloc];
    NSMutableArray *array =  [NSMutableArray array];
    [px transformToObject:array];
    [px performSelector:@selector(addObject:) withObject:@"123"];
    NSLog(@"%@",array);

    NSMutableString *string = [NSMutableString string];
    [px transformToObject:string];
    [px performSelector:@selector(appendString:) withObject:@"jia"];
    NSLog(@"%@",string);
}
#pragma mark —— lazyLoad
-(UIButton *)btn{
    if (!_btn) {
        _btn = UIButton.new;
        _btn.backgroundColor = kBlueColor;
        [self.view addSubview:_btn];
        _btn.frame = CGRectMake(100, 100, 100, 100);
        [_btn addTarget:self
                 action:@selector(addButtonAnimation:)
       forControlEvents:UIControlEventTouchUpInside];
    }return _btn;
}

-(TestView *)testView{
    if (!_testView) {
        _testView = TestView.new;
        _testView.backgroundColor = KYellowColor;
        [self.view addSubview:_testView];
        [_testView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btn.mas_bottom).offset(10);
            make.left.equalTo(self.btn);
            make.size.mas_equalTo(self.btn);
        }];
    }
    return _testView;
}

- (void)addButtonAnimation:(UIButton *)sender{
    sender.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:0.5
                                   delay:0
                                 options:0
                              animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0
                                relativeDuration:1 / 3.0
                                      animations: ^{
            sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0
                                relativeDuration:1/3.0
                                      animations: ^{
            sender.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0
                                relativeDuration:1/3.0
                                      animations: ^{

            sender.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:nil];
}

-(BRDatePickerView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = BRDatePickerView.new;
        _datePickerView.pickerMode = BRDatePickerModeYMD;
        _datePickerView.title = @"选择年月日";
        _datePickerView.pickerStyle.pickerTextColor = kRedColor;
        // datePickerView.selectValue = @"2019-10-30";
        _datePickerView.selectDate = [NSDate br_setYear:2019
                                                  month:10
                                                    day:30];
        _datePickerView.minDate = [NSDate br_setYear:1949
                                               month:3
                                                 day:12];
        _datePickerView.maxDate = [NSDate date];
        _datePickerView.isAutoSelect = YES;
        @weakify(self)
        _datePickerView.resultBlock = ^(NSDate *selectDate,
                                        NSString *selectValue) {
            @strongify(self)
            NSLog(@"选择的值：%@", selectValue);

        };
        // 设置自定义样式
        _datePickerView.pickerStyle = self.customStyle;
    }return _datePickerView;
}

-(BRPickerStyle *)customStyle{
    if (!_customStyle) {
        _customStyle = BRPickerStyle.new;
        _customStyle.pickerColor = BR_RGB_HEX(0xd9dbdf, 1.0f);
        _customStyle.cancelBorderStyle = BRBorderStyleSolid;
        _customStyle.hiddenMaskView = YES;
        _customStyle.cancelBtnTitle = @"取消";
        _customStyle.pickerTextColor = kRedColor;
        _customStyle.separatorColor = kGrayColor;
    }return _customStyle;
}

-(BRAddressPickerView *)addressPickerView{
    if (!_addressPickerView) {
        _addressPickerView = BRAddressPickerView.new;
        _addressPickerView.pickerMode = BRAddressPickerModeArea;
        _addressPickerView.title = @"请选择地区";
        //_addressPickerView.selectValues = @[@"浙江省", @"杭州市", @"西湖区"];
        _addressPickerView.selectIndexs = @[@10, @0, @4];
        _addressPickerView.isAutoSelect = YES;
        @weakify(self)
        _addressPickerView.resultBlock = ^(BRProvinceModel *province,
                                           BRCityModel *city,
                                           BRAreaModel *area) {
            @strongify(self)
            NSLog(@"选择的值：%@", [NSString stringWithFormat:@"%@-%@-%@", province.name, city.name, area.name]);

        };
    }return _addressPickerView;
}



@end
