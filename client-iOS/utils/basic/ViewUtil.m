//
//  ViewUtil.m
//  TJIMRC
//
//  Created by zhou on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "ViewUtil.h"
#import "Macro.h"

static NSInteger const kNoDataViewTag = 911;

@implementation ViewUtil

+ (void)drawSepLineforView:(UIView*)view position:(SepLinePosition)position color:(UIColor*)bgColor
{
    UIView* sepLine = [[UIView alloc]init];
    if (bgColor) {
        sepLine.backgroundColor = bgColor;
    } else {
        sepLine.backgroundColor = [UIColor lightGrayColor];
    }
    static CGFloat const lineWidth = 0.5f;
    CGSize vSize = view.frame.size;
    if ([view isKindOfClass:[UITableViewCell class]]) {
        vSize = CGSizeMake(kScreenWidth, view.frame.size.height);
    }
    
    switch (position) {
        case SepLinePositionBottom:
            sepLine.frame = CGRectMake(0, vSize.height-lineWidth, vSize.width, lineWidth);
            break;
        case SepLinePositionRight:
            sepLine.frame = CGRectMake(vSize.width-lineWidth, 0, lineWidth, vSize.height);
            break;
        case SepLinePositionLeft:
            sepLine.frame = CGRectMake(0, 0, lineWidth, vSize.height);
            break;
        case SepLinePositionMiddle:
            sepLine.frame = CGRectMake(vSize.width/2, 0, lineWidth, vSize.height);
            break;
        case SepLinePositionTop:
            sepLine.frame = CGRectMake(0, 0, vSize.width, lineWidth);
            break;
            
        default:
            break;
    }
    [view addSubview:sepLine];
}

+ (UIImage *)GetImageWithColor:(UIColor *)color andHeight:(CGFloat)height {
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (void)dismissNoDataViewInVC:(UIViewController*)vc {
    UIView *view = [vc.view viewWithTag:kNoDataViewTag];
    if (view) {
        [view removeFromSuperview];
    }
}

+ (void)showNoDataViewInView:(UIView*)superView {
    
//    UIButton *view = [[[NSBundle mainBundle]loadNibNamed:@"GGPNoInfoView" owner:nil options:nil] firstObject];
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.textColor = [UIColor colorWithWhite:0.6 alpha:1.0];
    view.text = @"暂无记录~";
    view.textAlignment = NSTextAlignmentCenter;
    view.tag = kNoDataViewTag;
    view.backgroundColor = [UIColor clearColor];
    view.center = CGPointMake(superView.center.x, CGRectGetHeight(superView.bounds)/2);//superView.center;
    [superView addSubview:view];
}

+ (UIViewController *)findSuperViewController:(UIView *)view
{
    UIResponder *responder = view;
    // 循环获取下一个响应者,直到响应者是一个UIViewController类的一个对象为止,然后返回该对象.
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

@end
