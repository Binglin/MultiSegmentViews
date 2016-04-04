//
//  MultiSegmentControll.m
//  MultiSegmentController
//
//  Created by Zhenglinqin on 15/5/21.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "MultiSegmentControl.h"

@interface MultiSegmentControl (){
    UIScrollView *_scrollView;
    UIView *_arrowRectView;
    UIView *_lineView;
    UIView *contentScroll;
}

@property (nonatomic, strong) NSArray *segmentItems;
@property (nonatomic, strong) UIView  *lineView;

@end


@implementation MultiSegmentControl

- (instancetype)initWithFrame:(CGRect)frame segmentItems:(NSArray *)segments{
    if (self = [self initWithFrame:frame]) {
        
        self.segmentItems          = segments;
        self.indicatorAnimate      = YES;
        [self layoutSegments];
        
        
        
        CGRect lastFrame           = [(UIView *)segments.lastObject frame];
        
        BOOL needScroll = CGRectGetMaxX(lastFrame) > CGRectGetMaxX(self.bounds);
        if (needScroll) {
            /*
             *  不知道为什么 加一次界面很奇怪，但是多加一个就好了
             */
            _scrollView                = [[UIScrollView alloc] initWithFrame:self.bounds];
            _scrollView.scrollsToTop = NO;
            [self addSubview:_scrollView];
            
            _scrollView                = [[UIScrollView alloc] initWithFrame:self.bounds];
            [_scrollView setShowsHorizontalScrollIndicator:NO];
            _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastFrame), CGRectGetHeight(self.bounds));
            
            
            [self addSubview:_scrollView];
        }
        
        [segments enumerateObjectsUsingBlock:^(UIView * segment, NSUInteger idx, BOOL *stop) {
            [(UIButton *)segment addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            
            segment.center = CGPointMake(segment.center.x, CGRectGetMidY(self.bounds));
            [(_scrollView ? _scrollView  : self) addSubview:segment];
            
        }];
    }
    return self;
}


- (void)setIndicatorView:(UIView *)indicatorView{
    [_indicatorView removeFromSuperview];
    _indicatorView = indicatorView;
    [(_scrollView ? _scrollView  : self) addSubview:_indicatorView];
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)- 0.5f, CGRectGetWidth(self.bounds), .5f)];
        _lineView.backgroundColor = [UIColor colorWithRed:236.f/255.f green:236.f/255.f blue:236.f/255.f alpha:1.f];
        [self addSubview:_lineView];
    }
    return _lineView;
}


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)segmentTitles{
    NSMutableArray *segmentItems_ = [NSMutableArray arrayWithCapacity:segmentTitles.count];
    __block CGFloat lastX = 0;
    [segmentTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:obj forState:UIControlStateNormal];
            [button setTitle:obj forState:UIControlStateSelected];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            button.contentEdgeInsets = UIEdgeInsetsMake(5.f, 10.f, 5.f, 10.f);
            [button sizeToFit];
            button.frame = ({CGRect frame = button.frame;
                frame.origin.x = lastX;
                frame;});
            lastX += CGRectGetWidth(button.frame);
            [segmentItems_ addObject:button];
            
        }
    }];
    return [self initWithFrame:frame segmentItems:segmentItems_];
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    if (self.sameIgnore && ( _selectIndex == selectIndex)) {
        return;
    }
    
    if (self.sameDismiss && (_selectIndex == selectIndex))
    {
        if ([self.segmentItems[_selectIndex] selected])
        {
            [self.segmentItems[_selectIndex] setSelected:NO];
            if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControlDeSelectIndex:)]) {
                [self.delegate segmentControlDeSelectIndex:selectIndex];
            }
        }else{
            [self.segmentItems[_selectIndex] setSelected:YES];
            if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControlDidSelectIndex:)]) {
                [self.delegate segmentControlDidSelectIndex:selectIndex];
            }
        }
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControlDeSelectIndex:)]) {
        [self.delegate segmentControlDeSelectIndex:selectIndex];
    }
    [self.segmentItems[_selectIndex] setSelected:NO];
    _selectIndex = selectIndex;
    [self.segmentItems[_selectIndex] setSelected:YES];
    
    
    [self animateToIndex:selectIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControlDidSelectIndex:)]) {
        [self.delegate segmentControlDidSelectIndex:selectIndex];
    }
}


