//
//  UIViewController+UIStyle.h
//  TJIMRC
//
//  Created by zhou on 2018/12/28.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (UIStyle)

- (void)configNavLeftBackItemWithSelector:(SEL)selector;

- (void)configNavLeftItemsWithSelector:(SEL)firstSelector
                           SecSelector:(SEL)secSelector;

- (void)configNavRightItemTitle:(NSString*)title
                       selector:(SEL)selector;

- (void)configNavLeftItemTitle:(NSString*)title
                      selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
