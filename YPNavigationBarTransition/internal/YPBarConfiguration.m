//
//  YPNavigationBarConfiguration.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPBarConfiguration.h"

@implementation YPBarConfiguration

- (instancetype) init {
    return [self initWithBarConfigurations:YPNavigationBarConfigurationsDefault
                                 tintColor:nil
                           backgroundColor:nil
                           backgroundImage:nil
                 backgroundImageIdentifier:nil];
}

- (instancetype) initWithBarConfigurations:(YPNavigationBarConfigurations)configurations
                                 tintColor:(UIColor *)tintColor
                           backgroundColor:(UIColor *)backgroundColor
                           backgroundImage:(UIImage *)backgroundImage
                 backgroundImageIdentifier:(NSString *)backgroundImageIdentifier{
    self = [super init];
    if (!self) return nil;
    
    do {
        _hidden = configurations & YPNavigationBarHidden;
        
        _barStyle = configurations & YPNavigationBarStyleBlack ? UIBarStyleBlack : UIBarStyleDefault;
        if (!tintColor) {
            tintColor = _barStyle == UIBarStyleBlack ? [UIColor whiteColor] : [UIColor blackColor];
        }
        _tintColor = tintColor;
        
        _transparent = configurations & YPNavigationBarBackgroundStyleTransparent;
        if (_transparent) break;
        _translucent = !(configurations & YPNavigationBarBackgroundStyleOpaque);
        
        if ((configurations & YPNavigationBarBackgroundStyleImage) && _backgroundImage) {
            _backgroundImage = backgroundImage;
            _backgroundImageIdentifier = [backgroundImageIdentifier copy];
        } else if (configurations & YPNavigationBarBackgroundStyleColor){
            _backgroundColor = backgroundColor;
        }
    } while (0);
    
    return self;
}

@end

@implementation YPBarConfiguration (YPBarTransition)

- (instancetype) initWithBarConfigurationOwner:(id<YPNavigationBarConfigureStyle>)owner {
    YPNavigationBarConfigurations configurations = [owner yp_navigtionBarConfiguration];
    UIColor *tintColor = [owner yp_navigationBarTintColor];
    
    UIImage *backgroundImage  = nil;
    NSString *imageIdentifier = nil;
    UIColor *backgroundColor = nil;
    
    if (!(configurations & YPNavigationBarBackgroundStyleTransparent)) {
        if (configurations & YPNavigationBarBackgroundStyleImage) {
            backgroundImage = [owner yp_navigationBackgroundImageWithIdentifier:&imageIdentifier];
        } else {
            backgroundColor = [owner yp_navigationBackgroundColor];
        }
    }
    
    return [self initWithBarConfigurations:configurations
                                 tintColor:tintColor
                           backgroundColor:backgroundColor
                           backgroundImage:backgroundImage
                 backgroundImageIdentifier:imageIdentifier];
}

- (BOOL) isVisible {
    return !self.hidden && !self.transparent;
}

- (BOOL) useSystemBarBackground {
    return !self.backgroundColor && !self.backgroundImage;
}

@end
