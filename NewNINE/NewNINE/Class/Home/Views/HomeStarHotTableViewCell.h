//
//  HomeStarHotTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页 ----> 明星标题、明星轮播、热门标题 视图

#import <UIKit/UIKit.h>

@interface HomeStarHotTableViewCell : UITableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return HomeStarHotTableViewCell
 */
+ (instancetype) homeStarHotCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
