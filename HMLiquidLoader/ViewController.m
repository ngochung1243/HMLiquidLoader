//
//  ViewController.m
//  HMLiquidLoader
//
//  Created by CPU12068 on 5/4/18.
//  Copyright © 2018 CPU12068. All rights reserved.
//

#import "ViewController.h"
#import "HMLiquidLoader.h"

@interface ViewController ()
@property (strong, nonatomic) HMLiquidLoader *circleLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _circleLoader = [[HMLiquidLoader alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 100, CGRectGetHeight(self.view.frame)/2 - 100, 200, 200)
                                                                  effect:HMLiquidLoadEffectTypeCircle
                                                                   color:UIColor.greenColor
                                                             circleCount:8
                                                                duration:10.0f
                                                               growColor:UIColor.greenColor circleScale:1.1f];
    [self.view addSubview:_circleLoader];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    startButton.backgroundColor = UIColor.blackColor;
    [startButton setTitle:@"START" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *stopButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 100, 50)];
    [stopButton setTitle:@"STOP" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    stopButton.backgroundColor = UIColor.blackColor;
    [self.view addSubview:startButton];
    [self.view addSubview:stopButton];
}

- (void)startAction {
    [self.circleLoader startAnimating];
}

- (void)stopAction {
    [self.circleLoader stopAnimating];
}

@end
