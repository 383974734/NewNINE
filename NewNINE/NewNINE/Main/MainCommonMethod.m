//
//  MainCommonMethod.m
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MainCommonMethod.h"

@implementation MainCommonMethod

+ (void)callPhone:(NSString *)phoneNumber superView:(UIView *)view
{
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [webview loadRequest:[NSURLRequest requestWithURL:url]];
    [view addSubview:webview];
}

+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
         disableImage:(NSString *)disableImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
    
    [button setImage:[UIImage imageNamed:disableImageUrl]
            forState:UIControlStateDisabled];
}


+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
      hightLightImage:(NSString *)highLightImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:highLightImageUrl]
            forState:UIControlStateHighlighted];
}


+ (void)settingButton:(UIButton *)button
                Image:(NSString *)imageUrl
        selectedImage:(NSString *)selectedImageUrl
{
    [button setImage:[UIImage imageNamed:imageUrl]
            forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:selectedImageUrl]
            forState:UIControlStateSelected];
}




+ (void)settingBackButtonImage:(NSString *)imagename andSelectedImage:(NSString *)selImagename
{
    UIImage* backImage = [[UIImage imageNamed:imagename]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    UIImage* backImageSel = [[UIImage imageNamed:selImagename]
                             resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 0)];
    
    if (IOS7) {
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBackIndicatorImage:backImage];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImageSel];
    }
    else{
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImage
                                                          forState:UIControlStateNormal
                                                        barMetrics:UIBarMetricsDefault];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backImageSel
                                                          forState:UIControlStateHighlighted
                                                        barMetrics:UIBarMetricsDefault];
    }
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, -1000)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
}


//+ (void)settingLeftButtonImage:(NSString *)imagename
//                 selectedImage:(NSString *)selectedImagename
//                        action:(SEL)action
//               andAtButtonItem:(UIBarButtonItem *)buttonItem
//{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:imagename]
//                      forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:selectedImagename]
//                      forState:UIControlStateHighlighted];
//    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//
//    UIBarButtonItem *mybuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//#warning 内存溢出
//    buttonItem = mybuttonItem;
//}


+ (void)settingBackButtonImage:(NSString *)imagename
                 selectedImage:(NSString *)selectedImagename
                  andContrller:(UIViewController *)controller
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imagename]
            forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImagename]
            forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(backToFather:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *mybuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    controller.navigationItem.leftBarButtonItem = mybuttonItem;
}
+ (void)backToFather:(UIButton *)sender
{
    UINavigationBar *navigationBar = (UINavigationBar *)sender.superview;
    UINavigationController *nc = (UINavigationController *)[self GetViewController:navigationBar];
    [nc popViewControllerAnimated:YES];
}
+ (UIViewController*)GetViewController:(UIView*)uView
{
    for (UIView* next = [uView superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}


+ (CGFloat)checkSystemVersion
{
    static dispatch_once_t onceToken;
    __block float systemVersion = 0;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    return systemVersion;
}

+ (NSString *)checkAPPVersion
{
    static dispatch_once_t onceToken;
    __block NSString *APPVersion = 0;
    dispatch_once(&onceToken, ^{
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        APPVersion = [infoDict objectForKey:@"CFBundleVersion"];
    });
    return APPVersion;
}



#pragma mark - 隐藏tableView 多余的cell & 补齐tableView cell的分割线
/**
 *  @author swp_song     2015年05月15日11:33:39
 *	@brief	隐藏tableivew中多余的cell
 *
 *	@param 	tableview 	承载的Tableview
 */
+ (void)hiddleExtendCellFromTableview:(UITableView *)tableview {
    UIView *view         = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [tableview setTableFooterView:view];
}

/**
 *  @author swp_song    2015年05月15日11:33:47
 *  @brief  补全tableViewCell分割线
 *
 *  @param  tableView
 *  @param  cell
 */
+ (void)settingTableViewAllCellWire:(UITableView *)tableView andTableViewCell:(UITableViewCell *)cell {
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset :UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins  :UIEdgeInsetsZero];
    }
}


