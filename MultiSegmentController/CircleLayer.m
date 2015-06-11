//
//  CircleLalyer.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/6/5.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "CircleLayer.h"

@implementation CircleLayer

- (instancetype)init{
    if (self = [super init]) {
        self.strokeColor = [UIColor redColor].CGColor;
        self.lineWidth   = 20.;
        
    }
    return self;
}

- (CGPathRef)shapePath{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(self.bounds, 10, 10) cornerRadius:CGRectGetWidth(self.frame)/2.f];
    return path.CGPath;
}

@end
