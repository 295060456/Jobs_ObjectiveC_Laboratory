//
//  SeacherFuncVC+Category.m
//  Search
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SeacherFuncVC+Category.h"
#import <objc/runtime.h>

@implementation SeacherFuncVC (Category)

@dynamic ly_name;
static char *name;

//static char *BaseVC_TZImagePickerController_maxImagesCount = "setLy_name";
//static char *BaseVC_TZImagePickerController_columnNumber = "ly_name";

static char *topNameKey = "topNameKey";
static char *rightNameKey = "rightNameKey";
static char *bottomNameKey = "bottomNameKey";
static char *leftNameKey = "leftNameKey";

static char *originX = "originX";
static char *originY = "originY";
static char *sizeW = "sizeW";
static char *sizeH = "sizeH";

- (void)setLy_name:(NSString *)ly_name{
    objc_setAssociatedObject(self, name, ly_name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)ly_name{
    return objc_getAssociatedObject(self, name);
}

//-(NSString *)ly_name{
//    NSString *Ly_name = objc_getAssociatedObject(self, name);
//    if (!Ly_name) {
//        Ly_name = @"123";
//        objc_setAssociatedObject(self,
//                                 name,
//                                 Ly_name,
//                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }return Ly_name;
//}

/// 扩大button的点击范围
- (void)enlargeClickAreaWithClickArea:(ClickSize)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size.top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size.right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size.bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size.left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)EnlargeClickAreaWithClickArea:(CGRect)size{
    objc_setAssociatedObject(self, &originX, [NSNumber numberWithFloat:size.origin.x], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &originY, [NSNumber numberWithFloat:size.origin.y], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &sizeW, [NSNumber numberWithFloat:size.size.width], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &sizeH, [NSNumber numberWithFloat:size.size.height], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
