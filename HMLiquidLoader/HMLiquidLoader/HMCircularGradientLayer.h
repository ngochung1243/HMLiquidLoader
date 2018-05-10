//
//  HMCircularGradientLayer.h
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMCircularGradientLayer : CALayer
@property (strong, nonatomic) NSArray *colors;
- (id)initWithColors:(NSArray *)colors;
@end
