//
//  HPPopCircleAnimation.m
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import "HPPopCircleAnimation.h"

@implementation HPPopCircleAnimation
#pragma mark - Init
- (void)setUp {
    //
    [self setUpEmitterLayer];
    //
    [self setUpEmitterCell];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.emitterLayer.emitterPosition = CGPointMake(HPScreenWidth * 0.5, HPScreenHeight * 2 / 3);
}

- (void)setUpEmitterLayer {
    // 发射器在xy平面的中心位置
    self.emitterLayer = [CAEmitterLayer layer];
    // 发射器的尺寸大小
    self.emitterLayer.emitterSize = CGSizeMake(2 * kEmitterSizeW_H, kEmitterSizeW_H);
    // 渲染模式
    self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
    //
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;
    //
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    //
    self.emitterLayer.frame = self.bounds;
}

- (void)setUpEmitterCell {
    // 初始化CAEmitterCell
    NSMutableArray<CAEmitterCell *> *stepEmitterCells = [NSMutableArray array];
    for (NSInteger i = 1; i < 10; i++) {
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.birthRate = 1.5;
        emitterCell.lifetime = arc4random_uniform(5) + 5;
        emitterCell.lifetimeRange = 1.5;
        // 粒子的图片内容
        UIImage *emitterCellImage = [UIImage imageNamed:[NSString stringWithFormat:@"circle_%zd",i]];
        emitterCell.contents = (__bridge id)emitterCellImage.CGImage;
        // 粒子飞行的速度
        emitterCell.velocity = arc4random_uniform(50) + 150;
        // 粒子飞行的速度容差
        emitterCell.velocityRange = 10;
        // 粒子散射的范围
        emitterCell.emissionRange = M_PI / 3;
        // 粒子缩放的倍数
        emitterCell.scale = 0.3;
        // 缩放比例范围
        emitterCell.scaleRange = 0.1;
        //
        emitterCell.yAcceleration = -30;
    
        [stepEmitterCells addObject:emitterCell];
    }
    
    self.emitterCells = stepEmitterCells;
}

@end
