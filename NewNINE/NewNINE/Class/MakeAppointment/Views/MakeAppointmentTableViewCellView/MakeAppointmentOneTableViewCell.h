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
 *  @param selectCategory1                 选择的分类  洗剪吹
 *  @param selectCategory2                 选择的分类  洗吹造型
 */
- (void)makeAppointmentOneTableViewCell:(MakeAppointmentOneTableViewCell *)makeAppointmentOneTableViewCell buttonWithTag:(NSInteger)tag selectCategory1:(NSString *)selectCategory1 selectCategory2:(NSString *)selectCategory2;

@end

@interface MakeAppointmentOneTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MakeAppointmentOneTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSDictionary  *dict;

@property (nonatomic, copy)   NSString      *timeMake;

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
