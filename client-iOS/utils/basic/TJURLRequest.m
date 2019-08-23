//
//  TJURLRequest.m
//  TJIMRC
//
//  Created by taiji_zq on 2019/6/6.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "TJURLRequest.h"

@implementation TJURLRequest

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host {
    return YES;
}

+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString *)host {
    
}

@end
