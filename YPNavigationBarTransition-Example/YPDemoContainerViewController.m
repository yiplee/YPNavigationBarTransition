//
//  YPDemoContainerViewController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPDemoContainerViewController.h"
#import "YPDemoConfigureViewController.h"

@interface YPDemoContainerViewController ()

@end

@implementation YPDemoContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YPDemoConfigureViewController *conf = [YPDemoConfigureViewController new];
    [self addChildViewController:conf];
    
    UIView *confView = conf.view;
    confView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    confView.frame = self.view.bounds;
    [self.view addSubview:confView];
    [conf didMoveToParentViewController:self];
}

#pragma mark - YPNavigationBarConfigureStyle

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration {
    return _configurations;
}

- (UIColor *) yp_navigationBarTintColor {
    return _tintColor;
}

- (UIColor *) yp_navigationBackgroundColor {
    return _backgroundColor;
}

- (UIImage *) yp_navigationBackgroundImageWithIdentifier:(NSString *__autoreleasing *)identifier {
    if (identifier) *identifier = _backgroundImageName;
    return _backgroundImage;
}

@end
