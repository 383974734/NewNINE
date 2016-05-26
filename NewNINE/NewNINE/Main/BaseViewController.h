//
//  BaseViewController.h
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>


static BOOL      automaticallyRefresh     = NO;
static NSString *headerRereshingDataTitle = @"努力刷新中...";
static NSString *footerRereshingDataTitle = @"努力加载中...";
static NSString *notHaveDataTitle         = @"没有数据啦";

@interface BaseViewController : UIViewController

/**
 *  设置 导航控制器 显示 文字 颜色 字体 小大
 *
 *  @param title        标题名称
 *  @param textColot    文字 颜色 (nil 默认 显示黑色)
 *  @param fontSize     文字大小
 */
- (void)settingNavigationBarTitle:(NSString *)title textColor:(UIColor *)textColot titleFontSize:(CGFloat)fontSize;

/**
 *  设置tableView 刷新组件
 *
 *  @param tableView    需要设置tableView
 *  @param target       刷新组件的控制器
 *  @param headerAction 头部刷新方法
 *  @param footerAction 尾部刷新方法
 */
- (void) settingTableViewRefreshing:(UITableView *)tableView target:(id)target headerAction:(SEL)headerAction footerAction:(SEL)footerAction;

#pragma mark - Setting Refreshing
/**
 *  设置tableView 刷新组件
 *
 *  @param tableView    需要设置tableView
 *  @param target       刷新组件的控制器
 *  @param headerAction 头部刷新方法
 */
- (void) settingTableViewRefreshing:(UITableView *)tableView target:(id)target headerAction:(SEL)headerAction;

/**
 *  设置collectionView 刷新组件
 *
 *  @param collectionView    需要设置tableView
 *  @param target            刷新组件的控制器
 *  @param headerAction      头部刷新方法
 *  @param footerAction      尾部刷新方法
 */
- (void) settingCollectionViewRefreshing:(UICollectionView *)collectionView target:(id)target headerAction:(SEL)headerAction footerAction:(SEL)footerAction;

/** 获取网路数据返回的参数 */
typedef void (^getData)(id param);


@end
