//
//  NSUserDefaults+Identifier.h
//  AFNetworking
//
//  Created by BWJS-FREDERIC on 2020/10/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults(Identifier)
+ (id)ty_cacheOutWithKey:(NSString *)key clazz:(Class)clazz identifier:(NSString *)identifier;
+ (void)ty_cahceInModel:(id)model key:(NSString *)key identifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
