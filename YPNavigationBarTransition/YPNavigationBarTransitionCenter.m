//
//  YPNavigationBarTransitionCenter.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "UIToolbar+YPConfigure.h"
#import "UINavigationBar+YPConfigure.h"
#import <YPNavigationBarTransition/UIViewController+YPNavigationBarTransition.h>
#import "YPNavigationBarTransitionCenterInternal.h"

BOOL YPTransitionNeedShowFakeBar(YPBarConfiguration *from,YPBarConfiguration *to) {
    BOOL showFakeBar = NO;
    do {
        if (from.hidden || to.hidden) break;
        
        if (from.transparent != to.transparent ||
            from.translucent != to.translucent) {
            showFakeBar = YES;
            break;
        }
        
        if (from.backgroundImage && to.backgroundImage) {
            NSString *const fromImageName = from.backgroundImageIdentifier;
            NSString *const toImageName   = to.backgroundImageIdentifier;
            if (fromImageName && toImageName) {
                showFakeBar = ![fromImageName isEqualToString:toImageName];
                break;
            }
            
            NSData *const fromImageData = UIImagePNGRepresentation(from.backgroundImage);
            NSData *const toImageData = UIImagePNGRepresentation(to.backgroundImage);
            if ([fromImageData isEqualToData:toImageData]) {
                break;
            }
            
            showFakeBar = YES;
        } else if (![from.backgroundColor isEqual:to.backgroundColor]) {
            showFakeBar = YES;
        }
    } while (0);
    
    return showFakeBar;
}

@implementation YPNavigationBarTransitionCenter

- (void) dealloc {
    _navigationController.delegate = nil;
}

- (instancetype) initWithDefaultBarConfiguration:(id<YPNavigationBarConfigureStyle>)_default {
    NSParameterAssert(_default);
    self = [super init];
    if (self) {
        _defaultBarConfigure = [[YPBarConfiguration alloc] initWithBarConfigurationOwner:_default];
    }
    
    return self;
}

- (void) setNavigationController:(UINavigationController *)navigationController {
    if (_navigationController != navigationController) {
        _navigationController = navigationController;
        
        if (_navigationController && !_navigationController.navigationBarHidden) {
            [self didShowViewController:_navigationController.topViewController];
        }
        
        [self updateNavigationControllerDelegate];
    }
}

- (void) setNavigationDelegate:(id<UINavigationControllerDelegate>)navigationDelegate {
    if (_navigationDelegate != navigationDelegate) {
        _navigationDelegate = navigationDelegate;
        
        _navigationController.delegate = nil;
        self.delegateProxy = [[YPNavigationBarTransitionCenterProxy alloc] initWithNavigationControllerDelegate:_navigationDelegate
                                                                                                    interceptor:self];
        [self updateNavigationControllerDelegate];
    }
}

- (void) updateNavigationControllerDelegate {
    id<UINavigationControllerDelegate> delegate = (id<UINavigationControllerDelegate>)self.delegateProxy ?: self;
    _navigationController.delegate = delegate;
}

#pragma mark - fakeBar

- (UIToolbar *) fromViewControllerFakeBar {
    if (!_fromViewControllerFakeBar) {
        _fromViewControllerFakeBar = [[UIToolbar alloc] init];
        _fromViewControllerFakeBar.delegate = self;
    }
    
    return _fromViewControllerFakeBar;
}

- (UIToolbar *) toViewControllerFakeBar {
    if (!_toViewControllerFakeBar) {
        _toViewControllerFakeBar = [[UIToolbar alloc] init];
        _toViewControllerFakeBar.delegate = self;
    }
    
    return _toViewControllerFakeBar;
}

- (UIBarPosition) positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTop;
}

- (void) removeFakeBars {
    [_fromViewControllerFakeBar removeFromSuperview];
    [_toViewControllerFakeBar removeFromSuperview];
}

#pragma mark - transition

- (YPBarConfiguration *) currentBarConfigure {
    return [_navigationController.navigationBar currentBarConfigure];
}

