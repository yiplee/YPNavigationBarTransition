//
//  ColorNavigationBarStyleObject.m
//  YPNavigationBarTransitionTests
//
//  Created by Li Guoyin on 2017/12/30.
//  Copyright © 2017年 yiplee. All rights reserved.
//

#import "ColorNavigationBarStyleObject.h"

@implementation ColorNavigationBarStyleObject

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarConfigurationsDefault | YPNavigationBarBackgroundStyleColor;
}

- (UIColor *) yp_navigationBarTintColor {
    return nil;
}

- (UIColor *) yp_navigationBackgroundColor {
    return self.backgroundColor;
}

@end
