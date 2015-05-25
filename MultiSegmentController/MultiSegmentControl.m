//
//  MultiSegmentControll.m
//  MultiSegmentController
//
//  Created by Zhenglinqin on 15/5/21.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "MultiSegmentControl.h"
#import "BIArrowRectView.h"

@interface MultiSegmentControl (){
    UIScrollView *_scrollView;
    BIArrowRectView *_arrowRectView;
}

@property (nonatomic, strong) NSArray *segmentItems;

@end


@implementation MultiSegmentControl

- (instancetype)initWithFrame:(CGRect)frame segmentItems:(NSArray *)segments{
    if (self = [self initWithFrame:frame]) {
        
        self.segmentItems          = segments;
        self.indicatorAnimate      = YES;
        [self layoutSegments];
        
        CGRect lastFrame           = [(UIView *)segments.lastObject frame];
        
        if (CGRectGetMaxX(lastFrame) > CGRectGetMaxX(self.bounds)) {
            
            _scrollView                = [[UIScrollView alloc] initWithFrame:self.bounds];
            [_scrollView setShowsHorizontalScrollIndicator:NO];
            _scrollView.contentSize    = CGSizeMake(CGRectGetMaxX(lastFrame), CGRectGetHeight(self.bounds));
            [self addSubview:_scrollView];

        }

        [segments enumerateObjectsUsingBlock:^(UIView * segment, NSUInteger idx, BOOL *stop) {
            
            segment.center = CGPointMake(segment.center.x, CGRectGetMidY(self.bounds));
            [(_scrollView ? _scrollView  : self) addSubview:segment];
            
        }];
        
        UIView *first              = (UIView *)[segments firstObject];
        [(id<SegmentItemProtocol>)first setSelected:YES];

        _arrowRectView             = [[BIArrowRectView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-10.f, CGRectGetWidth(first.frame), 10.f)];
        _arrowRectView.arrowHeight = 4.f;
        [(_scrollView ? _scrollView  : self) addSubview:_arrowRectView];
    }
    return self;
}



- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)segmentTitles{
    NSMutableArray *segmentItems_ = [NSMutableArray arrayWithCapacity:segmentTitles.count];
    __block CGFloat lastX = 0;
    [segmentTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:obj forState:UIControlStateNormal];
            [button setTitle:obj forState:UIControlStateSelected];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            button.contentEdgeInsets = UIEdgeInsetsMake(5.f, 10.f, 5.f, 10.f);
            [button sizeToFit];
            [button addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = ({CGRect frame = button.frame;frame.origin.x = lastX;frame;});
            lastX += CGRectGetWidth(button.frame);
            [segmentItems_ addObject:button];
            
        }
    }];
    return [self initWithFrame:frame segmentItems:segmentItems_];
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    
    [self animateToIndex:selectIndex];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControlDidSelectIndex:)]) {
        [self.delegate segmentControlDidSelectIndex:selectIndex];
    }
}


- (void)animateToIndex:(NSInteger)selectIndex{
    UIView *selectedView = (UIView *)[self.segmentItems objectAtIndex:selectIndex];
    
    CGRect destinationRect = ({CGRect frame_  = _arrowRectView.frame;
        frame_.origin.x = selectedView.frame.origin.x ;
        frame_.size.width = CGRectGetWidth(selectedView.frame);
        frame_;});
    if (self.indicatorAnimate) {
        [UIView animateWithDuration:0.2f animations:^{
            _arrowRectView.frame = destinationRect;
        }];
    }else{
        _arrowRectView.frame = destinationRect;
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

    [self.segmentItems enumerateObjectsUsingBlock:^(id<SegmentItemProtocol> obj, NSUInteger idx, BOOL *stop) {
        obj.selected = NO;
    }];
    btn.selected = YES;
    
    self.selectIndex = [self.segmentItems indexOfObject:btn];
}

- (void)layoutSegments{
    
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
        segment.frame  = ({CGRect frame = segment.frame; frame.origin.x = idx * maxWidth; frame.size.width = maxWidth; frame;});
    }];
    
}
@end
