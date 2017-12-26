//
//  UIViewController+YPNavigationBarTransition.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "UIViewController+YPNavigationBarTransition.h"
#import "YPBarConfiguration.h"
#import "UINavigationBar+YPConfigure.h"

@implementation UIViewController (YPNavigationBarTransition)

- (BOOL) yp_hasCustomNavigationBarStyle {
    return [self conformsToProtocol:@protocol(YPNavigationBarConfigureStyle)];
}

- (UINavigationBar *) yp_navigationBar {
    if ([self isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController*)self navigationBar];
    }
    
    return [self.navigationController navigationBar];
}

- (void) yp_refreshNavigationBarStyle {
    NSParameterAssert([self yp_hasCustomNavigationBarStyle]);
    
    UINavigationBar *navigationBar = [self yp_navigationBar];
    if (navigationBar.topItem == self.navigationItem) {
        id<YPNavigationBarConfigureStyle> owner = (id<YPNavigationBarConfigureStyle>)self;
        YPBarConfiguration *configuration = [[YPBarConfiguration alloc] initWithBarConfigurationOwner:owner];
        [navigationBar yp_applyBarConfiguration:configuration];
    }
}

- (CGRect) yp_fakeBarFrame {
    UINavigationBar *navigationBar = [self yp_navigationBar];
    if (!navigationBar) return CGRectNull;
    
    UIView *backgroundView = [navigationBar valueForKey:@"_backgroundView"];
    CGRect frame = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    frame.origin.x = self.view.bounds.origin.x;
    return frame;
}

@end
