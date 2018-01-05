/*
MIT License

Copyright (c) 2017 yiplee

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
        
        if (from.useSystemBarBackground && to.useSystemBarBackground) {
            showFakeBar = from.barStyle != to.barStyle;
        } else if (from.backgroundImage && to.backgroundImage) {
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
    if ([self validateInnerNavigationDelegate:navigationDelegate]) return;
    
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

- (BOOL) validateInnerNavigationDelegate:(id)delegate {
    return delegate && (delegate == self || delegate == self.delegateProxy);
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
    
    _isTransitionNavigationBar = YES;
    
    if (showConfigure.hidden != navigationController.navigationBarHidden) {
        [navigationController setNavigationBarHidden:showConfigure.hidden animated:animated];
    }
    
    YPBarConfiguration *transparentConfigure = nil;
    if (showFakeBar) {
        YPNavigationBarConfigurations transparentConf = YPNavigationBarConfigurationsDefault | YPNavigationBarBackgroundStyleTransparent;
        if (showConfigure.barStyle == UIBarStyleBlack) transparentConf |= YPNavigationBarStyleBlack;
        transparentConfigure = [[YPBarConfiguration alloc] initWithBarConfigurations:transparentConf
                                                                           tintColor:showConfigure.tintColor
                                                                     backgroundColor:nil
                                                                     backgroundImage:nil
                                                           backgroundImageIdentifier:nil];
    }
    
    if (!showConfigure.hidden) {
        [navigationBar yp_applyBarConfiguration:transparentConfigure ?: showConfigure];
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
                 CGRect fakeBarFrame = [fromVC yp_fakeBarFrameForNavigationBar:navigationBar];
                 if (!CGRectIsNull(fakeBarFrame)) {
                     UIToolbar *fakeBar = self.fromViewControllerFakeBar;
                     [fakeBar yp_applyBarConfiguration:currentConfigure];
                     fakeBar.frame = fakeBarFrame;
                     [fromVC.view addSubview:fakeBar];
                 }
             }
             
             if (toVC && [showConfigure isVisible]) {
                 CGRect fakeBarFrame = [toVC yp_fakeBarFrameForNavigationBar:navigationBar];
                 if (!CGRectIsNull(fakeBarFrame)) {
                     if (toVC.extendedLayoutIncludesOpaqueBars ||
                         navigationBar.translucent) {
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
