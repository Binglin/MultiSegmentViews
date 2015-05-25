//
//  ProgressLayer.h
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CGPathLayer.h"

@interface ProgressLayer : CGPathLayer

@property (nonatomic, assign) CGFloat progress;

@end
