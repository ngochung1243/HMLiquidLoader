//
//  HMLiquidLoadEffect.h
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMLiquidLoaderEngine.h"
#import "HMLiquittableCircle.h"

@class HMLiquidLoader;

@interface HMLiquidLoadEffect : NSObject
@property (assign, nonatomic) NSInteger     numberOfCircles;
@property (assign, nonatomic) CGFloat       duration;
@property (assign, nonatomic) CGFloat       circleScale;
@property (assign, nonatomic) CGFloat       moveScale;
@property (strong, nonatomic) UIColor       *color;
@property (strong, nonatomic) UIColor       *growColor;

@property (strong, nonatomic) HMLiquidLoaderEngine  *engine;
@property (strong, nonatomic) HMLiquittableCircle   *moveCircle;
@property (strong, nonatomic) HMLiquittableCircle   *shadowCircle;

@property (strong, nonatomic) CADisplayLink         *timer;
@property (weak, nonatomic)   HMLiquidLoader        *loader;

@property (assign, nonatomic) BOOL          isGrow;
@property (strong, nonatomic) NSArray       *circles;
@property (assign, nonatomic) CGFloat       circleRadius;
@property (assign, nonatomic) CGFloat       key;

- (id)initWithLoader:(HMLiquidLoader *)loader
               color:(UIColor *)color
         circleCount:(NSInteger)circleCount
            duration:(CGFloat)duration
           growColor:(UIColor *)growColor
         circleScale:(CGFloat)circleScale;

- (void)resize;
- (void)setup;
- (void)updateKeyframeWithKey:(CGFloat)key;
- (NSArray<HMLiquittableCircle *> *)setupShape;
- (CGPoint)movePositionWithKey:(CGFloat)key;
- (void)update;
- (void)willSetup;
- (void)grow:(BOOL)isGrow;
- (void)stopTimer;

@end
