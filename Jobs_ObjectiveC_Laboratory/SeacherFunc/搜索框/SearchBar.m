//
//  SearchBar.m
//  Feidegou
//
//  Created by Kite on 2019/11/24.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar ()

@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,copy)FourDataBlock block;
@property(nonatomic,copy)MKDataBlock block2;

@end

@implementation SearchBar

- (instancetype)init{
    if (self = [super init]) {
//        self.backgroundColor = KYellowColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    self.cancelBtn.alpha = 1;
    self.textField.alpha = 1;
}

-(void)actionBlock:(FourDataBlock _Nullable)block{
    self.block = block;
}

-(void)clickBlock:(MKDataBlock _Nullable)block{
    self.block2 = block;
}
#pragma mark —— 点击事件
-(void)cancelBtnClickEvent:(UIButton *)sender{
    if (self.block2) {
        self.block2(sender);
    }
}
#pragma mark —— UITextFieldDelegate
//询问委托人是否应该在指定的文本字段中开始编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
//告诉委托人在指定的文本字段中开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
//询问委托人是否应在指定的文本字段中停止编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(textField,
                   self,
                   @"",
                   NSStringFromSelector(_cmd));
    }
}
//告诉委托人对指定的文本字段停止编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason;
//询问委托人是否应该更改指定的文本
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string{//实现逐词搜索
    return YES;
}
//询问委托人是否应删除文本字段的当前内容
//- (BOOL)textFieldShouldClear:(UITextField *)textField;
//询问委托人文本字段是否应处理按下返回按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}
#pragma mark —— lazyLoad
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self
                       action:@selector(cancelBtnClickEvent:)
             forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.backgroundColor = kWhiteColor;
        _cancelBtn.uxy_acceptEventInterval = 1;
        [UIView cornerCutToCircleWithView:_cancelBtn
                          andCornerRadius:3.f];
        [UIView colourToLayerOfView:_cancelBtn
                         withColour:KLightGrayColor
                     andBorderWidth:0.5f];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(KWidth(-20));
            make.top.equalTo(self).offset(KWidth(10));
            make.bottom.equalTo(self).offset(KWidth(-10));
            make.width.mas_equalTo(KWidth(50));
        }];
    }return _cancelBtn;
}

-(ZYTextField *)textField{
    if (!_textField) {
        _textField = ZYTextField.new;
        _textField.delegate = self;
        _textField.placeholder = self.placeholderStr;
        
        @weakify(self)
        [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            NSLog(@"MMM = %@",x);
            if (self.block) {
                self.block(self->_textField,
                           self,
                           x,
                           NSStringFromSelector(_cmd));
            }
        }];
        
        [UIView colourToLayerOfView:_textField
                         withColour:KLightGrayColor
                     andBorderWidth:0.5f];
        [UIView cornerCutToCircleWithView:_textField
                          andCornerRadius:3.f];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(KWidth(20));
            make.top.equalTo(self.cancelBtn);
            make.bottom.equalTo(self.cancelBtn);
            make.width.mas_equalTo(SCREEN_WIDTH - KWidth(20 * 2 + 10 + 50));
        }];
    }return _textField;
}

-(NSString *)placeholderStr{
    if (!_placeholderStr) {
        _placeholderStr = @"请输入查询信息";
    }return _placeholderStr;
}

-(NSMutableArray *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
    }return _dataMutArr;
}

@end
