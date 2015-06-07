//
//  GradientProgressController.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/6/5.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "GradientProgressController.h"
#import "CircleLalyer.h"

@interface GradientProgressController ()

@end

@implementation GradientProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CircleLalyer *CIRCLE = [CircleLalyer layer];
    CIRCLE.frame = CGRectMake(100, 100, 100, 100);
    CIRCLE.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:CIRCLE];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.backgroundColor = [UIColor grayColor].CGColor;
    gradient.frame = CGRectMake(0, 100, 100, 100);
    [self.view.layer addSublayer:gradient];
    gradient.startPoint = CGPointMake(0.f, 0.5f);
    gradient.endPoint   = CGPointMake(0.5f, 0.5f);
    
    gradient.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor, (id)[UIColor blueColor].CGColor];
    
    
    
    CircleLalyer *CIRCLE1 = [CircleLalyer layer];
    CIRCLE1.frame = CGRectMake(0, 0, 100, 100);
    
    gradient.mask = CIRCLE1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
