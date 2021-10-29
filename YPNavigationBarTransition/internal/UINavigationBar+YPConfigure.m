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
#import "UINavigationBar+YPConfigure.h"
#import "YPBarConfiguration.h"
#import "UIImage+YPConfigure.h"
#import <objc/runtime.h>

@implementation UINavigationBar (YPConfigure)

- (void) yp_adjustWithBarStyle:(UIBarStyle)barStyle tintColor:(UIColor *)tintColor {
    self.barStyle = barStyle;
    self.tintColor = tintColor;
}

- (UIView *) yp_backgroundView {
    return [self valueForKey:@"_backgroundView"];
}

- (void) yp_applyBarConfiguration:(YPBarConfiguration *)configure {
#if DEBUG
    if (@available(iOS 11,*)) {
        NSAssert(!self.prefersLargeTitles, @"large titles is not supported");
    }
#endif
    
    [self yp_adjustWithBarStyle:configure.barStyle tintColor:configure.tintColor];
    
    UIView *barBackgroundView = [self yp_backgroundView];
    UIImage* const transpanrentImage = [UIImage yp_transparentImage];
    if (configure.transparent) {
        barBackgroundView.alpha = 0;
        if (@available(iOS 13.0, *)) {
            UINavigationBarAppearance *appearance = [[self standardAppearance] copy];
            [appearance configureWithTransparentBackground];
            self.scrollEdgeAppearance = appearance;
            self.standardAppearance = appearance;
        } else {
            self.translucent = YES;
            [self setBackgroundImage:transpanrentImage forBarMetrics:UIBarMetricsDefault];
        }
    } else {
        barBackgroundView.alpha = 1;
        if (@available(iOS 13.0, *)) {
            UINavigationBarAppearance *appearance = [[self standardAppearance] copy];
            if (configure.translucent) {
                [appearance configureWithDefaultBackground];
                UIBlurEffectStyle effectStyle = configure.barStyle == UIBarStyleDefault ? UIBlurEffectStyleLight : UIBlurEffectStyleDark;
                appearance.backgroundEffect = [UIBlurEffect effectWithStyle:effectStyle];
            } else {
                [appearance configureWithOpaqueBackground];
            }
            if (configure.backgroundImage) {
                appearance.backgroundImage = configure.backgroundImage;
            } else if (configure.backgroundColor) {
                appearance.backgroundColor = configure.backgroundColor;
            }
            if (!configure.shadowImage) {
                appearance.shadowImage = nil;
                appearance.shadowColor = nil;
            }
            self.scrollEdgeAppearance = appearance;
            self.standardAppearance = appearance;
        } else {
            self.translucent = configure.translucent;
            UIImage* backgroundImage = configure.backgroundImage;
            if (!backgroundImage && configure.backgroundColor) {
                backgroundImage = [UIImage yp_imageWithColor:configure.backgroundColor];
            }
            [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        }
    }
    
    self.shadowImage = configure.shadowImage ? nil : transpanrentImage;
    
    [self setCurrentBarConfigure:configure];
}

- (YPBarConfiguration *) currentBarConfigure {
    return objc_getAssociatedObject(self, @selector(currentBarConfigure));
}

- (void) setCurrentBarConfigure:(YPBarConfiguration *)currentBarConfigure {
    objc_setAssociatedObject(self, @selector(currentBarConfigure), currentBarConfigure, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
