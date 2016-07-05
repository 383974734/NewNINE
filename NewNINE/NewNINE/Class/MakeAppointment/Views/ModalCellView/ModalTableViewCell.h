//
//  ModalTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/5.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModalTableViewCell : UITableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return ModalTableViewCell
 */
+ (instancetype) modalTableViewCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;


@end
