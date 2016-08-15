//
//  ServiceClassificationTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/10.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseTimeModel;
@class ServiceClassificationTableViewCell;

@protocol ServiceClassificationTableViewCellDelegate <NSObject>

@optional
/**
 *  ServiceClassificationTableViewCell
 *
 *  @param serviceClassificationTableViewCell ServiceClassificationTableViewCell
 *  @param indexPath                          所选indexPath
 */
- (void)serviceClassificationTableViewCell:(ServiceClassificationTableViewCell *)serviceClassificationTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath btnSelected:(NSString *)btnSelected;

@end


@interface ServiceClassificationTableViewCell : UITableViewCell

@property (nonatomic, strong) ChooseTimeModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *btnSele;

@property (nonatomic, strong) id<ServiceClassificationTableViewCellDelegate> delegate;
/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return ServiceClassificationTableViewCell
 */
+ (instancetype) serviceClassificationCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
