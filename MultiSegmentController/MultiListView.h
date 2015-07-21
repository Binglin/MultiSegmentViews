//
//  MultiListView.h
//  TreasureHunter
//
//  Created by Zhenglinqin on 15/1/6.
//
//

#import <UIKit/UIKit.h>
#import "MultiSegmentControl.h"

@interface MultiListView : UIView
{
    MultiSegmentControl *_segmentView;
}

/**
 *  @need to be set ~ 必须要设置 assign～避免循环引用
 */
@property (nonatomic, assign) UIViewController *superController;
@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic, assign) id<SegmentSelectProtocol> delegate;

//是否从第一个左划至最后一个
@property (nonatomic, assign) BOOL couldCycle;
//左右滑动动画
@property (nonatomic, assign) BOOL scrollAnimate;

@property (nonatomic, assign) NSUInteger selectIndex;

- (instancetype)initWithFrame:(CGRect)frame selectView:(MultiSegmentControl *)selectView;

@end