#pragma mark - webView 跳转远程url
/**
 *  @author swp_song    2015年05月15日11:34:11
 *	@brief	web 加载 远程URL
 *
 *  @param webView 需要加载url的webView
 *  @param string  加载的 url 字符串
 */
+ (void) webViewUpLoadUrl:(UIWebView *)webView withString:(NSString *)string {
    NSURL *url            = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - 拨打电话 & 发信息
/**
 *  @author swp_song  2015年05月15日11:34:31
 *	@brief	拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void) dialingPhone:(NSString *)phoneNumber superView:(UIView *)view {
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL     *url     = [NSURL URLWithString:[@"tel://" stringByAppendingString:phoneNumber]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [view addSubview:webView];
}

/**
 *  @author swp_song  2015年05月15日11:34:37
 *	@brief	发送短信息
 *
 *  @param  phoneNumber 电话号码
 */
+ (void) sendMessage:(NSString *)phoneNumber {
    NSString *sms = [NSString stringWithFormat:@"sms://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sms]];
}


#pragma mark - 去除字符串的前后空格
/**
 *  @author swp_song 2015年05月15日11:34:49
 *	@brief	截取 字符串 前后空格
 *  @param  string
 *  @return NSString
 */
+ (NSString *) trimString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


#pragma mark - 定时器
/**
 *  @author swp_song 2015年05月15日11:34:54
 *	@brief	在一个button 显示 倒计时 计时器 (倒计时1秒钟)
 *
 *  @param  button 显示的按钮
 *  @param  time   倒计时时间
 */
+ (void) codeTimer:(UIButton *)button andTime:(int)time {
    
    __block int timeout         = time;
    dispatch_queue_t queue      = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer    = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:@"获取验证码" forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [button setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


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
 */+ (UIBarButtonItem *) settingNavBarButtonItemWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton {
     
     //    button.layer.borderWidth = 1;
     UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
     button.tag       = tag;
     button.frame     = CGRectMake(0, 0, 44, 44);
     [button setImage:defaultImage       forState:UIControlStateNormal];
     [button setImage:highlightedImage   forState:UIControlStateHighlighted];
     [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
     if (isLeftButton) {
         button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
     } else {
         button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
     }
     return [[UIBarButtonItem alloc]initWithCustomView:button];
 }

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
+ (UIBarButtonItem *) settingNavBarButtonItemWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = CGRectMake(0, 0, 44, 44);
    button.tag       = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (isLeftButton) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, -20);
    } else {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, -10);
    }
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

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
+ (UIButton *) settingNavButtonItemWithImage:(UIImage *)defaultImage highlightedImage:(UIImage *)highlightedImage target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag       = tag;
    button.frame     = CGRectMake(0, 0, 44, 44);
    [button setImage:defaultImage       forState:UIControlStateNormal];
    [button setImage:highlightedImage   forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (isLeftButton) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    } else {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    }
    return button;
}

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
+ (UIButton *) settingNavButtonItemWithTitle:(NSString *)buttonTitle fontColot:(UIColor *)color fontSize:(CGFloat)size target:(id)target action:(SEL)action buttonTag:(NSInteger)tag leftButton:(BOOL)isLeftButton  {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame     = CGRectMake(0, 0, 44, 44);
    button.tag       = tag;
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    if (isLeftButton) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    } else {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    }
    return button;
}


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
+ (UIView *) settingNavSearchBarWidth:(CGFloat)searchBarWidth backgroundColor:(UIColor *)searchBarColor searchBarTag:(NSInteger)tag searchImageX:(CGFloat)imageX searchImage:(NSString *)image  searchTitleWidth:(CGFloat)titleWidth searchTitleFontSize:(CGFloat)fontSize searchTitleFontColor:(UIColor *)fontColor searchTitle:(NSString *)title  {
    
    
    UIView  *searchBar              = [[UIView alloc] init];
    searchBar.frame                 = CGRectMake(0, 0, searchBarWidth - 50, 30);
    searchBar.backgroundColor       = searchBarColor;
    searchBar.tag                   = tag;
    searchBar.layer.cornerRadius    = 15.0;
    searchBar.layer.masksToBounds   = YES;
    searchBar.layer.borderWidth     = 1;
    searchBar.layer.borderColor     = [UIColor lightGrayColor].CGColor;
    
    UIImageView *searchImageView    = [[UIImageView alloc] init];
    CGFloat searchImageViewX        = imageX;
    CGFloat searchImageViewW        = searchBar.frame.size.height;
    CGFloat searchImageViewH        = searchBar.frame.size.height;
    searchImageView.frame           = CGRectMake(searchImageViewX, 9, searchImageViewW - 20, searchImageViewH - 20);
    searchImageView.image              = [UIImage imageNamed:image];
    searchImageView.layer.borderColor  = [UIColor redColor].CGColor;
    //    searchImageView.layer.borderWidth  = 1;
    //    searchImageView.contentMode        = UIViewContentModeCenter;
    [searchBar addSubview:searchImageView];
    
    
    UILabel *searchTitleView        = [[UILabel alloc] init];
    CGFloat searchTitleViewX        = CGRectGetMaxX(searchImageView.frame) + 6;
    CGFloat searchTitleViewW        = titleWidth;
    CGFloat searchTitleViewH        = searchImageViewH;
    searchTitleView.frame           = CGRectMake(searchTitleViewX, 0, searchTitleViewW, searchTitleViewH);
    searchTitleView.backgroundColor = [UIColor clearColor];
    searchTitleView.text            = title;
    searchTitleView.font            = [UIFont systemFontOfSize:fontSize];
    searchTitleView.textColor       = fontColor;
    [searchBar addSubview:searchTitleView];
    
    return searchBar;
}


