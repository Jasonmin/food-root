//
//  BaseProtocol.h
//  TJIMRC
//
//  Created by taiji_zq on 2019/4/24.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BaseProtocol <NSObject>

@optional
- (void)presenterDidGetViewDataSource:(NSArray*)data type:(NSString*)fetchType;

- (void)showHud;

- (void)hideHud;

- (void)showEmptyView;

- (void)dimissEmptyView;

@end

