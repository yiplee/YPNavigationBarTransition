//
//  YPNavigationController+Configure.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 2018/4/25.
//  Copyright © 2018 yiplee. All rights reserved.
//

#import "YPNavigationController+Configure.h"

@implementation YPNavigationController (Configure)

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarStyleBlack | YPNavigationBarBackgroundStyleTranslucent | YPNavigationBarBackgroundStyleNone;
}

- (UIColor *) yp_navigationBarTintColor {
    return [UIColor whiteColor];
}

@end
