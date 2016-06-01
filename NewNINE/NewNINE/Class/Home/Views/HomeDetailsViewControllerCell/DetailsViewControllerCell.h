//
//  DetailsViewControllerCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/30.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情控制器cell

#import <UIKit/UIKit.h>

@class DetailsViewControllerCell;
@protocol DetailsViewControllerCellDelegate <NSObject>

@optional
/**
 *  点击返回按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void)detailsReturnViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCell;

/**
 *  点击收藏按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void)detailsCollectionViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCell;


/**
 *  点击分享按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void)detailsShareViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCell;

/**
 *  点击预约按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void)detailsAppointmentBtnViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCell;

@end

@interface DetailsViewControllerCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *detailsDict;

@property (nonatomic, assign) id<DetailsViewControllerCellDelegate> delegate;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DetailsViewControllerCell
 */
+ (instancetype) detailsCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
