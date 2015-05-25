//
//  CGPathLayer.h
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CGPathLayer : CAShapeLayer{
    @protected
    CGPathRef _shapePath;
}


//@overide
- (CGPathRef)shapePath;

@end

