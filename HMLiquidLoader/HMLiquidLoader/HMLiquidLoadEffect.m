//
//  HMLiquidLoadEffect.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "HMLiquidLoadEffect.h"
#import "HMLiquidLoader.h"

@implementation HMLiquidLoadEffect
- (void)setIsGrow:(BOOL)isGrow {
    if (_isGrow == isGrow) return;
    _isGrow = isGrow;
    [self grow:isGrow];
}

- (void)setKey:(CGFloat)key {
    if (_key == key) return;
    _key = key;
    [self updateKeyframeWithKey:key];
}

- (instancetype)init {
    if (self = [super init]) {
        _circleScale = 1.2f;
        _moveScale = 0.95f;
        _color = UIColor.whiteColor;
        _growColor = UIColor.redColor;
    }
    return self;
}

- (id)initWithLoader:(HMLiquidLoader *)loader
               color:(UIColor *)color
         circleCount:(NSInteger)circleCount
            duration:(CGFloat)duration
           growColor:(UIColor *)growColor
         circleScale:(CGFloat)circleScale {
    if (self = [self init]) {
        _numberOfCircles = circleCount;
        _duration = duration;
        _circleRadius = loader.frame.size.width * 0.5;
        _loader = loader;
        _color = color;
        _growColor = growColor;
        if (circleScale != 0) {
            _circleScale = circleScale;
        }
        
        [self setup];
    }
    return self;
}

- (void)resize {
    
}

- (void)setup {
    [self willSetup];
    self.engine.color = self.color;
    self.circles = [self setupShape];
    for (HMLiquittableCircle *circle in self.circles) {
        [self.loader addSubview:circle];
    }
    if (self.moveCircle) {
        [self.loader addSubview:self.moveCircle];
    }
    
    [self resize];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [self.timer setPaused:YES];
}

- (void)updateKeyframeWithKey:(CGFloat)key {
    [self.engine clear];
    CGPoint movePos = [self movePositionWithKey:key];
    
    self.moveCircle.center = movePos;
    self.shadowCircle.center = movePos;
    for (HMLiquittableCircle *circle in self.circles) {
        if (self.moveCircle) {
            [self.engine pushCircle:self.moveCircle other:circle];
        }
    }
    
    [self resize];
    
    //Draw and show grow
    if (self.loader) {
        [self.engine drawInParent:self.loader];
    }
    
    [self.loader bringSubviewToFront:self.shadowCircle];
}

- (NSArray<HMLiquittableCircle *> *)setupShape {
    //TODO:
    return nil;
}

- (CGPoint)movePositionWithKey:(CGFloat)key {
    //TODO:
    return CGPointZero;
}

- (void)update {
    //TODO:
}

- (void)willSetup {
    
}

- (void)grow:(BOOL)isGrow {
    if (isGrow) {
        self.shadowCircle = [[HMLiquittableCircle alloc] initWithCenter:self.moveCircle.center radius:self.moveCircle.radius color:self.color growColor:self.growColor];
        self.shadowCircle.isGrow = isGrow;
        [self.loader addSubview:self.shadowCircle];
    }
    else {
        [self.shadowCircle removeFromSuperview];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
}

@end
