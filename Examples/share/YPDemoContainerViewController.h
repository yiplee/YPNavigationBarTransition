//
//  YPDemoContainerViewController.h
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 25/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YPNavigationBarTransition/YPNavigationBarTransition.h>

@interface YPDemoContainerViewController : UIViewController<YPNavigationBarConfigureStyle>

@property (nonatomic, assign) YPNavigationBarConfigurations configurations;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;

@end
