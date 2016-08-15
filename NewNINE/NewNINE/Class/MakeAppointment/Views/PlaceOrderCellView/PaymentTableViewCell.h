//
//  PaymentTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 支付view

#import <UIKit/UIKit.h>

@class PaymentTableViewCell;

@protocol PaymentTableViewCellDelegate <NSObject>

@optional

/**
 *  提价订单积分抵扣 - 代理         点击积分抵扣  传递抵扣金额
 *
 *  @param paymentTableViewCell PaymentTableViewCellDelegate
 *  @param deductibleStr        抵扣金额
 *  @param selectedBool         是否选择
 */
- (void)paymentTableViewCell:(PaymentTableViewCell *)paymentTableViewCell deductibleStr:(NSString *)deductibleStr selectedBool:(BOOL)selectedBool;;

@end


@interface PaymentTableViewCell : UITableViewCell


/** 导航名称*/
@property (nonatomic, copy) NSString      *titleString;
/** 接收分类标题  （优惠卷， 可用积分， 实付金额）*/
@property (nonatomic, copy) NSString      *titleStr;
/** 接收分类内容  */
@property (nonatomic, copy) NSString      *nameStr;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id<PaymentTableViewCellDelegate> delegate;




/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return PaymentTableViewCell
 */
+ (instancetype) paymentCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
