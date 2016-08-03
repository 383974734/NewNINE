//
//  InformationTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 信息view

#import <UIKit/UIKit.h>

@interface InformationTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

/** 接收分类标题  （用户昵称， 预约时间， 服务门店）*/
@property (nonatomic, copy) NSString *titleStr;
/** 接收分类内容  */
@property (nonatomic, copy) NSString *nameStr;


/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return InformationTableViewCell
 */
+ (instancetype) informationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
