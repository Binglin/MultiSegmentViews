//
//  MultiListView.m
//  TreasureHunter
//
//  Created by Zhenglinqin on 15/1/6.
//
//

#import "MultiListView.h"


@interface MultiListView ()<SegmentSelectProtocol>
{
    UISwipeGestureRecognizer *_leftSwipe;
    UISwipeGestureRecognizer *_rightSwipe;
    UIScrollView *_scrollContainer;
}

@end

@implementation MultiListView

- (instancetype)initWithFrame:(CGRect)frame selectView:(MultiSegmentControl *)selectView{
    if (self = [super initWithFrame:frame]) {
        _segmentView = selectView;
        _segmentView.frame = CGRectMake(0, 0, CGRectGetWidth(selectView.frame), CGRectGetHeight(selectView.frame));
        _segmentView.delegate = self;
        [self addSubview:selectView];
        [self addSwipeGestures];
        
        _scrollContainer = [[UIScrollView alloc] initWithFrame:({CGRect frame = self.frame; frame.origin.y = CGRectGetHeight(selectView.frame);frame.size.height -= CGRectGetHeight(selectView.frame); frame;})];
        
    }
    return self;
}

- (void)addSwipeGestures{
    _leftSwipe  = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeExecute:)];
    _rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeExecute:)];
    _leftSwipe.direction  = UISwipeGestureRecognizerDirectionLeft;
    _rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:_leftSwipe ];
    [self addGestureRecognizer:_rightSwipe];
    
}

- (void)swipeExecute:(UISwipeGestureRecognizer *)swipe{
    NSUInteger viewControllerCount = self.viewControllers.count;
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        _segmentView.selectIndex = (self.selectIndex + 1 ) % viewControllerCount;
//        [_segmentView changesViews:(self.selectIndex + 1 ) % viewControllerCount];
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        _segmentView.selectIndex = (self.selectIndex - 1 + viewControllerCount)%viewControllerCount;
    }
}

- (void)setViewControllers:(NSArray *)viewControllers{
    _viewControllers = viewControllers;
    _segmentView.selectIndex = self.selectIndex;
}

#pragma mark - SelectViewDelegate

- (void)segmentControlDidSelectIndex:(NSInteger)tag{
    _selectIndex = tag;
    [self.selectedViewController removeFromParentViewController];
    [self.selectedViewController.view removeFromSuperview];
    @try {
        self.selectedViewController = self.viewControllers[tag];
        [self.superController addChildViewController:self.selectedViewController];
        [self addSubview:self.selectedViewController.view];CGFloat ODD = 5;
        self.selectedViewController.view.frame = CGRectMake(ODD, CGRectGetHeight(_segmentView.frame)+ODD, CGRectGetWidth(self.frame) - 2 * ODD,CGRectGetHeight(self.frame) - CGRectGetHeight(_segmentView.frame)-2 * ODD);
        [self.delegate segmentControlDidSelectIndex:tag];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (void)setSelectIndex:(NSUInteger)index{
    [self segmentControlDidSelectIndex:index];
}


@end
