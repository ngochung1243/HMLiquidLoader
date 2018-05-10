//
//  HMLiquidLoader.h
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMLiquidCircleEffect.h"

typedef NS_ENUM(NSInteger, HMLiquidLoadEffectType) {
    HMLiquidLoadEffectTypeCircle
};

@interface HMLiquidLoader : UIView
@property (assign, nonatomic) HMLiquidLoadEffectType    effect;
@property (strong, nonatomic) HMLiquidLoadEffect        *effectDelegate;
- (instancetype)initWithFrame:(CGRect)frame
                       effect:(HMLiquidLoadEffectType)effect
                        color:(UIColor *)color
                  circleCount:(NSInteger)circleCount
                     duration:(CGFloat)duration
                    growColor:(UIColor *)growColor
                  circleScale:(CGFloat)circleScale;

- (void)startAnimating;
- (void)stopAnimating;
@end
