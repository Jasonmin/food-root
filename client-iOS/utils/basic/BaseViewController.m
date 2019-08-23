//
//  BaseViewController.m
//  TJIMRC
//
//  Created by zhou on 2018/12/28.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewController+UIStyle.h"
#import "BaseProtocol.h"
#import "ViewUtil.h"
#import "UIViewController+KeyBoard.h"

@interface BaseViewController () <BaseProtocol>

@end

@implementation BaseViewController

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupForDismissKeyboard];
    
    [self setupOneBackItem];
}

- (void)setupOneBackItem {
    [self configNavLeftBackItemWithSelector:@selector(back)];
}

- (void)setupTwoNavItems {
    [self configNavLeftItemsWithSelector:@selector(back) SecSelector:@selector(close)];
}

#pragma mark - Event
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - BaseProtocol
- (void)showHud {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHud {
    [MBProgressHUD hideHUDForView:self.view];
}

- (void)showEmptyView {
    [ViewUtil showNoDataViewInView:self.view];
}

- (void)dimissEmptyView {
    [ViewUtil dismissNoDataViewInVC:self];
}

@end
