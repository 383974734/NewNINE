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

- (void)makeAppointmentOneTableViewCell:(MakeAppointmentOneTableViewCell *)makeAppointmentOneTableViewCell buttonWithTag:(NSInteger)tag;

@end

@interface MakeAppointmentOneTableViewCell : UITableViewCell

@property (nonatomic, assign) id<MakeAppointmentOneTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSDictionary *dict;

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
