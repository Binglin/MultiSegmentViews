//
//  LayerCreator.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/6/8.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "LayerCreator.h"

@implementation LayerCreator

+ (CALayer *)createWithType:(CircleLayerType)circleType{
    if (CircleLayerType_normal == circleType)
    {
        return [CircleLayer layer];
    }
    else if (CircleLayerType_gradient == circleType)
    {
        return [GradientCircleLayer layer];
    }
    return [CALayer layer];
}

@end
