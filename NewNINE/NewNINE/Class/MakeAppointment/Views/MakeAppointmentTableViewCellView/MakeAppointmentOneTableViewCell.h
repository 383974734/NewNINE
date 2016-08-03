//
//  MakeAppointmentOneTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/21.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MakeAppointmentOneTableViewCell;


@protocol MakeAppointmentOneTableViewCellDelegate <NSObject>

@optional
/**
 *  预约美发头像分区代理
 *
 *  @param makeAppointmentOneTableViewCell MakeAppointmentOneTableViewCell
 *  @param tag                             选择的第几行
 *  @param selectCategory                  选择的分类 //选中分类    （0：洗剪吹没选中         1：选中了洗剪吹         2：洗吹没选中      3：选中了洗吹）
 */
- (void)makeAppointmentOneTableViewCell:(MakeAppointmentOneTableViewCell *)makeAppointmentOneTableViewCell buttonWithTag:(NSInteger)tag selectCategory:(NSString *)selectCategory;

@end

@interface MakeAppointmentOneTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MakeAppointmentOneTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSDictionary  *dict;

@property (nonatomic, copy)   NSString      *timeMake;

/** 洗剪吹、洗吹   选择状态是否复原*/  //默认无选择  false
@property (nonatomic, getter=isHiddenSelected) BOOL hiddenSelected;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MakeAppointmentOneTableViewCell
 */
+ (instancetype) makeAppointmentOneCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
