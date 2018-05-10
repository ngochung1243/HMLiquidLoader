//
//  HMLiquidLoader.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "HMLiquidLoader.h"

@implementation HMLiquidLoader
- (instancetype)initWithFrame:(CGRect)frame
                       effect:(HMLiquidLoadEffectType)effect
                        color:(UIColor *)color
                  circleCount:(NSInteger)circleCount
                     duration:(CGFloat)duration
                    growColor:(UIColor *)growColor
                  circleScale:(CGFloat)circleScale {
    if (self = [super initWithFrame:frame]) {
        _effect = effect;
        switch (effect) {
            case HMLiquidLoadEffectTypeCircle: {
                _effectDelegate = [[HMLiquidCircleEffect alloc] initWithLoader:self
                                                                         color:color
                                                                   circleCount:circleCount
                                                                      duration:duration
                                                                     growColor:growColor
                                                                   circleScale:circleScale];
                _effectDelegate.isGrow = YES;
            }
        }
    }
    return self;
}

- (void)startAnimating {
    [self.effectDelegate.timer setPaused:NO];
}

- (void)stopAnimating {
    [self.effectDelegate.timer setPaused:YES];
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    if (self.window == nil) {
        [self.effectDelegate stopTimer];
    }
}
@end
