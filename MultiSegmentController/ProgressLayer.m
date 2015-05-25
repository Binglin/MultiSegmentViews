//
//  ProgressLayer.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ProgressLayer.h"
#import <UIKit/UIKit.h>

@implementation ProgressLayer


- (instancetype)init{
    if (self = [super init]) {
        self.strokeStart = 1.0f;
//        self.backgroundColor = [UIColor grayColor].CGColor;
        self.strokeColor = [UIColor grayColor].CGColor;
    }
    return self;
}

- (CGPathRef)shapePath{
    CGFloat circleRadius = CGRectGetWidth(self.frame)/2.f;
    self.lineWidth = circleRadius;
    CGFloat inset = circleRadius/2.0f;
    UIBezierPath *bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, inset, inset)];
    [bezier applyTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    [bezier applyTransform:CGAffineTransformMakeTranslation(0, circleRadius*2)];
    
    return bezier.CGPath;
}



    




@end
