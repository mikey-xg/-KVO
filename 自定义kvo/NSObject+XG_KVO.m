//
//  NSObject+XG_KVO.m
//  自定义kvo
//
//  Created by 苏文潇 on 2018/6/18.
//  Copyright © 2018年 bestsu. All rights reserved.
//

#import "NSObject+XG_KVO.h"
#import <objc/message.h>

@implementation NSObject (XG_KVO)


- (void)XG_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
//    1、自定义Notification_Person的子类
    NSString *oldClassName = NSStringFromClass(self.class);
    NSString *newClassName = [@"XGKVO_" stringByAppendingString:oldClassName];
//    2、创建一个类
    Class newClass = objc_allocateClassPair(self.class, newClassName.UTF8String, 0);
//    3、注册该类
    objc_registerClassPair(newClass);
//    4、动态修改
    object_setClass(self, newClass);
//    5、添加setName方法！  重写父类的setName方法
    class_addMethod(newClass, @selector(setName:), (IMP)setName, "v@:@");
}

/// oc方法里面有两个隐藏的参数 id self, SEL _cmd  
void setName(id self, SEL _cmd, NSString *name) {
    NSLog(@"%@", name);
}





@end
