//
//  ViewController.m
//  FXDemo
//
//  Created by Felix on 2020/2/19.
//  Copyright © 2020 Felix. All rights reserved.
//

#import "ViewController.h"
#import "FXPerson.h"
#import "FXFriend.h"
#import "NSObject+FXKVC.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FXPerson *person = [FXPerson new];
    person.name = @"Felix";
//    [person setValue:@"Felix" forKey:@"a"];
//    NSLog(@"%@", [person valueForKey:@"a"]);
    
//    [person fx_setValue:@"Felix" forKey:@"a"];
//    NSLog(@"%@", [person fx_valueForKey:@"a"]);
    
    // 1.基本类型
//    [person setValue:@"Felix" forKey:@"name"];
//    [person setValue:@(18) forKey:@"age"];
//    NSLog(@"名字%@ 年龄%@", [person valueForKey:@"name"], [person valueForKey:@"age"]);
//
//    // 2.集合属性
//    person.family = @[@"FXPerson", @"FXFather"];
//    // 2.1
//    NSArray *temp = @[@"FXPerson", @"FXFather", @"FXMother"];
//    [person setValue:temp forKey:@"family"];
//    NSLog(@"第一次改变%@", [person valueForKey:@"family"]);
//
//    // 2.2
//    NSMutableArray *mTemp = [person mutableArrayValueForKeyPath:@"family"];
//    [mTemp addObject:@"FXChild"];
//    NSLog(@"第二次改变%@", [person valueForKey:@"family"]);
//
//    // 3.访问非对象类型——结构体
//    // 3.1赋值
//    ThreeFloats floats = {180.0, 180.0, 18.0};
//    NSValue *value = [NSValue valueWithBytes:&floats objCType:@encode(ThreeFloats)];
//    [person setValue:value forKey:@"threeFloats"];
//    NSLog(@"非对象类型%@", [person valueForKey:@"threeFloats"]);
//
//    // 3.2取值
//    ThreeFloats th;
//    NSValue *currentValue = [person valueForKey:@"threeFloats"];
//    [currentValue getValue:&th];
//    NSLog(@"非对象类型的值%f-%f-%f", th.x, th.y, th.z);
//
//    // 4.集合操作符
//    [self aggregationOperator];
//
//    // 5.层层嵌套
//    FXFriend *f = [[FXFriend alloc] init];
//    f.name = @"Felix的朋友";
//    f.age = 18;
//    person.friends = f;
//    [person setValue:@"Feng" forKeyPath:@"friends.name"];
//    NSLog(@"%@", [person valueForKeyPath:@"friends.name"]);
}

- (void)aggregationOperator {
    NSMutableArray *friendArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        FXFriend *f = [FXFriend new];
        NSDictionary* dict = @{
                               @"name":@"Felix",
                               @"age":@(18+i),
                               };
        [f setValuesForKeysWithDictionary:dict];
        [friendArray addObject:f];
    }
    NSLog(@"%@", [friendArray valueForKey:@"age"]);
    
    float avg = [[friendArray valueForKeyPath:@"@avg.age"] floatValue];
    NSLog(@"平均年龄%f", avg);
    
    int count = [[friendArray valueForKeyPath:@"@count.age"] intValue];
    NSLog(@"调查人口%d", count);
    
    int sum = [[friendArray valueForKeyPath:@"@sum.age"] intValue];
    NSLog(@"年龄总和%d", sum);
    
    int max = [[friendArray valueForKeyPath:@"@max.age"] intValue];
    NSLog(@"最大年龄%d", max);
    
    int min = [[friendArray valueForKeyPath:@"@min.age"] intValue];
    NSLog(@"最小年龄%d", min);
}

@end
