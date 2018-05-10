//
//  UIView+HMLiquidLoader.h
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HMLiquidLoader)
- (void)growWithBaseColor:(UIColor *)baseColor radius:(CGFloat)radius shininess:(CGFloat)shininess;
- (void)growShadowWithRadius:(CGFloat)radius growColor:(UIColor *)growColor shininess:(CGFloat)shininess;
@end
