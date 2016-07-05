//
//  UserMessageTwoTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;

@interface UserMessageTwoTableViewCell : UITableViewCell

@property (nonatomic, copy) UserModel *twoUserData;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return HomeTableViewCell
 */
+ (instancetype) userMessageTwoCellWithTableView:(UITableView *)tableView;

@end
