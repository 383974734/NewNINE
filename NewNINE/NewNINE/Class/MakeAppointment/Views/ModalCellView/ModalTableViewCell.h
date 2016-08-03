//
//  ModalTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/5.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooseTimeModel;
@class ModalTableViewCell;

@protocol ModalTableViewCellDelegate <NSObject>

@optional
- (void)modalTableViewCell:(ModalTableViewCell *)modalTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface ModalTableViewCell : UITableViewCell

@property (nonatomic, strong) ChooseTimeModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *btnSele;

@property (nonatomic, strong) id<ModalTableViewCellDelegate> delegate;

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
