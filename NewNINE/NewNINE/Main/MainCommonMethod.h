//
//  MainCommonMethod.h
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainCommonMethod : NSObject


/**
 * @brief           公用方法类
 *
 *                  封装了一些常用方法
 * @author          xiaog
 * @version         0.1
 * @date            2012-12-18
 * @since           2012-12 ~
 */


+ (void)settingBackButtonImage:(NSString *)imagename selectedImage:(NSString *)selImagename andContrller:(UIViewController *)controller;

/**
 *	@brief	在应用内拨打电话
 *
 *	@param 	phoneNumber 	电话号码
 *	@param 	view 	调用controller的view
 */
+ (void)callPhone:(NSString *)phoneNumber superView:(UIView *)view;


/**
 *	@brief	设置按钮的image或者backgroundImage
 *
 *	@param 	button 	按钮
 *	@param 	imageUrl 	正常状态的图片名称
 *	@param 	highLightImageUrl 	高亮状态的图片名称
 */
+ (void)settingButton:(UIButton *)button Image:(NSString *)imageUrl hightLightImage:(NSString *)highLightImageUrl;

+ (void)settingButton:(UIButton *)button Image:(NSString *)imageUrl hightLightImage:(NSString *)highLightImageUrl disableImage:(NSString *)disableImageUrl;

/**
 *	@brief	判断应用运行在什么系统版本上
 *
 *	@return	返回系统版本 ：7.0     6.0     6.1等
 */
+ (CGFloat)checkSystemVersion;


/**
 *	@brief	判断应用的版本号
 *
 *	@return	返回版本号
 */
+ (NSString *)checkAPPVersion;


/**
 *	@brief	给应用提供统一的返回按钮样式
 *
 *  图片尺寸是 40*40 80*80
 *	@param 	imagename 	正常状态时的图片名称
 *	@param 	selImagename 	高亮时候的状态名称
 */
+ (void) settingBackButtonImage:(NSString *)imagename andSelectedImage:(NSString *)selImagename;


#pragma mark - 隐藏tableView 多余的cell & 补齐tableView cell的分割线
/**
 *  @author swp_song     2015年05月15日11:33:39
 *	@brief	隐藏tableivew中多余的cell
 *
 *	@param 	tableview 	承载的Tableview
 */
+ (void) hiddleExtendCellFromTableview:(UITableView *)tableview;

/**
 *  @author swp_song    2015年05月15日11:33:47
 *  @brief  补全tableViewCell分割线
 *
 *  @param  tableView
 *  @param  cell
 */
+ (void) settingTableViewAllCellWire:(UITableView *)tableView andTableViewCell:(UITableViewCell *)cell;



#pragma mark - webView 跳转远程url
/**
 *  @author swp_song    2015年05月15日11:34:11
 *	@brief	web 加载 远程URL
 *
 *  @param webView 需要加载url的webView
 *  @param string  加载的 url 字符串
 */
+ (void) webViewUpLoadUrl:(UIWebView *)webView withString:(NSString *)string;


#pragma mark - 拨打电话 & 发信息
/**
 *  @author swp_song  2015年05月15日11:34:31
 *	@brief	拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void) dialingPhone:(NSString *)phoneNumber superView:(UIView *)view;

/**
 *  @author swp_song  2015年05月15日11:34:37
 *	@brief	发送短信息
 *
 *  @param  phoneNumber 电话号码
 */
+ (void) sendMessage:(NSString *)phoneNumber;

#pragma mark - 去除字符串的前后空格
/**
 *  @author swp_song 2015年05月15日11:34:49
 *	@brief	截取 字符串 前后空格
 *  @param  string
 *  @return NSString
 */
+ (NSString *) trimString:(NSString *)string;

#pragma mark - 定时器
/**
 *  @author swp_song 2015年05月15日11:34:54
 *	@brief	在一个button 显示 倒计时 计时器 (倒计时1秒钟)
 *
 *  @param  button 显示的按钮
 *  @param  time   倒计时时间
 */
+ (void) codeTimer:(UIButton *)button andTime:(int)time;


