//
//  CollectionTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DesignerViewModel;
@class CollectionTableViewCell;

@protocol CollectionTableViewCellDelegate <NSObject>

@optional
/**
 *  收藏 --  设计师 页面的cell 代理
 *
 *  @param CollectionTableViewCell CollectionTableViewCell
 *  @param indexPath               点击的索引
 */
- (void)CollectionTableViewCell:(CollectionTableViewCell *)CollectionTableViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface CollectionTableViewCell : UITableViewCell

@property (nonatomic, strong)DesignerViewModel *dataModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id<CollectionTableViewCellDelegate> delegate;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return CollectionTableViewCell
 */
+ (instancetype) collectionCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID ;

@end
