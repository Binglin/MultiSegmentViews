//
//  GradientCircleLayer.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/6/8.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "GradientCircleLayer.h"

@interface GradientCircleLayer (){
    CircleLayer *circle;
}

@end

@implementation GradientCircleLayer

- (instancetype)init{
    if (self = [super init]) {
        circle = [CircleLayer layer];
        self.backgroundColor = [UIColor grayColor].CGColor;
        self.startPoint = CGPointMake(0.f, 0.5f);
        //    gradient.endPoint   = CGPointMake(0.5f, 0.5f);
        self.backgroundColor = [UIColor clearColor].CGColor;
        self.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor, (id)[UIColor blueColor].CGColor];
    }
    return self;
}

- (void)layoutSublayers{
    [super layoutSublayers];
    circle.frame = self.bounds;
    self.mask = circle;

}

@end
