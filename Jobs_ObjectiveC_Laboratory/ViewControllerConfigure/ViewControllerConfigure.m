//
//  ViewControllerConfigure.m
//  Test
//
//  Created by Jobs on 22/10/2021.
//

#import "ViewControllerConfigure.h"
#import "Aspects.h"

@implementation ViewControllerConfigure
/**
 
 1、借助 load 方法，实现代码无任何入侵性。
 
 当类被引用进项目的时候就会执行load函数(在main函数开始执行之前）,与这个类是否被用到无关,每个类的load函数只会自动调用一次。
 除了这个案列，在实际开发中笔者曾这么用过load方法，将app启动后的广告逻辑相关代码全部放到一个类中的load方法，实现广告模块对项目的无入侵性。
 initialize在类或者其子类的第一个方法被调用前调用。即使类文件被引用进项目,但是没有使用,initialize不会被调用。
 由于是系统自动调用，也不需要再调用 [super initialize] ，否则父类的initialize会被多次执行。

 2、不单单可以替换loadView和viewWillAppear方法，还可以替换控制器其他生命周期相关方法，在这些方法中实现对控制器的统一配置。如view背景颜色、统计事件等。

 3、控制器中避免不了还会拓展一些方法，如无网络数据提示图相关方法，此时可以借助Category实现，在无法避免使用属性的情况下，可以借助运行时添加属性。
 
 */
+ (void)load{
    [super load];
    [ViewControllerConfigure sharedInstance];
}

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static ViewControllerConfigure *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = ViewControllerConfigure.new;
    });return sharedInstance;
}

- (instancetype)init{
    if (self = [super init]) {
        /* 在这里做好方法拦截 */
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                                  withOptions:AspectPositionAfter
                                   usingBlock:^(id aspectInfo,
                                                BOOL animated){
            [self viewWillAppear:animated
                  viewController:[aspectInfo instance]];
        } error:NULL];
    }return self;
}
/*
   下面的这些方法中就可以做到自动拦截了。
    所以在你原来的架构中，大部分封装UIViewController的基类或者其他的什么基类，都可以使用这种方法让这些基类消失。
 */
#pragma mark - fake methods
- (void)loadView:(UIViewController *)viewController{
    NSLog(@" loadView");
}

- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController{
    /* 你可以使用这个方法进行打日志，初始化基础业务相关的内容 */
    NSLog(@"viewWillAppear");
}

@end