#pragma mark - 设置导航控制器上的按钮
/**
 *  @author swp_song 2015年05月15日11:35:03
 *	@brief	设置导航栏 上的的按钮 (直接返回 UIBarButtonItem)
 *
 *  @param  defaultImage     默认图片
 *  @param  highlightedImage 点击图片
 *  @param  target           目标
 *  @param  action           绑定目标
 *  @param  isLeftButton     YES 是导航栏左侧按钮 NO是导航栏右侧按钮
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *) settingNavBarButtonItemWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;
/**
 *  @author swp_song 2015年05月15日11:35:11
 *	@brief	设置导航栏 文字按钮 (直接返回 UIBarButtonItem)
 *
 *  @param  buttonTitle  按钮的文字
 *  @param  color        文字的颜色
 *  @param  size         字体的大小
 *  @param  target       目标
 *  @param  action       绑定方法
 *  @param  tag          buttonTag
 *  @param  isLeftButton YES 是导航栏左侧按钮 NO是导航栏右侧按钮
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *) settingNavBarButtonItemWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;

/**
 *  @author swp_song 2015年05月15日11:35:18
 *	@brief	设置导航栏 图片按钮 (直接返回 UIButton)
 *
 *  @param  defaultImage     默认图片
 *  @param  highlightedImage 点击图片
 *  @param  target           目标
 *  @param  action           绑定方法
 *  @param  tag              buttonTag
 *  @param  isLeftButton     YES 是导航栏左侧按钮 NO是导航栏右侧按钮
 *
 *  @return UIButton
 */
+ (UIButton *) settingNavButtonItemWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;
/**
 *  @author swp_song 2015年05月15日11:35:26
 *	@brief	设置导航栏 文字按钮 (直接返回 UIButton)
 *
 *  @param  buttonTitle  按钮的文字
 *  @param  color        文字的颜色
 *  @param  size         字体的大小
 *  @param  target       目标
 *  @param  action       绑定方法
 *  @param  tag          buttonTag
 *  @param  isLeftButton YES 是导航栏左侧按钮 NO是导航栏右侧按钮
 *
 *  @return UIButton
 */
+ (UIButton *) settingNavButtonItemWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton;


#pragma mark - 设置导航控制器 搜索条
/**
 *
 *
 *  @param  searchBarWidth searchBar 宽度
 *  @param  searchBarColor searchBar 背景颜色
 *  @param  tag            searchBar tag
 *  @param  imageX         searchBar 图片的X的值
 *  @param  image          searchBar 显示的图片
 *  @param  titleWidth     searchBar 文字的宽度
 *  @param  fontSize       searchBar 文字的大小
 *  @param  fontColor      searchBar 文字的颜色
 *  @param  title          searchBar 显示的文字
 *
 *  @return UIView
 */
+ (UIView *) settingNavSearchBarWidth:(CGFloat)searchBarWidth backgroundColor:(UIColor *)searchBarColor searchBarTag:(NSInteger)tag searchImageX:(CGFloat)imageX searchImage:(NSString *)image  searchTitleWidth:(CGFloat)titleWidth searchTitleFontSize:(CGFloat)fontSize searchTitleFontColor:(UIColor *)fontColor searchTitle:(NSString *)title;


#pragma mark - 跳转控制器
/**
 *  @author swp_song 2015年05月15日11:35:35
 *	@brief	跳转控制器 (使用字符串实例化控制器)
 *
 *  @param navigationController 导航控制器
 *  @param controllerClass      需要跳转控制的的名称
 */
+ (void) jumpContrillerWith:(UINavigationController *)navigationController push:(NSString *)controllerClass;

#pragma mark - 验证是否分页
/**
 *  @author swp_song 2015年05月15日11:35:37
 *	@brief	是否是分页数据 是分页数据 (是分页数据 数组不清空)
 *
 *  @param  dataArray 数据源数组
 *  @param  page      分页数
 *  @param  firstPage 第一页
 *
 *  @return 数据源
 */
+ (NSMutableArray *) chekPageWithDataSource:(NSMutableArray *)dataSource page:(NSInteger)page firstPage:(NSInteger)firstPage;

/**
 *  @author swp_song 2015年05月15日11:35:45
 *	@brief	设置相同 label 一些公共的属性
 *
 *  @param label     需要设置label
 *  @param isShow    是否显示边框
 *  @param fontSize  字体的大小
 *  @param fontColor 字体的颜色
 */
+ (void) settingLabelProperty:(UILabel *)label showBorderWidth:(BOOL)isShow fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor;

#pragma mark - 绑定一个点击手势到 一个 view
/**
 *  @author swp_song 2015年05月24日15:55:25
 *	@brief	绑定一个点击手势到 一个 view上
 *  @param  view    需要绑定的View
 *  @param  count   点击次数
 *  @param  target  目标
 *  @param  action  绑定方法
 *  @param  cancels 默认YES (需要是开启)
 *
 *  @return UITapGestureRecognizer
 */
+ (UITapGestureRecognizer *) settingTapGestureRecognizer:(UIView *)view clickCount:(NSInteger)count addTarget:(id)target action:(SEL)action cancelsTouchesInView:(BOOL)cancels;

#pragma mark - 时间处理
/**
 *  获取当前系统时间 转换成 指定格式
 *
 *  @param  format 时间格式化格式
 *
 *  @return 时间
 */
+ (NSString *) getSystemDateWithFormat:(NSString *)format;


@end
