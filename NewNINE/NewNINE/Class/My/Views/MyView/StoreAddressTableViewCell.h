//
//  StoreAddressTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreAddressModel;

@interface StoreAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) StoreAddressModel *dataModel;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return StoreAddressTableViewCell
 */
+ (instancetype) soreAddressCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
