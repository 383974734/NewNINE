//
//  IntegralTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntegralViewModel;

@interface IntegralTableViewCell : UITableViewCell


@property (nonatomic, strong)IntegralViewModel *dataModel;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return CollectionTableViewCell
 */
+ (instancetype) integralCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
