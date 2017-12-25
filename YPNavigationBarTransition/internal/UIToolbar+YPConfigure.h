//
//  UIToolbar+YPConfigure.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPBarConfiguration;

@interface UIToolbar (YPConfigure)

- (void) yp_applyBarConfiguration:(YPBarConfiguration *)configure;

@end
