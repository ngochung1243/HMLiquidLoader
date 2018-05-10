//
//  HMLiquittableCircle.h
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLiquittableCircle : UIView
@property (strong, nonatomic) NSArray       *points;
@property (assign, nonatomic) BOOL          isGrow;
@property (assign, nonatomic) BOOL          isStroke;
@property (assign, nonatomic) CGFloat       radius;
@property (strong, nonatomic) UIColor       *color;
@property (strong, nonatomic) UIColor       *growColor;

- (id)initWithCenter:(CGPoint)center radius:(CGFloat)radius color:(UIColor *)color growColor:(UIColor *)growColor;
- (void)movePoint:(CGPoint)point;
- (void)setup;
- (void)grow:(BOOL)isGrow;
- (CGPoint)circlePointWithRad:(CGFloat)rad;
- (void)drawWithPath:(UIBezierPath *)path;
@end
