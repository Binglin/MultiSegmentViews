//
//  AppleDownloadView.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/23.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "AppleDownloadView.h"
#import "ProgressLayer.h"

@interface AppleDownloadView (){
    CAShapeLayer  *_shapeLayer;
    ProgressLayer *_progressLayer;
}

@end

@implementation AppleDownloadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = self.bounds;
    
    CGRect smallRect = CGRectInset(self.bounds, 20, 20);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:20.f];
    [path appendPath:[UIBezierPath bezierPathWithOvalInRect:smallRect]];
            path.usesEvenOddFillRule = YES;
    _shapeLayer.path = path.CGPath;
    _shapeLayer.fillColor = [UIColor grayColor].CGColor;
    
    _shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    [self.layer addSublayer:_shapeLayer];
    
    
    CGRect circleFrame = CGRectInset(smallRect, 10, 10);
    _progressLayer     = [ProgressLayer layer];
    _progressLayer.frame = circleFrame;
    [self.layer addSublayer:_progressLayer];
}

- (CAShapeLayer *)shapeLayer{
    return _shapeLayer;
}

- (CAShapeLayer *)progressLayer{
    return _progressLayer;
}


@end
