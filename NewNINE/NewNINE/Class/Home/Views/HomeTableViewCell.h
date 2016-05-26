//
//  HomeTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页 ----> 热门发型视图

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell


/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return HomeTableViewCell
 */
+ (instancetype) homeCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
