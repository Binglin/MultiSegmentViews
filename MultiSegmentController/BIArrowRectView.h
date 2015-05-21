//
//  BIArrowRectView.h
//  MultiSegmentController
//
//  Created by Zhenglinqin on 15/5/21.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIArrowRectView : UIView

//default to 10
@property (nonatomic, assign) CGFloat arrowHeight;
@property (nonatomic, strong,readonly) CAShapeLayer *arrowLayer;

/**
 *  location of arrow  default to centerX
 */
@property (nonatomic, assign) CGPoint arrowFrom;
@property (nonatomic, assign) UIPopoverArrowDirection arrowDirection;

@end
