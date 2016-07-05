//
//  DesignerViewTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/8.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DesignerViewTableViewCell;

@protocol DesignerViewTableViewCellDelegate <NSObject>

@optional
/**
 *  点击预约跳页代理
 *
 *  @param designerViewTableViewCell DesignerViewTableViewCell
 *  @param stylistinfoId             预约的设计师id
 */
- (void)designerViewTableViewCell:(DesignerViewTableViewCell *)designerViewTableViewCell stylistinfoId:(NSString *)stylistinfoId;

@end



@class DesignerViewModel;

@interface DesignerViewTableViewCell : UITableViewCell

@property (nonatomic, strong)DesignerViewModel *dataModel;

@property (nonatomic, assign) id<DesignerViewTableViewCellDelegate> delegate;


/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DesignerViewTableViewCell
 */
+ (instancetype) designerViewTableViewCellCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
