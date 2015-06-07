//
//  ProgressViewController.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ProgressViewController.h"
#import "ProgressLayer.h"


@interface ProgressViewController ()
{
    ProgressLayer *pLayer;
}
@end


@implementation ProgressViewController

- (void)loadView{
    [super loadView];
    ProgressLayer *progress = [ProgressLayer layer];
    progress.frame = CGRectMake(150, 100,60, 60);
    [self.view.layer addSublayer:progress];
    pLayer = progress;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    ani.fromValue = @(0.f);
    
    ani.toValue   = @(1.0f);
    ani.duration = 5.f;
    ani.repeatCount = NSNotFound;
    
    [pLayer addAnimation:ani forKey:@"stroke"];
}

@end
