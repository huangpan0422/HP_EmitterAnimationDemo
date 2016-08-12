//
//  HPBaseEmitterAnimation.h
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import <UIKit/UIKit.h>


#define HPScreenWidth   [UIScreen mainScreen].bounds.size.width
#define HPScreenHeight  [UIScreen mainScreen].bounds.size.height

#define HPViewWidth     self.frame.size.width
#define HPViewHeight    self.frame.size.height

static CGFloat const kEmitterSizeW_H = 50.0f;

@interface HPBaseEmitterAnimation : UIView
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, copy) NSArray<CAEmitterCell *> *emitterCells;
+ (instancetype)animation;
/**
 *  初始化设置
 */
- (void)setUp;
/**
 *  开始，已经开始则继续
 */
- (void)start;
/**
 *  停止动画，清空屏幕
 */
- (void)stop;
/**
 *  暂停动画
 */
- (void)pause;
/**
 *  重启动画
 */
- (void)resume;
@end
