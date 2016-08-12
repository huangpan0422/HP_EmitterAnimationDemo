//
//  ViewController.m
//  EmitterAnimation
//
//  Created by huangpan on 16/7/12.
//  Copyright © 2016年 huangpan. All rights reserved.
//

#import "ViewController.h"
#import "HPStarDisplayAnimation.h"
#import "HPPopCircleAnimation.h"
#import "HPExplosionAnimation.h"

@interface ViewController () {
    HPBaseEmitterAnimation *_curSelectAnimation;
    // 当前是否是暂停
    BOOL _curStatusIsPause;
}
@property (nonatomic, strong) HPStarDisplayAnimation *starAnimation;
@property (nonatomic, strong) HPPopCircleAnimation *popAnimation;
@property (nonatomic, strong) HPExplosionAnimation *explosionAnimation;
@end

@implementation ViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _starAnimation = [HPStarDisplayAnimation animation];
    _popAnimation  = [HPPopCircleAnimation animation];
    _explosionAnimation = [HPExplosionAnimation animation];
    [self.view addSubview:self.starAnimation];
    [self.view addSubview:self.popAnimation];
    [self.view addSubview:self.explosionAnimation];
    //
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_popAnimation]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_popAnimation)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_popAnimation]-60-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_popAnimation)]];
    //
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_explosionAnimation]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_explosionAnimation)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_explosionAnimation]-60-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_explosionAnimation)]];
    //
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_starAnimation]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_starAnimation)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_starAnimation]-60-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_starAnimation)]];
    _curSelectAnimation = self.starAnimation;
    //
    [self setUpToolsButton];
}

- (void)setUpToolsButton {
    UIButton *(^createButton)(UIColor *, NSString *) = ^(UIColor *bgColor, NSString *title) {
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.backgroundColor = bgColor;
        tempBtn.layer.cornerRadius = 6;
        tempBtn.clipsToBounds = YES;
        tempBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [tempBtn setTitle:title forState:UIControlStateNormal];
        [tempBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:tempBtn];
        return tempBtn;
    };
    //
    UIButton *changeAnimationButton = createButton([UIColor redColor], @"切换");
    [changeAnimationButton addTarget:self action:@selector(changeAnimation:) forControlEvents:UIControlEventTouchUpInside];
    //
    UIButton *fireButton = createButton([UIColor greenColor], @"开始");
    [fireButton addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    //
    UIButton *stopButton = createButton([UIColor darkGrayColor], @"停止");
    [stopButton addTarget:self action:@selector(stopAnimation:) forControlEvents:UIControlEventTouchUpInside];
    //
    UIButton *pauseButton = createButton([UIColor purpleColor], @"暂停");
    _curStatusIsPause = NO;
    [pauseButton addTarget:self action:@selector(pauseAnimation:) forControlEvents:UIControlEventTouchUpInside];
    //
    NSDictionary *_views = @{@"fire"  : fireButton,
                             @"stop"  : stopButton,
                             @"change": changeAnimationButton,
                             @"pause" : pauseButton};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[fire(==44)]-8-|" options:0 metrics:nil views:_views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[fire]-[stop(==fire)]-[change(==fire)]-[pause(==fire)]-5-|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:_views]];
}

#pragma mark - Event Handle
- (void)startAnimation:(UIButton *)sender {
    [_curSelectAnimation start];
}

- (void)stopAnimation:(UIButton *)sender {
    [_curSelectAnimation stop];
}

- (void)pauseAnimation:(UIButton *)sender {
    if ( _curStatusIsPause ) {
        _curStatusIsPause = NO;
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [_curSelectAnimation resume];
    } else {
        _curStatusIsPause = YES;
        [sender setTitle:@"恢复" forState:UIControlStateNormal];
        [_curSelectAnimation pause];
    }
}

- (void)changeAnimation:(UIButton *)sender {
    [_curSelectAnimation stop];
    if (_curSelectAnimation == self.starAnimation) {
        _curSelectAnimation = self.popAnimation;
    } else if (_curSelectAnimation == self.popAnimation) {
        _curSelectAnimation = self.explosionAnimation;
    } else {
        _curSelectAnimation = self.starAnimation;
    }
    [self.view bringSubviewToFront:_curSelectAnimation];
    [_curSelectAnimation start];
}

#pragma mark - Receive Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
