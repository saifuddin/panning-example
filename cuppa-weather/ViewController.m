//
//  ViewController.m
//  cuppa-weather
//
//  Created by saifuddin on 15/12/14.
//  Copyright (c) 2014 saifuddin. All rights reserved.
//

#import "ViewController.h"

#define V1_MAX_WIDTH self.view.frame.size.width
#define V1_MAX_HEIGHT self.view.frame.size.height
#define V1_MIN_HEIGHT 250
#define V1_MIN_WIDTH V1_MIN_HEIGHT

@interface ViewController ()
@property CFAbsoluteTime lastChange;
@property (nonatomic, strong) UIView *v1, *v2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *gest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panning:)];
    [self.view addGestureRecognizer:gest];

    CGFloat width = self.view.frame.size.width;
    self.v1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - width/2, 20, width, width)];
    _v1.autoresizesSubviews = YES;
    _v1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_v1];

    CGFloat v2Width = 200;
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(_v1.frame.size.width/2 - v2Width/2, _v1.frame.size.height/2 - v2Width/2, v2Width, v2Width)];
    v2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    v2.backgroundColor = [UIColor redColor];
    [_v1 addSubview:v2];
    
    self.v2 = [[UIView alloc] initWithFrame:CGRectMake(0, _v1.frame.origin.y + _v1.frame.size.height, self.view.frame.size.width, 400)];
    _v2.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:_v2];
}

- (void)panning:(UIPanGestureRecognizer *)recognizer
{
    // Play around here
    CGPoint translation = [recognizer velocityInView:self.view]; // in px/sec
    CGFloat xRate = translation.y/10; // play around with this to get the desired rate of change of width
    CGFloat yRate = translation.y/20; // play around with this to get the desired rate of change of height
    CGFloat newWidth = _v1.frame.size.width + xRate;
    CGFloat newHeight = _v1.frame.size.height + yRate;

    // Guard against too big / too small
    if (newWidth > V1_MAX_WIDTH) newWidth = V1_MAX_WIDTH;
    if (newWidth < V1_MIN_WIDTH) newWidth = V1_MIN_WIDTH;
    if (newHeight > V1_MAX_HEIGHT) newHeight = V1_MAX_HEIGHT;
    if (newHeight < V1_MIN_HEIGHT) newHeight = V1_MIN_HEIGHT;

    _v1.frame = CGRectMake(self.view.frame.size.width/2 - newWidth/2,
                           _v1.frame.origin.y,
                           newWidth,
                           newHeight);

    // always be underneath _v1. Keeps other values the same
    _v2.frame = CGRectMake(_v2.frame.origin.x,
                           _v1.frame.origin.y + _v1.frame.size.height,
                           _v2.frame.size.width,
                           _v2.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
