//
//  YPNavigationController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 2018/4/20.
//  Copyright © 2018 yiplee. All rights reserved.
//

#import "YPNavigationController.h"
#import "YPNavigationControllerDelegateProxy.h"
#import "YPNavigationBarTransitionCenter.h"
#import "YPNavigationBarProtocol.h"

@interface YPNavigationController ()
<
UIGestureRecognizerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) YPNavigationBarTransitionCenter *center;
@property (nonatomic, weak, nullable) id<UINavigationControllerDelegate> navigationDelegate;
@property (nonatomic, strong, nullable) YPNavigationControllerDelegateProxy *delegateProxy;

@end

@implementation YPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // see YPNavigationController+Configure.{h,m} in Example Project
    NSAssert([self conformsToProtocol:@protocol(YPNavigationBarConfigureStyle)],
             @"you must implement YPNavigationBarConfigureStyle for YPNavigationController in subclass or category");
    
    _center = [[YPNavigationBarTransitionCenter alloc] initWithDefaultBarConfiguration:(id<YPNavigationBarConfigureStyle>)self];
    if (!self.delegate) {
        self.delegate = self;
    }
    
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void) setDelegate:(id<UINavigationControllerDelegate>)delegate {
    if (delegate == self || delegate == nil) {
        _navigationDelegate = nil;
        _delegateProxy = nil;
        super.delegate = self;
    } else {
        _navigationDelegate = delegate;
        _delegateProxy = [[YPNavigationControllerDelegateProxy alloc] initWithNavigationTarget:_navigationDelegate
                                                                                   interceptor:self];
        super.delegate = (id<UINavigationControllerDelegate>)_delegateProxy;
    }
}

#pragma mark - UINavigationControllerDelegate

- (void) navigationController:(UINavigationController *)navigationController
       willShowViewController:(UIViewController *)viewController
                     animated:(BOOL)animated {
    id<UINavigationControllerDelegate> navigationDelegate = self.navigationDelegate;
    if ([navigationDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [navigationDelegate navigationController:navigationController
                          willShowViewController:viewController
                                        animated:animated];
    }
    
    [_center navigationController:navigationController
           willShowViewController:viewController
                         animated:animated];
}

- (void) navigationController:(UINavigationController *)navigationController
        didShowViewController:(UIViewController *)viewController
                     animated:(BOOL)animated {
    id<UINavigationControllerDelegate> navigationDelegate = self.navigationDelegate;
    if ([navigationDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [navigationDelegate navigationController:navigationController
                          didShowViewController:viewController
                                        animated:animated];
    }
    
    [_center navigationController:navigationController
           didShowViewController:viewController
                         animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return self.viewControllers.count > 1;
    }
    
    return YES;
}

@end
