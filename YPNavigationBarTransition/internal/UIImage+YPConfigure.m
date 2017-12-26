//
//  UIImage+YPConfigure.m
//  YPNavigationBarTransition
//
//  Created by Guoyin Lee on 24/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "UIImage+YPConfigure.h"

@implementation UIImage (YPConfigure)

+ (UIImage *) yp_transparentImage {
    return [self new];
}

+ (UIImage *) yp_imageWithColor:(UIColor *)color {
    return [self yp_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *) yp_imageWithColor:(UIColor *)color size:(CGSize) size {
    size.width = MAX(0.5, size.width);
    size.height = MAX(0.5, size.height);
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
