//
//  HMLiquidLoaderEngine.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "HMLiquidLoaderEngine.h"
#import "HMLiquidUtils.h"

@implementation HMLiquidLoaderEngine

- (instancetype)init {
    if (self = [super init]) {
        self.angleThresh = 0.5f;
        self.connectThresh = 0.3f;
        self.color = [UIColor new];
    }
    return self;
}
- (id)initWithRadiusThresh:(CGFloat)radiusThresh angleThresh:(CGFloat)angleThresh {
    if (self = [self init]) {
        self.radiusThresh = radiusThresh;
        self.angleThresh = angleThresh;
    }
    return self;
}

- (NSArray<HMLiquittableCircle *> *)pushCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other {
    NSArray *paths = [self generateConnectedPathWithCircle:circle other:other];
    if (!paths) return [NSArray new];
    for (UIBezierPath *path in paths) {
        CALayer *layer = [self constructLayerWithPath:path];
        [self.layer addSublayer:layer];
    }
    return @[circle, other];
}

- (void)drawInParent:(UIView *)parent {
    [parent.layer addSublayer:self.layer];
}

- (void)clear {
    [self.layer removeFromSuperlayer];
    NSArray *subLayers = [self.layer.sublayers copy];
    for (CALayer *sub in subLayers) {
        [sub removeFromSuperlayer];
    }
    self.layer = [CAShapeLayer new];
}

- (CALayer *)constructLayerWithPath:(UIBezierPath *)path {
    CGRect pathBounds = CGPathGetBoundingBox(path.CGPath);
    CAShapeLayer *shape = [CAShapeLayer new];
    shape.fillColor = self.color.CGColor;
    shape.path = path.CGPath;
    shape.frame = CGRectMake(0, 0, pathBounds.size.width, pathBounds.size.height);
    return shape;
}

- (NSArray<UIBezierPath *> *)generateConnectedPathWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other {
    if (![self isConnectedWithCircle:circle other:other]) return nil;
    
    CGFloat ratio = [self circleRatioWithCircle:circle other:other];
    if (self.angleThresh <= ratio && ratio <= 1.0f) {
        UIBezierPath *path = [self normalPathWithCircle:circle other:other];
        return @[path];
    }
//    else if (0.0f <= ratio && ratio < self.angleThresh) {
//        NSArray *paths = [self splitPathWithCircle:circle other:other radio:ratio];
//        return paths;
//    }
    return nil;
}

- (UIBezierPath *)normalPathWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other {
    NSArray *connectPoints1 = [self circleConnectedPointWithCircle:circle other:other];
    NSArray *connectPoints2 = [self circleConnectedPointWithCircle:other other:circle];
    if (!connectPoints1 || !connectPoints2) return nil;
    
    CGPoint p1 = [connectPoints1[0] CGPointValue];
    CGPoint p2 = [connectPoints1[1] CGPointValue];
    CGPoint m1 = [connectPoints1[2] CGPointValue];
    
    CGPoint p3 = [connectPoints2[0] CGPointValue];
    CGPoint p4 = [connectPoints2[1] CGPointValue];
    CGPoint crossed = INTERSECTION_POINT(p1, p3, p2, p4);
    __weak __typeof(self) weakSelf = self;
    UIBezierPath *bezierPath = BEZIER_PATH(^(UIBezierPath *path) {
        CGFloat ratio = [weakSelf circleRatioWithCircle:circle other:other];
        [path moveToPoint:p1];
        CGPoint mulPoint = SPLIT_POINT(DIV_POINT(PLUS_POINT(p1, p4), 2), crossed, ratio * 1.25f - 0.25f);
        [path addQuadCurveToPoint:p4 controlPoint:mulPoint];
        [path addQuadCurveToPoint:p3 controlPoint:m1];
        CGPoint mulPoint2 = SPLIT_POINT(DIV_POINT(PLUS_POINT(p2, p3), 2), crossed, ratio * 1.25f - 0.25f);
        [path addQuadCurveToPoint:p2 controlPoint:mulPoint2];
    });
    return bezierPath;
}

- (NSArray<UIBezierPath *> *)splitPathWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other radio:(CGFloat)radio {
    NSArray *connectPoints1 = [self circleConnectedPointWithCircle:circle other:other angle:DEG_TO_RAD(40)];
    NSArray *connectPoints2 = [self circleConnectedPointWithCircle:other other:circle angle:DEG_TO_RAD(40)];
    if (!connectPoints1 || !connectPoints2) return nil;
    
    CGPoint p1 = [connectPoints1[0] CGPointValue];
    CGPoint p2 = [connectPoints1[1] CGPointValue];
    CGPoint p3 = [connectPoints2[0] CGPointValue];
    CGPoint p4 = [connectPoints2[1] CGPointValue];
    CGPoint crossed = INTERSECTION_POINT(p1, p3, p2, p4);
    NSArray *connectPoints3 = [self circleConnectedPointWithCircle:circle other:other angle:0];
    NSArray *connectPoints4 = [self circleConnectedPointWithCircle:other other:circle angle:0];
    if (!connectPoints3 || !connectPoints4) return nil;
    
    CGPoint d1 = [connectPoints3[0] CGPointValue];
    CGPoint d2 = [connectPoints4[0] CGPointValue];
    CGFloat r = (radio - self.connectThresh) / (self.angleThresh - self.connectThresh);
    
    CGPoint a1 = SPLIT_POINT(d1, MID_POINT(crossed, d2), 1-r);
    UIBezierPath *path = BEZIER_PATH(^(UIBezierPath *path) {
        [path moveToPoint:p1];
        [path addQuadCurveToPoint:p2 controlPoint:a1];
    });
    CGPoint a2 = SPLIT_POINT(d2, MID_POINT(crossed, d1), 1-r);
    UIBezierPath *path2 = BEZIER_PATH(^(UIBezierPath *path) {
        [path moveToPoint:p3];
        [path addQuadCurveToPoint:p4 controlPoint:a2];
    });
    return @[path, path2];
}

- (NSArray *)circleConnectedPointWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other angle:(CGFloat)angle {
    CGPoint vec = MINUS_POINT(other.center, circle.center);
    CGFloat radian = atan2(vec.y, vec.x);
    CGPoint p1 = [circle circlePointWithRad:(radian + angle)];
    CGPoint p2 = [circle circlePointWithRad:(radian - angle)];
    CGPoint m1 = [circle circlePointWithRad:radian];
    return @[@(p1), @(p2), @(m1)];
}

- (NSArray *)circleConnectedPointWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other {
    CGFloat ratio = [self circleRatioWithCircle:circle other:other];
    ratio = (ratio + self.connectThresh) / (1.0f + self.connectThresh);
    CGFloat angle = M_PI / 2 * ratio;
    return [self circleConnectedPointWithCircle:circle other:other angle:angle];
}

- (CGFloat)circleRatioWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other {
    CGFloat distance = LENGTH_POINT(MINUS_POINT(other.center, circle.center));
    CGFloat ratio = 1.0f - (distance - self.radiusThresh) / (circle.radius + other.radius + self.radiusThresh);
    return MIN(MAX(ratio, 0.0f), 1.0f);
}

- (BOOL)isConnectedWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other {
    CGFloat distance = LENGTH_POINT(MINUS_POINT(circle.center, other.center));
    return distance - circle.radius - other.radius < self.radiusThresh;
}
@end





