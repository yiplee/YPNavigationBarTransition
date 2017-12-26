//
//  YPNavigationController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPNavigationController.h"
#import <YPNavigationBarTransition/YPNavigationBarTransition.h>

@interface YPNavigationController ()
<
YPNavigationBarConfigureStyle,
UIGestureRecognizerDelegate
>

@property (nonatomic, strong) YPNavigationBarTransitionCenter *transitionCenter;

@end

@implementation YPNavigationController

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self createTransitionCenter];
    }
    
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createTransitionCenter];
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void) createTransitionCenter {
    NSParameterAssert(!_transitionCenter && !self.delegate);
    
    _transitionCenter = [[YPNavigationBarTransitionCenter alloc] initWithDefaultBarConfiguration:self];
    _transitionCenter.navigationController = self;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return self.viewControllers.count > 1;
    }
    
    return YES;
}

#pragma mark - YPNavigationBarConfigureStyle

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarStyleBlack | YPNavigationBarBackgroundStyleTranslucent | YPNavigationBarBackgroundStyleNone;
}

- (UIColor *) yp_navigationBarTintColor {
    return [UIColor whiteColor];
}

@end
