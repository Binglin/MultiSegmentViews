//
//  MultiSegmentController.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "MultiSegmentController.h"
#import "MultiSegmentControl.h"
#import "MultiListView.h"

@implementation MultiSegmentController

- (void)loadView{
    [super loadView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray *titles = [NSMutableArray array];
    
    for (int i = 0 ; i < self.segmentItemsControllers.count; ++ i) {
        NSString *title = self.segmentItemsControllers[i].title;
        [titles addObject: title ? : @"未设置title"];
    }
    
    EqualWSegmentControl *control = [[EqualWSegmentControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f) titles:titles];
    
    control.lineView.hidden = NO;
    control.indicatorView = ({UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(control.frame)-5, 10, 5.f)];
        view.backgroundColor = [UIColor orangeColor];
        view;
    });
    control.backgroundColor = [UIColor whiteColor];
    
    MultiListView *list = [[MultiListView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) selectView:control];
    list.scrollAnimate   = YES;
    list.backgroundColor = [UIColor grayColor];
    list.viewControllers = self.segmentItemsControllers;
    list.superController = self;
    self.view = list;
}

@end
