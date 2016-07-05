//
//  MyContentTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyContentTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *strImage;
@property (nonatomic, copy) NSString *strLable;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MyContentTableViewCell
 */
+ (instancetype) myContentCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
