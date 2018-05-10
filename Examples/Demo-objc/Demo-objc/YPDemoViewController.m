//
//  YPDemoViewController.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPDemoViewController.h"
#import "YPDemoConfigureViewController.h"
#import "YPNavigationTitleLabel.h"

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
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                 target:self
                                                                                 action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
    YPNavigationTitleLabel *titleView = [YPNavigationTitleLabel new];
    titleView.text = self.title;
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

- (void) shareAction:(id)sender {
    NSString *const githubLink = @"https://github.com/yiplee/YPNavigationBarTransition";
    NSURL *shareURL = [NSURL URLWithString:githubLink];
    UIActivityViewController *share = [[UIActivityViewController alloc] initWithActivityItems:@[shareURL]
                                                                        applicationActivities:nil];
    share.popoverPresentationController.barButtonItem = sender;
    [self presentViewController:share animated:YES completion:nil];
}

@end
