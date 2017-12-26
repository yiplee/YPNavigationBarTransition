//
//  YPNavigationBarConfiguration.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import <YPNavigationBarTransition/YPNavigationBarProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPBarConfiguration : NSObject

@property (nonatomic, assign, readonly) BOOL hidden;
@property (nonatomic, assign, readonly) UIBarStyle barStyle;
@property (nonatomic, assign, readonly) BOOL translucent;
@property (nonatomic, assign, readonly) BOOL transparent;
@property (nonatomic, strong, readonly) UIColor *tintColor;
@property (nonatomic, strong, readonly, nullable) UIColor *backgroundColor;
@property (nonatomic, strong, readonly, nullable) UIImage *backgroundImage;
@property (nonatomic, strong, readonly, nullable) NSString *backgroundImageIdentifier;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithBarConfigurations:(YPNavigationBarConfigurations)configurations
                                 tintColor:(nullable UIColor*) tintColor
                           backgroundColor:(nullable UIColor *)backgroundColor
                           backgroundImage:(nullable UIImage *)backgroundImage
                 backgroundImageIdentifier:(nullable NSString*)backgroundImageIdentifier NS_DESIGNATED_INITIALIZER;

@end

@interface YPBarConfiguration (YPBarTransition)

- (instancetype) initWithBarConfigurationOwner:(id<YPNavigationBarConfigureStyle>)owner;

- (BOOL) isVisible;

- (BOOL) useSystemBarBackground;

@end

NS_ASSUME_NONNULL_END
