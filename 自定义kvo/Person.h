//
//  Person.h
//  自定义kvo
//
//  Created by 苏文潇 on 2018/8/19.
//  Copyright © 2018年 bestsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject{
    /// 如果是成员变量的话kvo就不可行，kvo值观察的是set方法
    @public
    NSString *_text;
}
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) Dog *dog;


@property (nonatomic, copy) NSMutableArray *arr;
@end
