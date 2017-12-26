//
//  UIToolbar+YPConfigure.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

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
    
    [self setShadowImage:transpanrentImage forToolbarPosition:UIBarPositionAny];
}

@end