#pragma mark - 跳转控制器
/**
 *  @author swp_song 2015年05月15日11:35:35
 *	@brief	跳转控制器 (使用字符串实例化控制器)
 *
 *  @param navigationController 导航控制器
 *  @param controllerClass      需要跳转控制的的名称
 */
+ (void) jumpContrillerWith:(UINavigationController *)navigationController push:(NSString *)controllerClass {
    [navigationController pushViewController:[[[NSClassFromString(controllerClass) class] alloc] init] animated:YES];
}

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
+ (NSMutableArray *) chekPageWithDataSource:(NSMutableArray *)dataSource page:(NSInteger)page firstPage:(NSInteger)firstPage {
    
    NSMutableArray *array = [NSMutableArray array];
    if (page != firstPage) {
        array = dataSource;
    }
    return array;
}



/**
 *  @author swp_song 2015年05月15日11:35:45
 *	@brief	设置相同 label 一些公共的属性
 *
 *  @param label     需要设置label
 *  @param isShow    是否显示边框
 *  @param fontSize  字体的大小
 *  @param fontColor 字体的颜色
 */
+ (void) settingLabelProperty:(UILabel *)label showBorderWidth:(BOOL)isShow fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor {
    
    if (isShow) {
        label.layer.borderWidth = 1;
    }
    label.font              = [UIFont systemFontOfSize:fontSize];
    label.textColor         = fontColor;
}

#pragma mark - 绑定点击手势
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
+ (UITapGestureRecognizer *) settingTapGestureRecognizer:(UIView *)view clickCount:(NSInteger)count addTarget:(id)target action:(SEL)action cancelsTouchesInView:(BOOL)cancels {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired    = count;
    tap.cancelsTouchesInView    = cancels;
    [tap addTarget:target action:action];
    [view addGestureRecognizer:tap];
    return tap;
}


#pragma mark - 时间处理
/**
 *  获取当前系统时间 转换成 指定格式
 *
 *  @param  format 时间格式化格式
 *
 *  @return 时间
 */
+ (NSString *) getSystemDateWithFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    return time;
}



@end
