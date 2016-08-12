//
//  UIImage+HP.m
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import "UIImage+HP.h"

@implementation UIImage (HP)
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    color = color ? : [UIColor whiteColor];
    size = CGSizeEqualToSize(size, CGSizeZero) ? CGSizeMake(1.0f, 1.0f) : size;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color andRadius:(CGFloat)radius {
    color = color ? : [UIColor whiteColor];
    radius = (radius < 0.001f) ? 1.0f : radius;
    CGSize size = CGSizeMake(radius * 2, radius * 2);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
