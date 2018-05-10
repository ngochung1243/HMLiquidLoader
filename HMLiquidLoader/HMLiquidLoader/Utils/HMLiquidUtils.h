//
//  HMLiquidUtils.h
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import <UIKit/UIKit.h>

//CGPOINT
#define PLUS_POINT(A, B) [HMLiquidUtils plusPoint1:A point2: B]
#define MINUS_POINT(A, B) [HMLiquidUtils minusPoint1:A point2: B]
#define MUL_POINT(A, RHS) [HMLiquidUtils mulPoint:A rhs: RHS]
#define DIV_POINT(A, RHS) [HMLiquidUtils divPoint:A rhs: RHS]
#define LENGTH_POINT(A) [HMLiquidUtils lengthOfPoint:A]
#define NORMALIZED_POINT(A) [HMLiquidUtils normalizedPoint:A]
#define DOT_POINT(A, B) [HMLiquidUtils dotPoint1:A point2:B]
#define CROSS_POINT(A, B) [HMLiquidUtils crossPoint1:A point2:B]
#define SPLIT_POINT(A, B, RATIO) [HMLiquidUtils splitPoint1:A point2:B ratio: RATIO]
#define MID_POINT(A, B) [HMLiquidUtils midPoint1:A point2:B]
#define INTERSECTION_POINT(A1, B1, A2, B2) [HMLiquidUtils intersectionFromPoint:A1 toPoint:B1 fromPoint2:A2 toPoint2:B2]
#define CIRCLE_POINT(CENTER, RADIUS, RAD) [HMLiquidUtils circlePointWithCenter:CENTER radius:RADIUS rad:RAD]

//CGRECT
#define RIGHT_BOTTOM_RECT(A) [HMLiquidUtils rightBottomFromRect:A]
#define CENTER_RECT(A) [HMLiquidUtils centerFromRect:A]

//BEZIER PATH
#define BEZIER_PATH(COMPLETION) [HMLiquidUtils bezierPathWithCompletion:COMPLETION]

//RADIAN
#define RAD_TO_DEG(RAD) [HMLiquidUtils radToDeg:RAD]
#define DEG_TO_RAD(DEG) [HMLiquidUtils degToRad:DEG]

//UNKNOWN
#define LINE_SPACE(FROM, TO, N) [HMLiquidUtils lineSpaceFrom:FROM to:TO n:N]

@interface HMLiquidUtils : NSObject
+ (CGPoint)plusPoint1:(CGPoint)point1 point2:(CGPoint)point2;
+ (CGPoint)minusPoint1:(CGPoint)point1 point2:(CGPoint)point2;
+ (CGPoint)mulPoint:(CGPoint)point rhs:(CGFloat)rhs;
+ (CGPoint)divPoint:(CGPoint)point rhs:(CGFloat)rhs;
+ (CGFloat)lengthOfPoint:(CGPoint)point;
+ (CGPoint)normalizedPoint:(CGPoint)point;
+ (CGFloat)dotPoint1:(CGPoint)point point2:(CGPoint)point2;
+ (CGFloat)crossPoint1:(CGPoint)point1 point2:(CGPoint)point2;
+ (CGPoint)splitPoint1:(CGPoint)point point2:(CGPoint)point2 ratio:(CGFloat)ratio;
+ (CGPoint)midPoint1:(CGPoint)point point2:(CGPoint)point2;
+ (CGPoint)intersectionFromPoint:(CGPoint)fromPoint1 toPoint:(CGPoint)toPoint1 fromPoint2:(CGPoint)fromPoint2 toPoint2:(CGPoint)toPoint2;

+ (CGPoint)rightBottomFromRect:(CGRect)rect;
+ (CGPoint)centerFromRect:(CGRect)rect;

+ (UIBezierPath *)bezierPathWithCompletion:(void(^)(UIBezierPath *bezierPath))completion;

+ (CGFloat)radToDeg:(CGFloat)rad;
+ (CGFloat)degToRad:(CGFloat)deg;
+ (CGPoint)circlePointWithCenter:(CGPoint)center radius:(CGFloat)radius rad:(CGFloat)rad;
+ (NSArray *)lineSpaceFrom:(CGFloat)from to:(CGFloat)to n:(NSInteger)n;
@end
