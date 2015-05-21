//
//  BIArrowRectView.m
//  MultiSegmentController
//
//  Created by Zhenglinqin on 15/5/21.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "BIArrowRectView.h"


@interface BIArrowRectView (){
    CGRect _rectFrame;
}

@property (nonatomic, strong) CAShapeLayer *arrowLayer;

@end


@implementation BIArrowRectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.arrowHeight = 10.f;
        self.arrowFrom = CGPointMake(CGRectGetMidX(frame), self.arrowHeight);
        
        self.backgroundColor = [UIColor clearColor];
        _arrowLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_arrowLayer];
        _arrowLayer.frame = self.bounds;
        _arrowLayer.fillColor = [UIColor redColor].CGColor;
//        _arrowLayer.strokeColor = [UIColor blackColor].CGColor;
//        _arrowLayer.shadowColor = [UIColor blackColor].CGColor;

        self.arrowFrom = CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds));
        self.arrowDirection = UIPopoverArrowDirectionUp;
    }
    return self;
}

- (void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection{
    _arrowDirection = arrowDirection;
    [self setNeedsDisplay];
}

- (void)setArrowHeight:(CGFloat)arrowHeight{
    _arrowHeight = arrowHeight;
    [self setNeedsDisplay];
}

#define stringify(x) #x
- (void)doConfigration{
    CGPoint offset = CGPointZero;

    switch (self.arrowDirection) {
        case UIPopoverArrowDirectionUp: {
            offset.y = self.arrowHeight;
            self.arrowFrom = CGPointMake(CGRectGetMidX(self.bounds), 0);
            break;
        }
        case UIPopoverArrowDirectionDown: {
            offset.y = -self.arrowHeight;
            self.arrowFrom = CGPointMake(CGRectGetMidX(self.bounds), self.arrowHeight);
            break;
        }
        case UIPopoverArrowDirectionLeft: {
            offset.x = self.arrowHeight;
            self.arrowFrom = CGPointMake(self.arrowHeight, CGRectGetMidY(self.bounds));
            break;
        }
        case UIPopoverArrowDirectionRight: {
            offset.x = - self.arrowHeight;
            self.arrowFrom = CGPointMake(CGRectGetWidth(self.bounds) - self.arrowHeight, CGRectGetMidY(self.bounds));
            break;
        }
        default: {
            break;
        }
    }
    _rectFrame = CGRectIntersection(self.bounds, CGRectOffset(self.bounds, offset.x, offset.y));
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect: _rectFrame cornerRadius:.0f];
    //        bounds.origin = CGPointZero;
    
    CGPoint arrowStart;
    CGPoint arrow;
    CGPoint arrowEnd;
    switch (self.arrowDirection) {
        case UIPopoverArrowDirectionUp: {
            arrowStart = CGPointMake(self.arrowFrom.x - self.arrowHeight, self.arrowHeight);
            arrowEnd = CGPointMake(self.arrowFrom.x + self.arrowHeight, self.arrowHeight);
            arrow    = CGPointMake(self.arrowFrom.x, 0);
            break;
        }
        case UIPopoverArrowDirectionDown: {
            arrowStart = CGPointMake(self.arrowFrom.x - self.arrowHeight, CGRectGetHeight(_rectFrame));
            arrowEnd = CGPointMake(self.arrowFrom.x + self.arrowHeight, CGRectGetHeight(_rectFrame));
            arrow    = CGPointMake(self.arrowFrom.x, CGRectGetHeight(self.bounds));
            break;
        }
        case UIPopoverArrowDirectionLeft: {
            arrowStart = CGPointMake(self.arrowHeight,self.arrowFrom.y - self.arrowHeight);
            arrowEnd = CGPointMake(self.arrowHeight, self.arrowFrom.y + self.arrowHeight);
            arrow    = CGPointMake(0, self.arrowFrom.y);
            break;
        }
        case UIPopoverArrowDirectionRight: {
            arrowStart = CGPointMake(CGRectGetWidth(_rectFrame), self.arrowFrom.y-self.arrowHeight);
            arrowEnd = CGPointMake(CGRectGetWidth(_rectFrame)  , self.arrowFrom.y+ self.arrowHeight);
            arrow    = CGPointMake(CGRectGetWidth(self.bounds) , self.arrowFrom.y);
            break;
        }
        default: {
            break;
        }
    }
    [path moveToPoint:arrowStart];
    [path addLineToPoint:arrow];
    [path addLineToPoint:arrowEnd];
    [path closePath];
    _arrowLayer.path = path.CGPath;
//    _arrowLayer.shadowPath = path.CGPath;
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self doConfigration];
}
@end
