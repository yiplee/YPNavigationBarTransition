//
//  TranslucentBlackBarStyleObject.m
//  YPNavigationBarTransitionTests
//
//  Created by Guoyin Lee on 27/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "TranslucentBlackBarStyleObject.h"

@implementation TranslucentBlackBarStyleObject

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return YPNavigationBarConfigurationsDefault | YPNavigationBarStyleBlack;
}

- (UIColor *) yp_navigationBarTintColor {
    return [UIColor whiteColor];
}

@end
