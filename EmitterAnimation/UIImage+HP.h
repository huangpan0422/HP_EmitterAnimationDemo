//
//  UIImage+HP.h
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HP)
/**
 *  根据UIColor生成一张Size大小的图片 
 *  color为nil则默认是白色，size为0 * 0则默认1 * 1
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
/**
 *  根据UIColor生成半径为radius的圆形图片
 *  color为nil则默认是白色，radius为0则默认“1“
 */
+ (UIImage *)imageWithColor:(UIColor *)color andRadius:(CGFloat)radius;
@end
