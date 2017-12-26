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
