//
//  CGPathLayer.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "CGPathLayer.h"
#import <UIKit/UIKit.h>

@implementation CGPathLayer 

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor].CGColor;
        self.fillColor       = [UIColor clearColor].CGColor;
    }
    return self;
}

- (CGPathRef)getShapePath{
    return _shapePath ? _shapePath : [self shapePath];
}

- (CGPathRef)shapePath{
    return nil;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.path = [self getShapePath];
}

//- (void)layoutSublayers{
//    [super layoutSublayers];
//    self.path = [self getShapePath];
//}
@end


