//
//  CollectionReusableView.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"
#import "MacroDef_Func.h"

#if __has_include(<ReactiveObjC/RACmetamacros.h>)
#import <ReactiveObjC/RACmetamacros.h>
#else
#import "RACmetamacros.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTScope.h>)
#import <ReactiveObjC/RACEXTScope.h>
#else
#import "RACEXTScope.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTKeyPathCoding.h>)
#import <ReactiveObjC/RACEXTKeyPathCoding.h>
#else
#import "RACEXTKeyPathCoding.h"
#endif

//#if __has_include(<ReactiveObjC/RACEXTRuntimeExtensions.h>)
//#import <ReactiveObjC/RACEXTRuntimeExtensions.h>
//#else
//#import "RACEXTRuntimeExtensions.h"
//#endif

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionReusableView : UICollectionReusableView

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)MKDataBlock collectionReusableViewBlock;
@property(nonatomic,assign)BOOL selected;

+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model;//由具体的子类进行覆写
-(void)richElementsInViewWithModel:(id _Nullable)model;//由具体的子类进行覆写
/*
    用于以此为基类的UICollectionReusableView具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockCollectionReusableView:(MKDataBlock _Nullable)collectionReusableViewBlock;

@end

NS_ASSUME_NONNULL_END
