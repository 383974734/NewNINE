//
//  HomeBannerTableViewCell.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页 ----> 轮播视图

#import <UIKit/UIKit.h>

@class HomeBannerTableViewCell;

@protocol HomeBannerTableViewCellDelegate <NSObject>

@optional
/**
 *  stBannerView 代理方法 (点击 stBannerView 每个cell调用代理方法)轮播
 *
 *  @param swpBannerView
 *  @param indexPath
 */
- (void)stPushBannerView:(HomeBannerTableViewCell *)stBannerView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HomeBannerTableViewCell : UITableViewCell


@property (assign, nonatomic) id<HomeBannerTableViewCellDelegate> delegate;
/** 轮播数据*/
@property (nonatomic, strong) NSArray *bannerArray;

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return HomeBannerTableViewCell
 */
+ (instancetype) homeBannerCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID;

@end
