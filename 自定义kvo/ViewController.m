//
//  ViewController.m
//  自定义kvo
//
//  Created by 苏文潇 on 2018/6/18.
//  Copyright © 2018年 bestsu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

/*  KVO 的 option属性的枚举值的作用。
 NSKeyValueObservingOptionNew       返回新值的时候发通知
 NSKeyValueObservingOptionOld       返回旧值的时候发通知
 NSKeyValueObservingOptionInitial   在注册的时候就会发一次通知，在改变的时候也会发通知
 NSKeyValueObservingOptionPrior     改变之前发一次，改变之后发一次
 */



/*
 在kvo中苹果给你了我们两种发通知的模式，一种就是自动通知，一种就是可选通知。
 什么意思呢？
 解释一波：在一般情况下我们在使用kvo的时候只是想到某一个东西条件改变的时候我们要知道他的状态，但是还有一些情况就是如果满足一定条件后你需要通知，在不满足条件的时候就不需要因此苹果给我们了这两种模式，解决了这中尴尬的局面。
 
 所谓的自动通知：
    就是你在观察某一个类的时候。这个类中有一个方法叫做
 + (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key 他的默认返回值就是YES
 意思就是如果你不从写这个方法的话，你观察的所有的类的某个值都是自动通知。
 
 手动通知：
    就是你手动重写了这个方法，将方法的返回值设置成了NO。这个时候你在运行发现KVO已经不能使用了，原因就是你改变了他发送通知的机制，导致在发送通知的过程中他被阻塞了。如果想让他继续执行下去你需要手动的去实现两个方法：
        - (void)willChangeValueForKey:(NSString *)key;
        - (void)didChangeValueForKey:(NSString *)key;
 但是需要知道调用顺序:首先说一下 willChangeValueForKey 这个方法就是在观察某个属性之前的变化
 didChangeValueForKey 这个方法是观察的某个属性改变之后的方法，注意这两个一定要成双成对(因为KVO的option中的四个key值的关系，因此需要成双成对的写)
 他们的顺序
         [_p1 willChangeValueForKey:@"name"];
         _p1.name = @"hello";
         [_p1 didChangeValueForKey:@"name"];
 
*/



@interface ViewController ()
@property (nonatomic, strong) Person *p;
@property (nonatomic, strong) Person *p1;
@property (nonatomic, strong) Person *p2;
@property (nonatomic, strong) Person *p3;
@property (nonatomic, strong) Person *p4;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///1、 这是观察这个类中的某个属性(不是类中的另外一个类的属性)
//    Person *p = [Person new];
//    _p = p;
//    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    ///2、 这是观察这个类中的某一个类的属性(通过keyPath使用)
//    Person *p1 = [Person new];
//    _p1 = p1;
//    [p1 addObserver:self forKeyPath:@"dog.age" options:NSKeyValueObservingOptionNew context:nil];
    
    ///3、 这个是观察数组的变化： kvo的本质是观察set方法，但是数组的变化不是调用的set方法。 因此需要一些特定的处理方法: 使用 kvc方式。-(void)mutableArrayValueForKey:这个方法，转换成一个临时数组。然后在进行addObject: 添加就ok了
//    Person *p2 = [Person new];
//    _p2 = p2;
//    [p2 addObserver:self forKeyPath:@"arr" options:NSKeyValueObservingOptionNew context:nil];
 
    ///4、键值观察一个对象的多个属性的值的变化的(观察Dog类中的所有的属性的变化)
    /*
     如果我们直接使用就不会走observe的方法，我们需要在Person类中进行一些特殊的处理。
    重写 keyPathsForValuesAffectingValueForKey这个方法。他的返回值一个NSSet集合
     */
//    Person *p3 = [Person new];
//    _p3 = p3;
//    [p3 addObserver:self forKeyPath:@"dog" options:NSKeyValueObservingOptionNew context:nil];
    
    /// 5、 观察成员变量的变化(这里注意的是kvo只观察的是set方法，对不调用set方法的不会观察)
    Person *p4 = [Person new];
    _p4 = p4;
    [p4 addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@", change);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self demo1];
//    [self demo2];
//    [self demo3];
//    [self demo4];
    [self demo5];
}

/// 这是在使用手动通知的使用
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key 返回值为NO的时候使用
- (void)demo1{
    [_p willChangeValueForKey:@"name"];
    _p.name = @"hello";
    [_p didChangeValueForKey:@"name"];
}

/// 这是观察这个类中的某一个类的属性(通过keyPath使用)
- (void)demo2{
    _p1.dog.age = 10;
}

/// 这个是观察数组的变化
- (void)demo3{
    NSMutableArray *tempArr = [_p2 mutableArrayValueForKey:@"arr"];
    [tempArr addObject:@"object"];
}

/// 这个是观察摸一个类中的另外一个类的所有的属性
- (void)demo4{
    _p3.dog.age = 10;
    _p3.dog.level = 20;
}

/// 观察成员变量的变化
- (void)demo5{
    _p4->_text = @"观察不到成员变量";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
