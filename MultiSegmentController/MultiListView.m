//
//  MultiListView.m
//  
//
//  Created by Zhenglinqin on 15/1/6.
//
//

#import "MultiListView.h"


@interface MultiListView ()<SegmentSelectProtocol, UIScrollViewDelegate>
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
        
        _scrollContainer = [[UIScrollView alloc] initWithFrame:({CGRect frame = self.frame; frame.origin.y = CGRectGetHeight(selectView.frame);frame.size.height -= CGRectGetHeight(selectView.frame); frame;})];
        _scrollContainer.delegate = self;
        _scrollContainer.scrollsToTop = NO;
        _scrollContainer.pagingEnabled = YES;
        _scrollContainer.contentSize = CGSizeMake(self.frame.size.width * self.viewControllers.count, CGRectGetHeight(self.frame));
        [self addSubview:_scrollContainer];
        _scrollContainer.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark - private
- (void)showViewControllerAtIndex:(NSInteger)index{
    if (index < 0 || index >= self.viewControllers.count) {
        return;
    }
    
    UIViewController *indexVC  = self.viewControllers[index];
    
    
    if (indexVC.parentViewController == nil) {
        [self.superController addChildViewController:indexVC];
        [_scrollContainer addSubview:indexVC.view];
        indexVC.view.frame = CGRectMake( CGRectGetWidth(self.frame) * index, 0 , CGRectGetWidth(self.frame) ,CGRectGetHeight(self.frame) - CGRectGetHeight(_segmentView.frame));
    }
}

- (void)setViewControllers:(NSArray *)viewControllers{
    _viewControllers = viewControllers;
    _segmentView.selectIndex = self.selectIndex;
}

#pragma mark - SelectViewDelegate

- (void)segmentControlDidSelectIndex:(NSInteger)tag{
    
    _selectIndex = tag ;

    if (self.scrollAnimate) {
        self.selectedViewController = self.viewControllers[tag];
        [self showViewControllerAtIndex:tag];
        [self.delegate segmentControlDidSelectIndex:tag];
        _scrollContainer.contentOffset = CGPointMake(tag * CGRectGetWidth(self.frame), 0);
    }else{
        [self.selectedViewController removeFromParentViewController];
        [self.selectedViewController.view removeFromSuperview];
        self.selectedViewController = self.viewControllers[tag];
        [self showViewControllerAtIndex:tag];
        [self.delegate segmentControlDidSelectIndex:tag];
        _scrollContainer.contentOffset = CGPointMake(tag * CGRectGetWidth(self.frame), 0);
    }
}

- (void)setSelectIndex:(NSUInteger)index{
    [self segmentControlDidSelectIndex:index];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger floor = floorf(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSInteger ceil  = ceilf(scrollView.contentOffset.x / scrollView.frame.size.width);
    
    [self showViewControllerAtIndex:floor];
    [self showViewControllerAtIndex:ceil];
    
    [_segmentView setIndicatorProgress:scrollView.contentOffset.x / (scrollView.contentSize.width - CGRectGetWidth(_segmentView.frame))];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger floor = floorf(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSLog(@"aaa end %ld",(long)floor);
    _segmentView.selectIndex = floor;
}

#pragma mark - override
- (void)layoutSubviews{
    [super layoutSubviews];
    _scrollContainer.frame = ({CGRect frame = self.frame;
        frame.origin.y = CGRectGetHeight(_segmentView.frame);
        frame.size.height -= CGRectGetHeight(_segmentView.frame);
        frame;
    });
    _scrollContainer.contentSize = CGSizeMake(self.frame.size.width * self.viewControllers.count, CGRectGetHeight(self.frame) - _segmentView.frame.size.height);
}

@end
