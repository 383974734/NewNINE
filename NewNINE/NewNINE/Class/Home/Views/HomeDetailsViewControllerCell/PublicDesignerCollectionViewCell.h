//
//  PublicDesignerCollectionViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/1.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情公共设计师显示列表控制器cell

#import <UIKit/UIKit.h>


@class PublicDesignerCollectionViewCell;
@protocol PublicDesignerCollectionViewCellDelegate <NSObject>

@optional
/**
 *  点击公共发型的立即预约按钮   代理
 *
 *  @param publicDesignerCollectionViewCell PublicDesignerCollectionViewCell
 *  @param indexPath                        点击的索引
 */
- (void)publicDesignerCollectionViewCell:(PublicDesignerCollectionViewCell *)publicDesignerCollectionViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PublicDesignerCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSDictionary *dictData;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id<PublicDesignerCollectionViewCellDelegate> delegate;

@end
