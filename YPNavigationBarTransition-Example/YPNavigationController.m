//
//  YPNavigationController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPNavigationController.h"
@import YPNavigationBarTransition;

@interface YPNavigationController ()<YPNavigationBarConfigureStyle>

@property (nonatomic, strong, readwrite) YPNavigationBarTransitionCenter *transitionCenter;

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

- (void) createTransitionCenter {
    NSParameterAssert(!_transitionCenter && !self.delegate);
    
    _transitionCenter = [[YPNavigationBarTransitionCenter alloc] initWithDefaultBarConfiguration:self];
    _transitionCenter.navigationController = self;
}

//- (void) setDelegate:(id<UINavigationControllerDelegate>)delegate {
//    _transitionCenter.navigationDelegate = delegate;
//}
//
//- (id<UINavigationControllerDelegate>) delegate {
//    return _transitionCenter.navigationDelegate;
//}

#pragma mark - YPNavigationBarConfigureStyle

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarConfigurationsDefault | YPNavigationBarStyleBlack | YPNavigationBarBackgroundStyleColor;
}

- (UIColor *) yp_navigationBarTintColor {
    return [UIColor whiteColor];
}

- (UIColor *) yp_navigationBackgroundColor {
    return [UIColor blackColor];
}

@end
