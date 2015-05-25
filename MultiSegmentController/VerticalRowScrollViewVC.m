//
//  VerticalRowScrollView.m
//  MultiSegmentController
//
//  Created by 郑林琴 on 15/5/23.
//  Copyright (c) 2015年 Binglin. All rights reserved.
//

#import "VerticalRowScrollViewVC.h"


@interface VerticalRowScrollViewVC ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *_collectionView;
}

@end

@implementation VerticalRowScrollViewVC

- (void)loadView{
    [super loadView];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(960, 100);
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];

    _collectionView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_collectionView];
    _collectionView.contentSize = CGSizeMake(960, CGRectGetHeight(_collectionView.frame));
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(96, 100);
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

@end
