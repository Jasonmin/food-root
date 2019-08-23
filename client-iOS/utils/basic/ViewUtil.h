//
//  ViewUtil.h
//  TJIMRC
//
//  Created by zhou on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SepLinePosition) {
    SepLinePositionLeft,
    SepLinePositionRight,
    SepLinePositionBottom,
    SepLinePositionMiddle,
    SepLinePositionTop
};


@interface ViewUtil : NSObject

+ (void)drawSepLineforView:(UIView*)view position:(SepLinePosition)position color:(UIColor*)bgColor;

+ (UIImage *)GetImageWithColor:(UIColor *)color andHeight:(CGFloat)height;

+ (void)dismissNoDataViewInVC:(UIViewController*)vc;

+ (void)showNoDataViewInView:(UIView*)superView;

+ (UIViewController *)findSuperViewController:(UIView *)view;

@end


//NS_ASSUME_NONNULL_END
