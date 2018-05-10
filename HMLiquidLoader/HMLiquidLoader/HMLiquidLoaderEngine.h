//
//  HMLiquidLoaderEngine.h
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMLiquittableCircle.h"

@interface HMLiquidLoaderEngine : NSObject
@property (assign, nonatomic) CGFloat radiusThresh;
@property (assign, nonatomic) CGFloat connectThresh;
@property (assign, nonatomic) CGFloat angleThresh;

@property (strong, nonatomic) CALayer *layer;
@property (strong, nonatomic) UIColor *color;

- (id)initWithRadiusThresh:(CGFloat)radiusThresh angleThresh:(CGFloat)angleThresh;
- (NSArray<HMLiquittableCircle *> *)pushCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other;
- (void)drawInParent:(UIView *)parent;
- (void)clear;
- (CALayer *)constructLayerWithPath:(UIBezierPath *)path;
- (NSArray *)circleConnectedPointWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other angle:(CGFloat)angle;
- (NSArray *)circleConnectedPointWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other;
- (NSArray<UIBezierPath *> *)generateConnectedPathWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other;
- (UIBezierPath *)normalPathWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other;
- (NSArray<UIBezierPath *> *)splitPathWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other radio:(CGFloat)radio;
- (CGFloat)circleRatioWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other;
- (BOOL)isConnectedWithCircle:(HMLiquittableCircle *)circle other:(HMLiquittableCircle *)other;
@end
