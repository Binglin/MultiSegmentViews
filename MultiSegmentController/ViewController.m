//
//  ViewController.m
//  MultiSegmentController
//
//  Created by Zhenglinqin on 15/5/21.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

//
//- (void)loadView{
//    [super loadView];
//    [self  loadMore:NO];
//}

- (void)loadMore:(BOOL)more{
    self.dataSources = [NSMutableArray arrayWithObjects:
                        @"ArrowRectViewController",
                        @"GradientProgressController",
                        @"ProgressViewController",
                        @"AppleDownloadProgressController",
                        @"VerticalRowScrollViewVC",
                        @"MultiSegmentController"
                        ,nil];
    [self.tableView reloadData];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = self.dataSources[indexPath.row];
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
