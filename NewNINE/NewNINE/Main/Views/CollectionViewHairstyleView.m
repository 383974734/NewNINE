//
//  CollectionViewHairstyleView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  ----------->  UICellectionView   封装   用来介展示发型页面的信息

#import "CollectionViewHairstyleView.h"

// ---------------------- view       ----------------------
#import "HairstyleCollectionViewCell.h"
// ---------------------- view       ----------------------

static NSString *cellID = @"CollectionViewHairstyleViewCell";

@interface CollectionViewHairstyleView ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 发型展示列表*/
@property (nonatomic, strong) UICollectionView       *collectionViewHairstyle;
#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation CollectionViewHairstyleView


- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.collectionViewHairstyle];
}

- (void)settingAutoLayout {

}

- (void)settingData {
    
}

#pragma mark - UICollectionView Delegate
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HairstyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    HairstyleViewControllerModel *model = self.dataArray[indexPath.row];
    cell.dataModel = model;
    return cell;
    
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);

}



#pragma mark   -  点击事件
- (void)didBtton:(UIButton *)btn {
    NSLog(@"预约按钮");
}
#pragma mark   -  所有控件懒加载
- (UICollectionView *) collectionViewHairstyle {
    if (!_collectionViewHairstyle) {
        
        UICollectionViewFlowLayout *flowLayout      = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing               = 0;
        flowLayout.minimumInteritemSpacing          = 0;
        flowLayout.itemSize                         = CGSizeMake( (SCREEN_WIDTH - 40) / 2, (SCREEN_WIDTH - 40) / 2 + 46);
        flowLayout.minimumLineSpacing               = 15.0;
        flowLayout.minimumInteritemSpacing          = 5;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionViewHairstyle = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0,  SCREEN_WIDTH - 30, SCREEN_HEIGHT - 120) collectionViewLayout:flowLayout];
        _collectionViewHairstyle.backgroundColor                = Color(248, 248, 248, 1);
        _collectionViewHairstyle.delegate                       = self;
        _collectionViewHairstyle.dataSource                     = self;
        _collectionViewHairstyle.pagingEnabled                  = NO;
        _collectionViewHairstyle.showsHorizontalScrollIndicator = NO;
        _collectionViewHairstyle.showsVerticalScrollIndicator   = NO;
//        [self settingCollectionViewRefreshing:_collectionViewHairstyle target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
        [_collectionViewHairstyle registerClass:[HairstyleCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
    }
    return _collectionViewHairstyle;
}
@end
