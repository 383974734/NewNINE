//
//  ChooseTimeCollectionViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/30.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseTimeCollectionViewCell;

@protocol ChooseTimeModelDelegate <NSObject>

@optional
- (void)chooseTimeCollectionViewCell:(ChooseTimeCollectionViewCell *)chooseTimeCollectionViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@class ChooseTimeModel;

@interface ChooseTimeCollectionViewCell : UICollectionViewCell

/** 已经选定的预约时间*/
@property (nonatomic, copy) NSString *makeTime;

@property (nonatomic, strong) ChooseTimeModel *timeModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) id<ChooseTimeModelDelegate> delegate;

@end
