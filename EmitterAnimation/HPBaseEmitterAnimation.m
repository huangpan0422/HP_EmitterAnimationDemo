//
//  HPBaseEmitterAnimation.m
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import "HPBaseEmitterAnimation.h"

@interface HPBaseEmitterAnimation () {
    BOOL _pause;
}
@end

@implementation HPBaseEmitterAnimation
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}


// 子类可重写
- (void)setUp {
    _emitterLayer = [CAEmitterLayer layer];
    // 发射器的尺寸大小
    self.emitterLayer.emitterSize = CGSizeMake(HPScreenWidth, kEmitterSizeW_H);
    // 渲染模式
    self.emitterLayer.renderMode = kCAEmitterLayerUnordered;
    //
    self.emitterLayer.emitterShape = kCAEmitterLayerSphere;
    //
    self.emitterLayer.frame = self.bounds;
}

#pragma mark - Public API
- (void)start {
    if (_emitterLayer && _emitterLayer.superlayer) {
        return;
    };
    self.emitterLayer.emitterCells = _emitterCells;
    [self.layer addSublayer:self.emitterLayer];
}

- (void)stop {
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
    }
}

- (void)pause {
    if (_emitterLayer && _emitterLayer.superlayer && !_pause) {
        _pause = YES;
        CFTimeInterval pausedTime =  [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.layer.speed = 0.0f;
        self.layer.timeOffset = pausedTime;
    }
}

- (void)resume {
    if (_emitterLayer && _emitterLayer.superlayer && _pause) {
        _pause = NO;
        CFTimeInterval pausedTime = [self.layer timeOffset];
        self.layer.speed = 1.0;
        self.layer.timeOffset = 0.0;
        self.layer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.layer.beginTime = timeSincePause;
    }
}

+ (instancetype)animation {
    HPBaseEmitterAnimation * animation = [[self alloc] initWithFrame:CGRectZero];
    animation.translatesAutoresizingMaskIntoConstraints = NO;
    return animation;
}

#pragma mark - Getter and Setter
- (void)setEmitterCells:(NSArray<CAEmitterCell *> *)emitterCells {
    if (![_emitterCells isEqualToArray:emitterCells]) {
        if (_emitterCells) {
            _emitterCells = emitterCells;
            [self start];
        } else {
            _emitterCells = emitterCells;
        }
    }
}
@end
