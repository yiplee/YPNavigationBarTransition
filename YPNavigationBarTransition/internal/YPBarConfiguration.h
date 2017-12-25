//
//  YPNavigationBarConfiguration.h
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "YPNavigationBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YPBarConfiguration : NSObject

@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) UIBarStyle barStyle;
@property (nonatomic, assign) BOOL translucent;
@property (nonatomic, assign) BOOL transparent;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong, nullable) UIColor *backgroundColor;
@property (nonatomic, strong, nullable) UIImage *backgroundImage;
@property (nonatomic, strong, nullable) NSString *backgroundImageIdentifier;

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

@end

NS_ASSUME_NONNULL_END