- (void) willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    YPBarConfiguration *currentConfigure = self.currentBarConfigure ?: self.defaultBarConfigure;
    YPBarConfiguration *showConfigure = self.defaultBarConfigure;
    if ([viewController yp_hasCustomNavigationBarStyle]) {
        id<YPNavigationBarConfigureStyle> owner = (id<YPNavigationBarConfigureStyle>)viewController;
        showConfigure = [[YPBarConfiguration alloc] initWithBarConfigurationOwner:owner];
    }
    
    UINavigationController *const navigationController = _navigationController;
    UINavigationBar *const navigationBar = navigationController.navigationBar;
    
    BOOL showFakeBar = YPTransitionNeedShowFakeBar(currentConfigure, showConfigure);
    BOOL const isTransparent = showConfigure.transparent;
    
    _isTransitionNavigationBar = YES;
    
    if (showConfigure.hidden != navigationController.navigationBarHidden) {
        [navigationController setNavigationBarHidden:showConfigure.hidden animated:animated];
    }
    
    if (!showConfigure.hidden) {
        if (showFakeBar) showConfigure.transparent = YES;
        [navigationBar yp_applyBarConfiguration:showConfigure];
        showConfigure.transparent = isTransparent;
    } else {
        [navigationBar yp_adjustWithBarStyle:showConfigure.barStyle tintColor:showConfigure.tintColor];
    }
    
    [navigationController.transitionCoordinator
     animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
         if (showFakeBar) {
             [UIView setAnimationsEnabled:NO];
             
             UIViewController *const fromVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
             UIViewController *const toVC  = [context viewControllerForKey:UITransitionContextToViewControllerKey];
             
             if (fromVC && [currentConfigure isVisible]) {
                 CGRect fakeBarFrame = [fromVC yp_fakeBarFrame];
                 if (!CGRectIsNull(fakeBarFrame)) {
                     UIToolbar *fakeBar = self.fromViewControllerFakeBar;
                     [fakeBar yp_applyBarConfiguration:currentConfigure];
                     fakeBar.frame = fakeBarFrame;
                     [fromVC.view addSubview:fakeBar];
                 }
             }
             
             if (toVC && [showConfigure isVisible]) {
                 CGRect fakeBarFrame = [toVC yp_fakeBarFrame];
                 if (!CGRectIsNull(fakeBarFrame)) {
                     if (toVC.extendedLayoutIncludesOpaqueBars ||
                         showConfigure.translucent) {
                         fakeBarFrame.origin.y = 0;
                     }
                     UIToolbar *fakeBar = self.toViewControllerFakeBar;
                     [fakeBar yp_applyBarConfiguration:showConfigure];
                     fakeBar.frame = fakeBarFrame;
                     [toVC.view addSubview:fakeBar];
                 }
             }
             
             [UIView setAnimationsEnabled:YES];
         }
     } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
         if ([context isCancelled]) {
             [self removeFakeBars];
             [navigationBar yp_applyBarConfiguration:currentConfigure];
             
             if (currentConfigure.hidden != navigationController.navigationBarHidden) {
                 [navigationController setNavigationBarHidden:showConfigure.hidden animated:animated];
             }
         }
         
         if (self) self->_isTransitionNavigationBar = NO;
     }];
    
    void (^popInteractionEndBlock)(id<UIViewControllerTransitionCoordinatorContext>) =
    ^(id<UIViewControllerTransitionCoordinatorContext> context){
        if ([context isCancelled]) {
            // revert statusbar's style
            [navigationBar yp_adjustWithBarStyle:currentConfigure.barStyle
                                       tintColor:currentConfigure.tintColor];
        }
    };
    
    if (@available(iOS 10,*)) {
        [navigationController.transitionCoordinator notifyWhenInteractionChangesUsingBlock:popInteractionEndBlock];
    } else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        [navigationController.transitionCoordinator notifyWhenInteractionEndsUsingBlock:popInteractionEndBlock];
#pragma GCC diagnostic pop
    }
}

- (void) didShowViewController:(UIViewController *)viewController {
    [self removeFakeBars];
    
    YPBarConfiguration *showConfigure = self.defaultBarConfigure;
    if ([viewController yp_hasCustomNavigationBarStyle]) {
        id<YPNavigationBarConfigureStyle> owner = (id<YPNavigationBarConfigureStyle>)viewController;
        showConfigure = [[YPBarConfiguration alloc] initWithBarConfigurationOwner:owner];
    }
    
    UINavigationBar *const navigationBar = _navigationController.navigationBar;
    [navigationBar yp_applyBarConfiguration:showConfigure];
    
    _isTransitionNavigationBar = NO;
}

#pragma mark - UINavigationControllerDelegate

- (void) navigationController:(UINavigationController *)navigationController
       willShowViewController:(UIViewController *)viewController
                     animated:(BOOL)animated {
    NSParameterAssert(navigationController == _navigationController);
    
    id<UINavigationControllerDelegate> navigationDelegate = _navigationDelegate;
    if ([navigationDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [navigationDelegate navigationController:navigationController
                          willShowViewController:viewController
                                        animated:animated];
    }
    
    [self willShowViewController:viewController animated:animated];
}

- (void) navigationController:(UINavigationController *)navigationController
        didShowViewController:(UIViewController *)viewController
                     animated:(BOOL)animated {
    NSParameterAssert(navigationController == _navigationController);
    
    id<UINavigationControllerDelegate> navigationDelegate = _navigationDelegate;
    if ([navigationDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [navigationDelegate navigationController:navigationController
                           didShowViewController:viewController
                                        animated:animated];
    }
    
    [self didShowViewController:viewController];
}

@end
