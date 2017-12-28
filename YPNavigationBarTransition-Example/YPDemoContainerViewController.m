//
//  YPDemoContainerViewController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPDemoContainerViewController.h"
#import "YPDemoConfigureViewController.h"
#import "YPNavigationTitleLabel.h"

@interface YPDemoContainerViewController ()

@end

@implementation YPDemoContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    YPDemoConfigureViewController *conf = [YPDemoConfigureViewController new];
    [self addChildViewController:conf];
    
    UIView *confView = conf.view;
    confView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    confView.frame = self.view.bounds;
    [self.view addSubview:confView];
    [conf didMoveToParentViewController:self];
    
    YPNavigationTitleLabel *titleView = nil;
    if ([self.navigationItem.titleView isKindOfClass:YPNavigationTitleLabel.class]) {
        titleView = (YPNavigationTitleLabel *)self.navigationItem.titleView;
    }
    titleView.textColor = self.configurations & YPNavigationBarStyleBlack ? [UIColor whiteColor] : [UIColor blackColor];
    
    UIBarButtonItem *popToRoot = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                               target:self
                                                                               action:@selector(popToRoot:)];
    self.navigationItem.rightBarButtonItem = popToRoot;
}

- (void) setTitle:(NSString *)title {
    [super setTitle:title];
    
    YPNavigationTitleLabel *titleView = nil;
    if ([self.navigationItem.titleView isKindOfClass:YPNavigationTitleLabel.class]) {
        titleView = (YPNavigationTitleLabel *)self.navigationItem.titleView;
    }
    
    if (!titleView) {
        titleView = [YPNavigationTitleLabel new];
    }
    
    titleView.text = title;
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

- (void) popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
