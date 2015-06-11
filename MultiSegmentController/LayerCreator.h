//
//  LayerCreator.h
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/6/8.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleLayer.h"
#import "GradientCircleLayer.h"

typedef enum : NSUInteger {
    CircleLayerType_normal,
    CircleLayerType_gradient
} CircleLayerType;

@interface LayerCreator : NSObject

+ (CALayer *)createWithType:(CircleLayerType)circleType;

@end
