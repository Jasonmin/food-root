//
//  UIViewController+UIStyle.m
//  TJIMRC
//
//  Created by zhou on 2018/12/28.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "UIViewController+UIStyle.h"

@implementation UIViewController (UIStyle)


- (void)configNavLeftBackItemWithSelector:(SEL)backSelector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"nav_back_white"];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:backSelector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


- (void)configNavLeftItemsWithSelector:(SEL)firstSelector
                           SecSelector:(SEL)secSelector{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"nav_back_white"];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:firstSelector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *firItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"关闭" forState:UIControlStateNormal];
    [button2 addTarget:self action:secSelector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *secItem = [[UIBarButtonItem alloc] initWithCustomView:button2];
    
    self.navigationItem.leftBarButtonItems = @[firItem,secItem];
}


- (void)configNavRightItemTitle:(NSString*)title
                        selector:(SEL)selector {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)configNavLeftItemTitle:(NSString*)title
                       selector:(SEL)selector {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    self.navigationItem.leftBarButtonItem = leftItem;
}

@end
