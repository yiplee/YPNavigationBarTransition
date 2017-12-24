//
//  UINavigationBar+YPConfigure.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPBarConfiguration;

@interface UINavigationBar (YPConfigure)

- (void) yp_adjustWithBarStyle:(UIBarStyle)barStyle tintColor:(UIColor *)tintColor;
- (void) yp_applyBarConfiguration:(YPBarConfiguration *)configure;

@end
