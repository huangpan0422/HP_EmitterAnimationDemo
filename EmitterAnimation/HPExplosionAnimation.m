//
//  HPExplosionAnimation.m
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import "HPExplosionAnimation.h"

@implementation HPExplosionAnimation
#pragma mark - Init
- (void)setUp {
    //
    [self setUpEmitterLayer];
    //
    [self setUpEmitterCell];
    
}

- (void)setUpEmitterLayer {
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.emitterSize = CGSizeMake(5, 5);
    //
    self.emitterLayer.emitterShape = kCAEmitterLayerPoint;
    //
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    
    self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.emitterLayer.emitterPosition = self.center;
}

- (void)setUpEmitterCell {
    
    // 初始化CAEmitterCell
    NSMutableArray<CAEmitterCell *> *stepEmitterCells = [NSMutableArray array];
    for (NSInteger i = 1; i < 9; i++) {
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.birthRate = 1.5;
        emitterCell.lifetime = arc4random_uniform(5) + 5;
        emitterCell.lifetimeRange = 1.5;
        // 粒子的图片内容
        UIImage *emitterCellImage = [UIImage imageNamed:[NSString stringWithFormat:@"explosion_star_%zd",i]];
        emitterCell.contents = (__bridge id)emitterCellImage.CGImage;
        // 粒子飞行的速度
        emitterCell.velocity = arc4random_uniform(5) + 200;
        // 粒子飞行的速度容差
        emitterCell.velocityRange = 10;
        // 粒子散射的范围
        emitterCell.emissionRange = M_PI * 2;
        // 粒子缩放的倍数
        emitterCell.scale = 0.3;
        // 缩放比例范围
        emitterCell.scaleRange = 0.1;
        //
        emitterCell.scaleSpeed = 0.1;
        
        [stepEmitterCells addObject:emitterCell];
    }
    
    self.emitterCells = stepEmitterCells;
}
@end
