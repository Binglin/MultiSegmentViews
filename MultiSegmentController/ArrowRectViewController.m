//
//  ArrowRectViewController.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ArrowRectViewController.h"
#import "BIArrowRectView.h"

@implementation ArrowRectViewController


- (void)loadView{
    [super loadView];
    CGFloat height = 60.f;
    BIArrowRectView *arrow1 = [[BIArrowRectView alloc] initWithFrame:CGRectMake(10, 100, 100, 60)];
    arrow1.arrowHeight = 4.f;
    arrow1.frame = CGRectMake(10, 100, 40, 10);
    arrow1.arrowDirection = UIPopoverArrowDirectionUp;
    
    BIArrowRectView *arrow2 = [[BIArrowRectView alloc] initWithFrame:CGRectMake(210, 100, 100, 60)];
    arrow2.arrowHeight = 6.f;
    arrow2.arrowDirection = UIPopoverArrowDirectionDown;
    
    BIArrowRectView *arrow3 = [[BIArrowRectView alloc] initWithFrame:CGRectMake(10, 200, 10, height)];
    arrow3.arrowHeight = 4;
    arrow3.arrowDirection = UIPopoverArrowDirectionLeft;
    
    BIArrowRectView *arrow4 = [[BIArrowRectView alloc] initWithFrame:CGRectMake(210, 200, 10, height)];
    arrow4.arrowDirection = UIPopoverArrowDirectionRight;
    arrow4.arrowHeight = 4;
    
    
    [self.view addSubview:arrow1];
    [self.view addSubview:arrow2];
    [self.view addSubview:arrow3];
    [self.view addSubview:arrow4];
}



@end
