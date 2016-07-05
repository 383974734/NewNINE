//
//  MyEvaluationTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/17.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyEvaluationModel;

@interface MyEvaluationTableViewCell : UITableViewCell

@property (nonatomic, strong) MyEvaluationModel *dataModel;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MyEvaluationTableViewCell
 */
+ (instancetype) myEvaluationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
