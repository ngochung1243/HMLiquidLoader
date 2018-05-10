//
//  UIView+HMLiquidLoader.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "UIView+HMLiquidLoader.h"
#import "HMCircularGradientLayer.h"
#import "HMLiquidUtils.h"

@implementation UIView(HMLiquidLoader)
- (void)growWithBaseColor:(UIColor *)baseColor radius:(CGFloat)radius shininess:(CGFloat)shininess {
    if (!self.layer.sublayers) return;
    
    UIColor *growColor = baseColor;
    [self growShadowWithRadius:radius growColor:growColor shininess:shininess];
//    CGRect layerRect = CGRectMake(0, 0, radius * 2, radius * 2);
//    CAShapeLayer *circle = [CAShapeLayer new];
//    circle.path = [UIBezierPath bezierPathWithOvalInRect:layerRect].CGPath;
//    HMCircularGradientLayer *circleGradientLayer = [[HMCircularGradientLayer alloc] initWithColors:@[growColor, UIColor.whiteColor]];
//    circleGradientLayer.frame = layerRect;
//    circleGradientLayer.opaque = 0.25f;
//    for (CAShapeLayer *sub in self.layer.sublayers) {
//        sub.fillColor = UIColor.clearColor.CGColor;
//    }
//    circleGradientLayer.mask = circle;
//    [self.layer addSublayer:circleGradientLayer];
}

- (void)growShadowWithRadius:(CGFloat)radius growColor:(UIColor *)growColor shininess:(CGFloat)shininess {
    CGPoint origin = MINUS_POINT(MINUS_POINT(self.center, self.frame.origin), CGPointMake(radius * shininess, radius * shininess));
    CGRect ovalRect = CGRectMake(origin.x, origin.y, 2 * radius * shininess, 2 * radius * shininess);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    self.layer.shadowColor = growColor.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.shadowOpacity = 1.0f;
    self.layer.shouldRasterize = YES;
    self.layer.shadowOffset = CGSizeZero;
//    self.layer.masksToBounds = YES;
//    self.clipsToBounds = NO;
}
@end
