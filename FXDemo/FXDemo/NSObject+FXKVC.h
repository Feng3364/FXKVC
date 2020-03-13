//
//  NSObject+FXKVC.h
//  FXDemo
//
//  Created by Felix on 2020/3/8.
//  Copyright © 2020 Felix. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FXKVC)

- (void)fx_setValue:(nullable id)value forKey:(NSString *)key;

- (nullable id)fx_valueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
