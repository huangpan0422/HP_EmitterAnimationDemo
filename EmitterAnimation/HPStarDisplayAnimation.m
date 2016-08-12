//
//  HPStarDisplayAnimation.m
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import "HPStarDisplayAnimation.h"

@implementation HPStarDisplayAnimation
#pragma mark - Init
- (void)setUp {
    // 使用默认CAEmitterLayer
    [super setUp];
    
    // 初始化CAEmitterCell
    [self setUpEmitterCell];
}

- (void)setUpEmitterCell {
    NSMutableArray<CAEmitterCell *> *stepEmitterCells = [NSMutableArray array];
    for (NSInteger i = 1; i < 10; i++) {
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.birthRate = 1;
        emitterCell.lifetime = arc4random_uniform(5) + 1;
        emitterCell.lifetimeRange = 1.5;
        // 粒子的图片内容
        UIImage *emitterCellImage = [UIImage imageNamed:[NSString stringWithFormat:@"emitter_%zd",i]];
        emitterCell.contents = (__bridge id)emitterCellImage.CGImage;
        // 粒子飞行的速度
        emitterCell.velocity = arc4random_uniform(100) + 100;
        // 粒子飞行的速度
        emitterCell.velocityRange = 100;
        // 粒子飞行的方向（默认向屏幕的右边）
        emitterCell.emissionLongitude = - M_PI_2 ;
        // 粒子散射的范围
        emitterCell.emissionRange = M_PI_2 / 4;
        // 粒子缩放的倍数
        emitterCell.scale = 0.4;
        // 缩放比例范围
        emitterCell.scaleRange = 0.2;
        // 粒子透明度在生命周期内的改变速度
        emitterCell.alphaSpeed = 10;
        // 一个粒子的颜色alpha能改变的范围
        emitterCell.alphaRange = 2;
        
        [stepEmitterCells addObject:emitterCell];
    }
    self.emitterCells = stepEmitterCells;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.emitterLayer.emitterPosition = CGPointMake((HPViewWidth - kEmitterSizeW_H ) / 2, HPViewHeight - kEmitterSizeW_H);
}

@end
