//
//  ClassificationTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 分类view

#import <UIKit/UIKit.h>


@class OrderViewModel;


@interface ClassificationTableViewCell : UITableViewCell


@property (nonatomic, strong) OrderViewModel *orderViewModel;

@property (nonatomic, strong) NSIndexPath       *indexPath;

/** 设计师预约数据*/
@property (nonatomic, strong) NSDictionary      *makeAppointmentDic;

@property (nonatomic, copy) NSString            *classificationStr;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return ClassificationTableViewCell
 */
+ (instancetype) classificationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
