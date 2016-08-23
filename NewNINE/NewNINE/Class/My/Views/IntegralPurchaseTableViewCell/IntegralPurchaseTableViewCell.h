//
//  IntegralPurchaseTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralPurchaseTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *integralArray;

@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return IntegralPurchaseTableViewCell
 */
+ (instancetype) integralPurchaseTableViewCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
