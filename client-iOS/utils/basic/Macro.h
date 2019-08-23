//
//  Macro.h
//  food-root
//
//  Created by taiji_zq on 2019/8/23.
//  Copyright © 2019 taiji_zq. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#ifdef DEBUG
#define CLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define CLog(format, ...)
#endif

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define YYISiPhoneX [[UIScreen mainScreen] bounds].size.width >=375.0f && [[UIScreen mainScreen] bounds].size.height >=812.0f && YYIS_IPHONE
#define YYIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kTopBarSafeHeight (CGFloat)(YYISiPhoneX?(44):(0))
#define kBottomSafeHeight (CGFloat)(YYISiPhoneX?(34):(0))


#define WS(wSelf)  __weak __typeof(&*self)wSelf = self;

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

//#define APP_TINT_COLOR ([UIColor colorWithRed:77/255.0 green:155/255.0 blue:227/255.0 alpha:1.0])
#define RGBCOLOR(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0])

#define HEXCOLOR(rgbValue)                                                                                             \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
alpha:1.0]

#define kCurrentVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

#endif /* Macro_h */
