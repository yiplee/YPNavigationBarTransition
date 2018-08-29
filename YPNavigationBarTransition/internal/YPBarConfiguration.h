/*
MIT License

Copyright (c) 2017 yiplee

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#import <YPNavigationBarTransition/YPNavigationBarProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface YPBarConfiguration : NSObject

@property (nonatomic, assign, readonly) BOOL hidden;
@property (nonatomic, assign, readonly) UIBarStyle barStyle;
@property (nonatomic, assign, readonly) BOOL translucent;
@property (nonatomic, assign, readonly) BOOL transparent;
@property (nonatomic, assign, readonly) BOOL shadowImage;
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
