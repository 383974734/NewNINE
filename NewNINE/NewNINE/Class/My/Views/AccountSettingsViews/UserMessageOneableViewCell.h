//
//  UserMessageOneableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserModel;

@interface UserMessageOneableViewCell : UITableViewCell

@property (nonatomic, copy) UserModel *userData;

@property (nonatomic, strong) UIImage *imageUser;

/**
 *  快速  初始化 一个自定义cell（汽配城列表cell）
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return HomeTableViewCell
 */
+ (instancetype) userMessageOneCellWithTableView:(UITableView *)tableView;
@end
