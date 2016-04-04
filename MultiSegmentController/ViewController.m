//
//  ViewController.m
//  MultiSegmentController
//
//  Created by Zhenglinqin on 15/5/21.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "ViewController.h"

#import "RedViewController.h"
#import "GreenViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

#import "MultiSegmentController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSources;
@end

@implementation ViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    }
    return _tableView;
}


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
    self.navigationController.navigationBar.translucent = false;
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self loadMore:false];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = self.dataSources[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = vcName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        NSArray *classArr = @[[RedViewController class],
//                              [BlueViewController class],
//                              [GreenViewController class],
                              [YellowViewController class]];
        NSMutableArray *vcArr = [NSMutableArray arrayWithCapacity:classArr.count];
        for (Class class in classArr) {
            UIViewController *vc  = [[class alloc] init];
            [vcArr addObject:vc];
        }
        MultiSegmentController * segVC = [[MultiSegmentController alloc] init];
        segVC.segmentItemsControllers  = vcArr;
        [self.navigationController pushViewController:segVC animated:true];
    }
    else{
        NSString *vcName = self.dataSources[indexPath.row];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
