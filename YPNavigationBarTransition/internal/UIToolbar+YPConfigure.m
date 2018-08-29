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
#import "YPBarConfiguration.h"
#import "UIImage+YPConfigure.h"

@implementation UIToolbar (YPConfigure)

- (void) yp_applyBarConfiguration:(YPBarConfiguration *)configure {
    self.barStyle = configure.barStyle;
    
    UIImage* const transpanrentImage = [UIImage yp_transparentImage];
    if (configure.transparent) {
        self.translucent = YES;
        [self setBackgroundImage:transpanrentImage forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    } else {
        self.translucent = configure.translucent;
        UIImage* backgroundImage = configure.backgroundImage;
        if (!backgroundImage && configure.backgroundColor) {
            backgroundImage = [UIImage yp_imageWithColor:configure.backgroundColor];
        }
        
        [self setBackgroundImage:backgroundImage forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    
    UIImage* shadowImage = configure.shadowImage ? nil : transpanrentImage;
    [self setShadowImage:shadowImage forToolbarPosition:UIBarPositionAny];
}

@end
