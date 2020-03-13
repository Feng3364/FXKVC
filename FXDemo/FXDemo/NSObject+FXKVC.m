//
//  NSObject+FXKVC.m
//  FXDemo
//
//  Created by Felix on 2020/3/8.
//  Copyright © 2020 Felix. All rights reserved.
//

#import "NSObject+FXKVC.h"
#import <objc/runtime.h>

@implementation NSObject (FXKVC)

- (void)fx_setValue:(nullable id)value forKey:(NSString *)key {
    
    if (key == nil || key.length == 0) return;
    
    NSString *Key = key.capitalizedString;
    NSString *setKey = [NSString stringWithFormat:@"set%@:",Key];
    NSString *_setKey = [NSString stringWithFormat:@"_set%@:",Key];
    NSString *setIsKey = [NSString stringWithFormat:@"setIs%@:",Key];
    
    if ([self fx_performSelectorWithMethodName:setKey value:value]) {
        NSLog(@"*********%@**********",setKey);
        return;
    } else if ([self fx_performSelectorWithMethodName:_setKey value:value]) {
        NSLog(@"*********%@**********",_setKey);
        return;
    } else if ([self fx_performSelectorWithMethodName:setIsKey value:value]) {
        NSLog(@"*********%@**********",setIsKey);
        return;
    }
    
    NSString *undefinedMethodName = @"setValue:forUndefinedKey:";
    IMP undefinedIMP = class_getMethodImplementation([self class], NSSelectorFromString(undefinedMethodName));
    
    if (![self.class accessInstanceVariablesDirectly]) {
        if (undefinedIMP) {
            [self fx_performSelectorWithMethodName:undefinedMethodName value:value key:key];
        } else {
            @throw [NSException exceptionWithName:@"FXUnknownKeyException" reason:[NSString stringWithFormat:@"****[%@ %@]: this class is not key value coding-compliant for the key %@.", self, NSStringFromSelector(_cmd), key] userInfo:nil];
        }
        return;
    }
    
    NSMutableArray *mArray = [self getIvarListName];
    NSString *_key = [NSString stringWithFormat:@"_%@",key];
    NSString *_isKey = [NSString stringWithFormat:@"_is%@",Key];
    NSString *isKey = [NSString stringWithFormat:@"is%@",Key];
    if ([mArray containsObject:_key]) {
       Ivar ivar = class_getInstanceVariable([self class], _key.UTF8String);
       object_setIvar(self , ivar, value);
       return;
    } else if ([mArray containsObject:_isKey]) {
       Ivar ivar = class_getInstanceVariable([self class], _isKey.UTF8String);
       object_setIvar(self , ivar, value);
       return;
    } else if ([mArray containsObject:key]) {
       Ivar ivar = class_getInstanceVariable([self class], key.UTF8String);
       object_setIvar(self , ivar, value);
       return;
    } else if ([mArray containsObject:isKey]) {
       Ivar ivar = class_getInstanceVariable([self class], isKey.UTF8String);
       object_setIvar(self , ivar, value);
       return;
    }

    if (undefinedIMP) {
        [self fx_performSelectorWithMethodName:undefinedMethodName value:value key:key];
    } else {
        @throw [NSException exceptionWithName:@"FXUnknownKeyException" reason:[NSString stringWithFormat:@"****[%@ %@]: this class is not key value coding-compliant for the key %@.", self, NSStringFromSelector(_cmd), key] userInfo:nil];
    }
}

