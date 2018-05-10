//
//  YPNavigationControllerDelegateProxy.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 2018/4/25.
//  Copyright © 2018 yiplee. All rights reserved.
//

#import "YPNavigationControllerDelegateProxy.h"
#import <YPNavigationBarTransition/YPNavigationController.h>

static BOOL isInterceptedSelector(SEL sel) {
    return (
            sel == @selector(navigationController:willShowViewController:animated:) ||
            sel == @selector(navigationController:didShowViewController:animated:)
            );
}

@implementation YPNavigationControllerDelegateProxy {
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
