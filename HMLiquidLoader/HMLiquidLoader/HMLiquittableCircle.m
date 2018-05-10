//
//  HMLiquittableCircle.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "HMLiquittableCircle.h"
#import "UIView+HMLiquidLoader.h"
#import "HMLiquidUtils.h"

@implementation HMLiquittableCircle
- (id)initWithCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color growColor:(UIColor *)growColor {
    CGRect frame = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
    if (self = [super initWithFrame:frame]) {
        self.radius = radius;
        self.color = color;
        self.growColor = growColor;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.frame = CGRectMake(self.center.x - self.radius, self.center.y - self.radius, self.radius * 2, self.radius * 2);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    [self drawWithPath:bezierPath];
}

- (void)drawWithPath:(UIBezierPath *)path {
    NSArray *subLayers = [self.layer.sublayers copy];
    for (CALayer *sub in subLayers) {
        [sub removeFromSuperlayer];
    }
    CAShapeLayer *layer = [[CAShapeLayer alloc] initWithLayer:self.layer];
    layer.lineWidth = 3.0f;
    if (self.isStroke) {
        layer.strokeColor = self.color.CGColor;
        layer.fillColor = UIColor.clearColor.CGColor;
    }
    else {
        layer.fillColor = self.color.CGColor;
    }
    
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
    if (self.isGrow) {
        [self grow:YES];
    }
}

- (void)grow:(BOOL)isGrow {
    if (isGrow) {
        [self growWithBaseColor:self.growColor radius:self.radius shininess:0.9f];
    }
    else {
        self.layer.shadowRadius = 0.0f;
        self.layer.shadowOpacity = 0.0f;
    }
}

- (CGPoint)circlePointWithRad:(CGFloat)rad {
    return CIRCLE_POINT(self.center, self.radius, rad);
}

- (void)movePoint:(CGPoint)point {
    CGPoint pointMove = PLUS_POINT(self.center, point);
    self.center = pointMove;
}

- (void)setIsGrow:(BOOL)isGrow {
    if (_isGrow == isGrow) return;
    _isGrow = isGrow;
    [self grow:isGrow];
}

- (void)setRadius:(CGFloat)radius {
    if (_radius == radius) return;
    _radius = radius;
    [self setup];
}

- (void)setIsStroke:(BOOL)isStroke {
    if (_isStroke == isStroke) return;
    _isStroke = isStroke;
    [self setup];
}
@end
