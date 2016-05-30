//
//  HomeTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页 ----> 热门发型视图

#import <UIKit/UIKit.h>

@class HomeBannerModels;
@class HomeTableViewCell;

@protocol HomeTableViewCellDelegate <NSObject>

@optional
-(void) HomeTableViewCell:(HomeTableViewCell *)HomeTableViewCell buttonIndex:(NSIndexPath *)indexPath;

@end

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, assign, getter=isBtnHidden) BOOL btnHidden;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) HomeBannerModels *cellModel;

@property (nonatomic, assign) id<HomeTableViewCellDelegate> delegate;
/** 发型师详情的图片url*/
@property (nonatomic, copy) NSString *photoUrl;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return HomeTableViewCell
 */
+ (instancetype) homeCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
