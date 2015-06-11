//
//  GradientProgressController.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/6/5.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "GradientProgressController.h"
#import "CircleLayer.h"
#import "GradientCircleLayer.h"
#import "LayerCreator.h"

@interface GradientProgressController ()

@end

@implementation GradientProgressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer *CIRCLE = [LayerCreator createWithType:CircleLayerType_normal];
    CIRCLE.frame = CGRectMake(100, 100, 100, 100);
    [self.view.layer addSublayer:CIRCLE];
    
    CALayer *gradient = [LayerCreator createWithType:CircleLayerType_gradient];
    gradient.frame =CGRectMake(0, 100, 100, 100);
    [self.view.layer addSublayer:gradient];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
