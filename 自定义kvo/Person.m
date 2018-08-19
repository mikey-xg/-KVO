//
//  Person.m
//  自定义kvo
//
//  Created by 苏文潇 on 2018/8/19.
//  Copyright © 2018年 bestsu. All rights reserved.
//

#import "Person.h"


@implementation Person

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dog = [[Dog alloc] init];
        _dog.age = 2;
        _dog.level = 3;
        _arr = [NSMutableArray array];
    }
    return self;
}

//  自动通知和手动通知的修改方式  yes因为自动，也是默认。 NO 为手动，需要屌用两个方法才能实现kvo
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
//    return NO;
//}

/// 这个是外部的第四种用法，观察这个类中的另外一个类的全部属性的变化
/*
    返回的是一个NSSet集合，这个key 就是外部观察的这个类中的哪一个变量(即：dog)
 */
//+(NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
////    NSLog(@"%@", key);
//    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
//    if ([key isEqualToString:@"dog"]){
//        NSArray * arr = @[@"_dog.age", @"_dog.level"];
//        keyPaths = [keyPaths setByAddingObjectsFromArray:arr];
//    }
//    return keyPaths;
//}

@end