- (nullable id)fx_valueForKey:(NSString *)key {
    
    if (key == nil  || key.length == 0) {
        return nil;
    }

    NSString *Key = key.capitalizedString;
    NSString *getKey = [NSString stringWithFormat:@"get%@",Key];
    NSString *countOfKey = [NSString stringWithFormat:@"countOf%@",Key];
    NSString *objectInKeyAtIndex = [NSString stringWithFormat:@"objectIn%@AtIndex:",Key];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([self respondsToSelector:NSSelectorFromString(getKey)]) {
        return [self performSelector:NSSelectorFromString(getKey)];
    } else if ([self respondsToSelector:NSSelectorFromString(key)]) {
        return [self performSelector:NSSelectorFromString(key)];
    } else if ([self respondsToSelector:NSSelectorFromString(countOfKey)]) {
        if ([self respondsToSelector:NSSelectorFromString(objectInKeyAtIndex)]) {
            int num = (int)[self performSelector:NSSelectorFromString(countOfKey)];
            NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1];
            for (int i = 0; i<num-1; i++) {
                num = (int)[self performSelector:NSSelectorFromString(countOfKey)];
            }
            for (int j = 0; j<num; j++) {
                id objc = [self performSelector:NSSelectorFromString(objectInKeyAtIndex) withObject:@(num)];
                [mArray addObject:objc];
            }
            return mArray;
        }
    }
#pragma clang diagnostic pop
    
    NSString *undefinedMethodName = @"valueForUndefinedKey:";
    IMP undefinedIMP = class_getMethodImplementation([self class], NSSelectorFromString(undefinedMethodName));
    
    if (![self.class accessInstanceVariablesDirectly]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (undefinedIMP) {
            return [self performSelector:NSSelectorFromString(undefinedMethodName) withObject:key];
        } else {
            @throw [NSException exceptionWithName:@"FXUnknownKeyException" reason:[NSString stringWithFormat:@"****[%@ %@]: this class is not key value coding-compliant for the key %@.", self, NSStringFromSelector(_cmd), key] userInfo:nil];
        }
#pragma clang diagnostic pop
    }
    
    NSMutableArray *mArray = [self getIvarListName];
    NSString *_key = [NSString stringWithFormat:@"_%@",key];
    NSString *_isKey = [NSString stringWithFormat:@"_is%@",Key];
    NSString *isKey = [NSString stringWithFormat:@"is%@",Key];
    if ([mArray containsObject:_key]) {
        Ivar ivar = class_getInstanceVariable([self class], _key.UTF8String);
        return object_getIvar(self, ivar);;
    } else if ([mArray containsObject:_isKey]) {
        Ivar ivar = class_getInstanceVariable([self class], _isKey.UTF8String);
        return object_getIvar(self, ivar);;
    } else if ([mArray containsObject:key]) {
        Ivar ivar = class_getInstanceVariable([self class], key.UTF8String);
        return object_getIvar(self, ivar);;
    } else if ([mArray containsObject:isKey]) {
        Ivar ivar = class_getInstanceVariable([self class], isKey.UTF8String);
        return object_getIvar(self, ivar);;
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (undefinedIMP) {
        return [self performSelector:NSSelectorFromString(undefinedMethodName) withObject:key];
    } else {
        @throw [NSException exceptionWithName:@"FXUnknownKeyException" reason:[NSString stringWithFormat:@"****[%@ %@]: this class is not key value coding-compliant for the key %@.", self, NSStringFromSelector(_cmd), key] userInfo:nil];
    }
#pragma clang diagnostic pop

    return @"";
}

#pragma mark - 相关方法
- (BOOL)fx_performSelectorWithMethodName:(NSString *)methodName value:(id)value key:(id)key {
 
    if ([self respondsToSelector:NSSelectorFromString(methodName)]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(methodName) withObject:value withObject:key];
#pragma clang diagnostic pop
        return YES;
    }
    return NO;
}

- (BOOL)fx_performSelectorWithMethodName:(NSString *)methodName value:(id)value {
 
    if ([self respondsToSelector:NSSelectorFromString(methodName)]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(methodName) withObject:value];
#pragma clang diagnostic pop
        return YES;
    }
    return NO;
}

- (id)performSelectorWithMethodName:(NSString *)methodName {
    if ([self respondsToSelector:NSSelectorFromString(methodName)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:NSSelectorFromString(methodName)];
#pragma clang diagnostic pop
    }
    return nil;
}

- (NSMutableArray *)getIvarListName {
    
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:1];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *ivarNameChar = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:ivarNameChar];
        NSLog(@"ivarName == %@",ivarName);
        [mArray addObject:ivarName];
    }
    free(ivars);
    return mArray;
}

@end
