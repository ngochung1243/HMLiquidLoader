//
//  HMLiquidCircleEffect.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "HMLiquidCircleEffect.h"
#import "HMLiquidLoader.h"
#import "HMLiquidUtils.h"

@implementation HMLiquidCircleEffect
- (CGFloat)radius {
    return self.loader.frame.size.width * 0.5;
}

- (NSArray<HMLiquittableCircle *> *)setupShape {
    NSMutableArray *circles = [NSMutableArray new];
    for (int i = 0; i < self.numberOfCircles; i++) {
        CGFloat angle = i * 2 * M_PI / 8.0f;
        CGRect frame = self.loader.frame;
        CGPoint center = [HMLiquidUtils circlePointWithCenter:MINUS_POINT(CENTER_RECT(frame), frame.origin) radius:self.radius - self.circleRadius rad:angle];
        HMLiquittableCircle *circle = [[HMLiquittableCircle alloc] initWithCenter:center radius:self.circleRadius color:self.color growColor:self.growColor];
        circle.isStroke = YES;
        [circles addObject:circle];
    }
    return circles;
}

- (CGPoint)movePositionWithKey:(CGFloat)key {
    if (!self.loader) return CGPointZero;
    CGFloat angle = self.key * 2 * M_PI;
    CGPoint frame = MINUS_POINT(CENTER_RECT(self.loader.frame), self.loader.frame.origin);
    CGPoint circlePoint = CIRCLE_POINT(frame, self.radius - self.circleRadius, angle);
    return circlePoint;
}

- (void)update {
    if (0.0f <= self.key && self.key <= 1.0f) {
        self.key += 1 / (self.duration * 60);
    }
    else {
        self.key = self.key - 1.0f;
    }
}

- (void)willSetup {
    self.circleRadius = CGRectGetWidth(self.loader.frame) * 0.09;
    self.engine = [[HMLiquidLoaderEngine alloc] initWithRadiusThresh:self.circleRadius * 0.85 angleThresh:0.5f];
    CGFloat moveCircleRadius = self.circleRadius * self.moveScale;
    self.moveCircle = [[HMLiquittableCircle alloc] initWithCenter:[self movePositionWithKey:0.0f] radius:moveCircleRadius color:self.color growColor:self.growColor];
}

- (void)resize {
    if (!self.moveCircle || !self.loader) return;
    CGPoint moveVec = NORMALIZED_POINT(MINUS_POINT(self.moveCircle.center, MINUS_POINT(self.loader.center, self.loader.frame.origin)));
    for (HMLiquittableCircle *circle in self.circles) {
        CGFloat dot = DOT_POINT(moveVec, NORMALIZED_POINT(MINUS_POINT(circle.center, MINUS_POINT(self.loader.center, self.loader.frame.origin))));
        if (0.75 < dot && dot <= 1.0f) {
            CGFloat normalized = (dot - 0.75) / 0.25;
            CGFloat scale = pow(normalized, 2);
            circle.radius = self.circleRadius + (self.circleRadius * self.circleScale - self.circleRadius) * scale;
        }
        else {
            circle.radius = self.circleRadius;
        }
    }
}

@end
