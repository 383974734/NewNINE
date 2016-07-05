//
//  PublicDesignerTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/1.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情公共设计师控制器cell

#import <UIKit/UIKit.h>

@class PublicDesignerTableViewCell;
@protocol PublicDesignerTableViewCellDelegate <NSObject>

@optional
/**
 *  点击公共发型预约代理
 *
 *  @param publicDesignerTableViewCell PublicDesignerTableViewCell
 *  @param indexPath                   索引
 */
- (void)publicDesignerTableViewCell:(PublicDesignerTableViewCell *)publicDesignerTableViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PublicDesignerTableViewCell : UITableViewCell

{
    long height;
}

@property (nonatomic, strong) NSArray *arratData;

@property (nonatomic, assign) id<PublicDesignerTableViewCellDelegate> delegate;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return PublicDesignerTableViewCell
 */
+ (instancetype) publicDesignerpCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
