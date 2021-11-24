//
//  NSUserDefaults+Identifier.m
//  AFNetworking
//
//  Created by BWJS-FREDERIC on 2020/10/5.
//

#import "NSUserDefaults+Identifier.h"
#import "NSString+TYAdd.h"
#import "YYModel.h"

@implementation NSUserDefaults(Identifier)
+ (id)ty_cacheOutWithKey:(NSString *)key clazz:(Class)clazz identifier:(NSString *)identifier{
    if ([NSString isNotEmptySring:key] && [NSString isNotEmptySring:identifier]) {
       NSString *modelString = [[[NSUserDefaults alloc] initWithSuiteName:identifier] objectForKey:key];
        id obj = [clazz yy_modelWithJSON:modelString];
        return obj;
    }
    return nil;
}

+ (void)ty_cahceInModel:(id)model key:(NSString *)key identifier:(NSString *)identifier{
    if (model == nil) {  return; }
    NSString *modelString = [model yy_modelToJSONString];
    if ([NSString isNotEmptySring:modelString] && [NSString isNotEmptySring:key] && [NSString isNotEmptySring:identifier]) {
        [[[NSUserDefaults alloc] initWithSuiteName:identifier] setObject:modelString forKey:key];
    }
}
@end
