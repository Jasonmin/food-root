//
//  UIViewController+AOP.m
//  TJIMRC
//
//  Created by zhou on 2018/12/28.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "UIViewController+AOP.h"
#import <objc/runtime.h>

@implementation UIViewController (AOP)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(tj_viewDidLoad));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
    
}

- (void)tj_viewDidLoad {
    // 全局样式
    [self tj_viewDidLoad];
//    Class class = NSClassFromString(@"UIInputWindowController");
//    if (self.class != class) {
//        self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
//    }
    CLog(@"%@",self);
    
    
}

@end
