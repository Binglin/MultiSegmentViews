//
//  AppleDownloadProgressController.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/24.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "AppleDownloadProgressController.h"
#import "AppleDownloadView.h"

@interface AppleDownloadProgressController ()

@property (strong, nonatomic)  AppleDownloadView *downLoadView;


@end

@implementation AppleDownloadProgressController

- (void)loadView{
    [super loadView];
    self.downLoadView = [[AppleDownloadView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.downLoadView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    ani.fromValue = @(0.f);
    
    ani.toValue   = @(1.0f);
    ani.duration = 5.f;
    ani.repeatCount = NSNotFound;
    
    [self.downLoadView.progressLayer addAnimation:ani forKey:@"stroke"];
}


@end
