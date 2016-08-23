//
//  DepositTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 定金view

#import <UIKit/UIKit.h>

@class DepositTableViewCell;

@protocol DepositTableViewCellDelegate <NSObject>

@optional
/**
 *  提交订单 仅支付定金 cell 代理   选择 - 只支付50元   不选择不改变原有金额
 *
 *  @param depositTableViewCell DepositTableViewCell
 *  @param selectedBool         是否选择
 */
- (void)depositTableViewCell:(DepositTableViewCell *)depositTableViewCell selectedBool:(BOOL)selectedBool;

@end


@interface DepositTableViewCell : UITableViewCell

@property (nonatomic, assign) id<DepositTableViewCellDelegate> delegate;

/** 合计金额*/
@property (nonatomic, copy) NSString *totalString;
/** 是否有预付定金金额*///   2.付过预付定金   1.没有付订金
@property (nonatomic, copy) NSString *orderIsDepfund;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DepositTableViewCell
 */
+ (instancetype) depositCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
