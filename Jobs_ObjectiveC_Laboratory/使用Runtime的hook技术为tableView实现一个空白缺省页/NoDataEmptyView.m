//
//  NoDataEmptyView.m
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import "NoDataEmptyView.h"

@interface NoDataEmptyView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *label;

@end

@implementation NoDataEmptyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }return self;
}

-(void)setup{
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"empty_body_kong"];
    self.imageView.center = self.center;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.label.text = @"暂无数据";
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.center = CGPointMake(self.imageView.center.x, CGRectGetMaxY(self.imageView.frame)+40);
    
    [self addSubview:self.imageView];
    [self addSubview:self.label];
}

@end
