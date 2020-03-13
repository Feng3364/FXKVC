//
//  FXPerson.h
//  objc-debug
//
//  Created by Felix on 2020/3/2.
//

#import <Foundation/Foundation.h>
#import "FXFriend.h"

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    float x, y, z;
} ThreeFloats;

@interface FXPerson : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSArray  *family;
@property (nonatomic) ThreeFloats threeFloats;
@property (nonatomic, strong) FXFriend *friends;

@end

NS_ASSUME_NONNULL_END
