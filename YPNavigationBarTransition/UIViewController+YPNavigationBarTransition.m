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

- (CGRect) yp_fakeBarFrameForNavigationBar:(UINavigationBar *)navigationBar {
    if (!navigationBar) return CGRectNull;
    
    UIView *backgroundView = [navigationBar yp_backgroundView];
    CGRect frame = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    frame.origin.x = self.view.bounds.origin.x;
    return frame;
}

@end
