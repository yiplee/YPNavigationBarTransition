//
//  YPNavigationController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 2018/4/20.
//  Copyright © 2018 yiplee. All rights reserved.
//

#import "YPNavigationController.h"
#import <YPNavigationBarTransition/YPNavigationBarTransitionCenter.h>

static BOOL isInterceptedSelector(SEL sel) {
    return (
            sel == @selector(navigationController:willShowViewController:animated:) ||
            sel == @selector(navigationController:didShowViewController:animated:)
            );
}

/*
 *  _YPNavigationControllerProxy 用来转发 UINavigationControllerDelegate 的消息
 *  在拦截 delegate 消息的同时，还能让 YPNavigationController 的 delegate 正常工作
 */ 
@interface _YPNavigationControllerProxy : NSProxy

- (instancetype) initWithNavigationTarget:(nullable id<UINavigationControllerDelegate>)navigationTarget
                              interceptor:(YPNavigationController *)interceptor;
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

@implementation _YPNavigationControllerProxy {
    __weak id _navigationTarget;
    __weak YPNavigationController *_interceptor;
}

- (instancetype) initWithNavigationTarget:(nullable id<UINavigationControllerDelegate>)navigationTarget
                              interceptor:(YPNavigationController *)interceptor {
    NSParameterAssert(interceptor != nil);
    if (self) {
        _navigationTarget = navigationTarget;
        _interceptor = interceptor;
    }
    
    return  self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return isInterceptedSelector(aSelector)
    || [_navigationTarget respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return  isInterceptedSelector(aSelector) ? _interceptor : _navigationTarget;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end

@interface YPNavigationController ()
<
YPNavigationBarConfigureStyle,
UIGestureRecognizerDelegate,
UINavigationControllerDelegate
>

@property (nonatomic, strong) YPNavigationBarTransitionCenter *center;
@property (nonatomic, weak, nullable) id<UINavigationControllerDelegate> navigationDelegate;
@property (nonatomic, strong, nullable) _YPNavigationControllerProxy *delegateProxy;

@end

@implementation YPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _center = [[YPNavigationBarTransitionCenter alloc] initWithDefaultBarConfiguration:self];
    if (!self.delegate) {
        self.delegate = self;
    }
    
    /*
     * 如果 push 了一个 navigationbar hidden 的页面，左滑返回会失效
     * 这里接管左滑手势的 delegate 修复这个问题
     */
    self.interactivePopGestureRecognizer.delegate = self;

    /*
     * 默认是黑色，在左滑返回的时候可能会看到 navigation bar 边上出现黑色阴影
     * 这里改成白色修复这个问题
     * 如果你的 app 本来就是黑色风格，可以不加这一句
     */
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) setDelegate:(id<UINavigationControllerDelegate>)delegate {
    if (delegate == self || delegate == nil) {
        _navigationDelegate = nil;
        _delegateProxy = nil;
        super.delegate = self;
    } else {
        _navigationDelegate = delegate;
        _delegateProxy = [[_YPNavigationControllerProxy alloc] initWithNavigationTarget:_navigationDelegate
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


/*
 * 这里是默认的配置，没有实现自己的 style 的 viewController，会采用这个默认配置
 * ！！！请改成你自己的 app 的设计样式 ！！！
 */
#pragma mark - YPNavigationBarConfigureStyle

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarStyleBlack | YPNavigationBarBackgroundStyleTranslucent | YPNavigationBarBackgroundStyleNone;
}

- (UIColor *) yp_navigationBarTintColor {
    return [UIColor whiteColor];
}

@end
