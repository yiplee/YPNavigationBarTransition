//
//  UIImage+color.m
//  YPNavigationBarTransition-Example
//
//  Created by Guoyin Lee on 26/12/2017.
//  Copyright © 2017 yiplee. All rights reserved.
//

#import "UIImage+color.h"

@implementation UIImage (color)

+ (instancetype) imageWithColor:(UIColor *)color {
    CGSize size = (CGSize){1,1};
    
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