- (void)animateToIndex:(NSInteger)selectIndex{
    UIView *selectedView = (UIView *)[self.segmentItems objectAtIndex:selectIndex];
    
    CGRect destinationRect = ({CGRect frame_  = self.indicatorView.frame;
        frame_.origin.x = selectedView.frame.origin.x ;
        frame_.size.width = CGRectGetWidth(selectedView.frame);
        frame_;});
    if (self.indicatorAnimate) {
        [UIView animateWithDuration:0.2f animations:^{
            self.indicatorView.frame = destinationRect;
        }];
    }else{
        self.indicatorView.frame = destinationRect;
    }
    if (_scrollView) {
        CGRect selfRect = [_scrollView convertRect:selectedView.frame toView:self];
        if (CGRectGetMinX(selfRect) < 0) {
            [UIView animateWithDuration:0.2f animations:^{
                _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x+CGRectGetMinX(selfRect), _scrollView.contentOffset.y);
            }];
        }else if (CGRectGetMaxX(selfRect) > CGRectGetWidth(self.bounds)){
            [UIView animateWithDuration:0.2f animations:^{
                _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x+CGRectGetMaxX(selfRect)-CGRectGetWidth(self.bounds), _scrollView.contentOffset.y);
            }];
        }
    }
}

- (void)selectItem:(id<SegmentItemProtocol>)btn{
    
    
    
    self.selectIndex = [self.segmentItems indexOfObject:btn];
}

- (void)layoutSegments{
    
}

- (void)addVerticalLines{
    [self.segmentItems enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.segmentItems.count - 1) {
            //            CGFloat space = (45 - 20.)/2.f;
            CGFloat lineHeight = 60.0;//obj.frame.size.height - 2 * space
            CGFloat lineTop    = (obj.frame.size.height - lineHeight)/2.0;//space;
            UIView *seperateLine = [[UIView alloc] initWithFrame:CGRectMake(obj.frame.size.width, lineTop, 0.5f, lineHeight)];
            
            //807D6C
            seperateLine.backgroundColor = [UIColor colorWithRed: 0x80/ 255.0f green:0x7d / 255.f blue:0x6c/ 255.f alpha:1.0];//[UIColor colorWithRed:236.f/255.f green:236.f/255.f blue:236.f/255.f alpha:1.f];
            [obj addSubview:seperateLine];
        }
    }];
}

- (void)reset{
    [self.segmentItems[_selectIndex] setSelected:NO];
}

- (void)setIndicatorProgress:(CGFloat)progress{
    CGRect fIndicator = self.indicatorView.frame;
    fIndicator.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(fIndicator)) * progress;
    self.indicatorView.frame = fIndicator;
}

@end






@implementation EqualWSegmentControl

- (void)layoutSegments{
    __block CGFloat maxWidth = 0;
    [self.segmentItems enumerateObjectsUsingBlock:^(UIView * segment, NSUInteger idx, BOOL *stop) {
        CGFloat seg_width = CGRectGetWidth(segment.frame);
        if (seg_width > maxWidth) {
            maxWidth = seg_width;
        }
    }];
    
    if (maxWidth * self.segmentItems.count < CGRectGetWidth(self.frame)) {
        maxWidth = CGRectGetWidth(self.frame)/self.segmentItems.count;
    }
    [self.segmentItems enumerateObjectsUsingBlock:^(UIView * segment, NSUInteger idx, BOOL *stop) {
        segment.frame  = ({CGRect frame = segment.frame;
            frame.origin.x = idx * maxWidth;
            frame.size.width = maxWidth;
            if (frame.size.height < 1.f) {
                frame.size.height = CGRectGetHeight(self.frame);
            }
            frame;});
    }];
}

@end




@implementation CenterSegmentControl

- (void)layoutSegments{
    __block CGFloat maxWidth = 0;
    [self.segmentItems enumerateObjectsUsingBlock:^(UIView * segment, NSUInteger idx, BOOL *stop) {
        CGFloat seg_width = CGRectGetWidth(segment.frame);
        if (seg_width > maxWidth) {
            maxWidth = seg_width;
        }
    }];
    
    CGFloat leftEdge = (CGRectGetWidth(self.frame) - self.segmentItems.count * maxWidth)/2.f;
    [self.segmentItems enumerateObjectsUsingBlock:^(UIView * segment, NSUInteger idx, BOOL *stop) {
        segment.frame  = ({CGRect frame = segment.frame; frame.origin.x = leftEdge + idx * maxWidth;
            frame.size.width = maxWidth; frame;});
    }];
    
}

@end
