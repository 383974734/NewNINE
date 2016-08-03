//
//  MakeAppointmentTwoTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/21.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MakeAppointmentTwoTableViewCell;

@protocol MakeAppointmentTwoTableViewCellDelegate <NSObject>

@optional
/**
 *  预约美发 点击（烫染， 染发， 护理， 养护）代理
 *
 *  @param MakeAppointmentTwoTableViewCell MakeAppointmentTwoTableViewCell
 *  @param indexPath                       点击的索引
 */
- (void)MakeAppointmentTwoTableViewCell:(MakeAppointmentTwoTableViewCell *)MakeAppointmentTwoTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface MakeAppointmentTwoTableViewCell : UITableViewCell
/** 选择的护理分类*/
@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, assign) id<MakeAppointmentTwoTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MakeAppointmentTwoTableViewCell
 */
+ (instancetype) makeAppointmentTwoCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;


@end
