//
//  MultiSegmentControll.h
//  MultiSegmentController
//
//  Created by Zhenglinqin on 15/5/21.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentItemProtocol <NSObject>

@property (nonatomic, assign) BOOL selected;

@end

@interface MultiSegmentControl : UIView

//left rights
@property (nonatomic, assign) UIEdgeInsets segmentInsets;
@property (nonatomic, assign) BOOL         indicatorAnimate;
@property (nonatomic, strong) UIView       * indicatorView;


/**
 *  每个segment都需要实现SegmentItemProtocol 且每个item都需要是view的子类
 */
- (instancetype)initWithFrame:(CGRect)frame segmentItems:(NSArray *)segments;

/**
 *  
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)segmentTitles;

@end



/**
 *  各个segment item占比相同的segmentControl 默认宽度为最大的item
 */
#pragma mark -
@interface EqualWSegmentControl : MultiSegmentControl

@end
