//
//  DiscountTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DiscountViewModel;

@interface DiscountTableViewCell : UITableViewCell

@property (nonatomic, strong)DiscountViewModel *dataModel;

@property (nonatomic, copy) NSString *status;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DiscountTableViewCell
 */
+ (instancetype) discountCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
