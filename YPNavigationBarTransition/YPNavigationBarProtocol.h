//
//  YPNavigationBarProtocol.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YPNavigationBarConfigurations) {
    YPNavigationBarShow   = 0,          // show navigationBar
    YPNavigationBarHidden = 1,          // hide navigationBar
    
    // bar style
    YPNavigationBarStyleLight = 0 << 4,  // UIbarStyleDefault
    YPNavigationBarStyleBlack = 1 << 4,  // UIbarStyleBlack
    
    YPNavigationBarBackgroundStyleTranslucent = 0 << 8,
    YPNavigationBarBackgroundStyleOpaque      = 1 << 8,
    YPNavigationBarBackgroundStyleTransparent = 2 << 8,
    
    // bar background
    YPNavigationBarBackgroundStyleNone  = 0 << 16,
    YPNavigationBarBackgroundStyleColor = 1 << 16,
    YPNavigationBarBackgroundStyleImage = 2 << 16,
    
    YPNavigationBarConfigurationsDefault = 0,
};

@protocol YPNavigationBarConfigureStyle <NSObject>

- (YPNavigationBarConfigurations) yp_navigtionBarConfiguration;

- (UIColor *) yp_navigationBarTintColor;

@optional

/*
 *  identifier 用来比较 image 是否是同
 */
- (UIImage *) yp_navigationBackgroundImageWithIdentifier:(NSString **)identifier;

- (UIColor *) yp_navigationBackgroundColor;

@end
