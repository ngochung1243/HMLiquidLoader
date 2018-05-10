//
//  HMCircularGradientLayer.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "HMCircularGradientLayer.h"
#import "HMLiquidUtils.h"

@implementation HMCircularGradientLayer
- (id)initWithColors:(NSArray *)colors {
    if (self = [super init]) {
        self.colors = colors;
        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    NSArray *values = LINE_SPACE(0.0f, 1.0f, self.colors.count);
    CGFloat *locations = malloc(values.count * sizeof(CGFloat));
    for (NSInteger i = values.count - 1; i >= 0; i--) {
        CGFloat fValue = [values[i] floatValue];
        fValue = 1.0f - pow(fValue, 2);
        locations[i] = fValue;
    }
    NSMutableArray *colorRefs = [NSMutableArray new];
    for (UIColor *color in self.colors) {
        [colorRefs addObject:(__bridge id)color.CGColor];
    }
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), (__bridge CFArrayRef)colorRefs, locations);
    CGContextDrawRadialGradient(ctx, gradient, CENTER_RECT(self.frame), 0.0f, CENTER_RECT(self.frame), MAX(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)), kCGGradientDrawsBeforeStartLocation);
}
@end
