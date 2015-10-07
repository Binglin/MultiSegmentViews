//
//  MultiSegmentController.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "MultiSegmentController.h"
#import "MultiSegmentControl.h"
#import "RedViewController.h"
#import "GreenViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"
#import "MultiListView.h"

@implementation MultiSegmentController

- (void)loadView{
    [super loadView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    EqualWSegmentControl *control = [[EqualWSegmentControl alloc] initWithFrame:CGRectMake(0, 300, 320, 44.f) titles:@[@"red",@"blue",@"green",@"yellow",@"red",@"blue",@"green",@"yellow"]];
    control.lineView.hidden = NO;
    control.indicatorView = ({UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(control.frame)-5, 10, 5.f)];
        view.backgroundColor = [UIColor orangeColor];
        view;
    });
    control.backgroundColor = [UIColor grayColor];
//        [self.view addSubview:control];
    
    NSArray *classArr = @[[RedViewController class],
                          [BlueViewController class],
                          [GreenViewController class],
                          [YellowViewController class]];
    NSMutableArray *vcArr = [NSMutableArray arrayWithCapacity:classArr.count];
    for (Class class in classArr) {
        UIViewController *vc  = [[class alloc] init];
        [vcArr addObject:vc];
    }
    
    MultiListView *list = [[MultiListView alloc] initWithFrame:CGRectMake(0, 300, 320, 200) selectView:control];
    list.scrollAnimate   = YES;
    list.backgroundColor = [UIColor grayColor];
    list.viewControllers = vcArr;
    list.superController = self;
    [self.view addSubview:list];
    
}

@end
