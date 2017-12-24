//
//  UIViewController+YPNavigationBarTransition.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YPNavigationBarTransition)

- (BOOL) yp_hasCustomNavigationBarStyle;

- (void) yp_refreshNavigationBarStyle;

- (CGRect) yp_fakeBarFrame;

@end
