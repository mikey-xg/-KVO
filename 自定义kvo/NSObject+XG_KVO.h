//
//  NSObject+XG_KVO.h
//  自定义kvo
//
//  Created by 苏文潇 on 2018/6/18.
//  Copyright © 2018年 bestsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XG_KVO)

- (void)XG_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end
