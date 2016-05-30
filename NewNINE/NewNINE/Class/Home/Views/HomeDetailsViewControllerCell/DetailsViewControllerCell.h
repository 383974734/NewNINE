//
//  DetailsViewControllerCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/30.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情控制器cell

#import <UIKit/UIKit.h>

@interface DetailsViewControllerCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *detailsDict;

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
