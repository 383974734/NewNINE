//
//  MyHeadTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyHeadTableViewCell;

@protocol MyHeadTableViewCellDelegate <NSObject>

@optional

/**
 *  点击不同button按钮的代理事件
 *
 *  @param myHeadTableViewCell MyHeadTableViewCell
 *  @param tag                 点击的那个button
 *  @param name                用来区分是哪个代理  (0 点击我的头像  全部订单   修改昵称  事件) (1 是 我的控制器 ---收藏 --积分 --优惠卷  代理) (2 是 我的控制器 ---未付款 --预约成功 --已完成 --退款  按钮  代理)
 */
- (void)myHeadTableViewCell:(MyHeadTableViewCell *)myHeadTableViewCell buttonWithTag:(NSInteger)tag name:(NSString *)name;

@end


@interface MyHeadTableViewCell : UITableViewCell 

@property (nonatomic, assign)id<MyHeadTableViewCellDelegate> delegate;


/** 个人信息数据*/
@property (nonatomic, strong) NSDictionary *userDict;

@property (nonatomic, strong) UIImage *imageUser;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MyHeadTableViewCell
 */
+ (instancetype) myHeadCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
