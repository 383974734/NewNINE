//
//  HairstyleCollectionViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/2.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  发型-----------> 发型控制器cell

#import <UIKit/UIKit.h>

#import "HairstyleViewControllerModel.h"

@interface HairstyleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HairstyleViewControllerModel *dataModel;

@end
