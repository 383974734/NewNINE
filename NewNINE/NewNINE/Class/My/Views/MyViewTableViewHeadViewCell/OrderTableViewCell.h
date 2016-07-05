//
//  OrderTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderTableViewCell;

@protocol OrderTableViewCellDelegate <NSObject>

@optional
/**
 *  通过点击的按钮来确定出现的弹出框
 *
 *  @param orderTableViewCell OrderTableViewCell
 *  @param title              button的title
 */
- (void)orderTableViewCell:(OrderTableViewCell *)orderTableViewCell buttonWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end


@class OrderViewModel;

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, assign) id<OrderTableViewCellDelegate> delegate;

@property (nonatomic, strong)OrderViewModel *dataModel;

@property (nonatomic, strong) NSIndexPath *index;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return OrderTableViewCell
 */
+ (instancetype) orderCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
