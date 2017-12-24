//
//  YPNavigationBarTransitionCenterProxy.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPNavigationBarTransitionCenterProxy.h"

static BOOL isInterceptedSelector(SEL selector) {
    return (
        selector == @selector(navigationController:willShowViewController:animated:) ||
        selector == @selector(navigationController:didShowViewController:animated:)
    );
}

@implementation YPNavigationBarTransitionCenterProxy {
    __weak id<UINavigationControllerDelegate> _delegateTarget;
    __weak YPNavigationBarTransitionCenter *_interceptor;
}

- (instancetype) initWithNavigationControllerDelegate:(id<UINavigationControllerDelegate>)delegateTarget
                                          interceptor:(YPNavigationBarTransitionCenter *)interceptor {
    NSParameterAssert(interceptor);
    
    if (self) {
        _delegateTarget = delegateTarget;
        _interceptor = interceptor;
    }
    
    return self;
}

- (BOOL) respondsToSelector:(SEL)aSelector {
    return isInterceptedSelector(aSelector)
    || [_delegateTarget respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (isInterceptedSelector(aSelector)) {
        return _interceptor;
    }
    
    return _delegateTarget;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

@end
