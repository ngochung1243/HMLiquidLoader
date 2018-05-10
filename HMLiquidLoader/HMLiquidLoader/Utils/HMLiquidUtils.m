//
//  HMLiquidUtils.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "HMLiquidUtils.h"

@implementation HMLiquidUtils
+ (CGPoint)plusPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}

+ (CGPoint)minusPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}

+ (CGPoint)mulPoint:(CGPoint)point rhs:(CGFloat)rhs {
    return CGPointMake(point.x * rhs, point.y * rhs);
}

+ (CGPoint)divPoint:(CGPoint)point rhs:(CGFloat)rhs {
    return CGPointMake(point.x / rhs, point.y / rhs);
}

+ (CGFloat)lengthOfPoint:(CGPoint)point {
    return sqrt(pow(point.x, 2) + pow(point.y, 2));
}

+ (CGPoint)normalizedPoint:(CGPoint)point {
    return DIV_POINT(point, LENGTH_POINT(point));
}

+ (CGFloat)dotPoint1:(CGPoint)point point2:(CGPoint)point2 {
    return point.x * point2.x + point.y * point2.y;
}

+ (CGFloat)crossPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    return point1.x * point2.y - point1.y * point2.x;
}

+ (CGPoint)splitPoint1:(CGPoint)point point2:(CGPoint)point2 ratio:(CGFloat)ratio {
    return PLUS_POINT(MUL_POINT(point, ratio), MUL_POINT(point2, 1.0f - ratio));
}

+ (CGPoint)midPoint1:(CGPoint)point1 point2:(CGPoint)point2 {
    return SPLIT_POINT(point1, point2, 0.5f);
}

+ (CGPoint)intersectionFromPoint:(CGPoint)fromPoint1 toPoint:(CGPoint)toPoint1 fromPoint2:(CGPoint)fromPoint2 toPoint2:(CGPoint)toPoint2 {
    CGPoint ac = CGPointMake(toPoint1.x - fromPoint1.x, toPoint1.y - fromPoint1.y);
    CGPoint bd = CGPointMake(toPoint2.x - fromPoint2.x, toPoint2.y - fromPoint2.y);
    CGPoint ab = CGPointMake(fromPoint2.x - fromPoint1.x, fromPoint2.y - fromPoint1.y);
    CGPoint bc = CGPointMake(toPoint1.x - fromPoint2.x, toPoint1.y - fromPoint2.y);
    
    CGFloat area = CROSS_POINT(bd, ab);
    CGFloat area2 = CROSS_POINT(bd, bc);
    
    if (fabs(area + area2) >=  0.1f) {
        CGFloat ratio = area / (area + area2);
        return CGPointMake(fromPoint1.x + ratio * ac.x, fromPoint1.y + ratio * ac.y);
    }
    return CGPointZero;
}

+ (CGPoint)rightBottomFromRect:(CGRect)rect {
    return CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
}

+ (CGPoint)centerFromRect:(CGRect)rect {
    return MUL_POINT(PLUS_POINT(rect.origin, RIGHT_BOTTOM_RECT(rect)), 0.5f);
}

+ (UIBezierPath *)bezierPathWithCompletion:(void(^)(UIBezierPath *bezierPath))completion {
    UIBezierPath *newPath = [UIBezierPath new];
    completion(newPath);
    [newPath closePath];
    return newPath;
}

+ (CGFloat)radToDeg:(CGFloat)rad {
    return rad * 180 / M_PI;
}

+ (CGFloat)degToRad:(CGFloat)deg {
    return deg * M_PI / 180;
}

+ (CGPoint)circlePointWithCenter:(CGPoint)center radius:(CGFloat)radius rad:(CGFloat)rad {
    CGFloat x = center.x + radius * cos(rad);
    CGFloat y = center.y + radius * sin(rad);
    return CGPointMake(x, y);
}

+ (NSArray *)lineSpaceFrom:(CGFloat)from to:(CGFloat)to n:(NSInteger)n {
    NSMutableArray *values = [NSMutableArray new];
    for (int i = 0; i < n; i++) {
        CGFloat value = (to - from) * i / (n - 1) + from;
        [values addObject:@(value)];
    }
    
    return values;
}

@end
