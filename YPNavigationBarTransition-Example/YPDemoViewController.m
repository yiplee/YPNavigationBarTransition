//
//  YPDemoViewController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPDemoViewController.h"
#import "YPDemoConfigureViewController.h"

@interface YPDemoViewController ()

@end

@implementation YPDemoViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"YPNavigationBarTransition";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
    
    YPDemoConfigureViewController *conf = [YPDemoConfigureViewController new];
    [self addChildViewController:conf];
    
    UIView *confView = conf.view;
    confView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    confView.frame = self.view.bounds;
    [self.view addSubview:confView];
    [conf didMoveToParentViewController:self];
}

@end
