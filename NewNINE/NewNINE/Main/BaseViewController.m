//
//  BaseViewController.m
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "BaseViewController.h"

// ---------------------- 框架工具类 ----------------------
#import "UINavigationBar+BackgroundColor.h"
#import<CommonCrypto/CommonDigest.h>

// ---------------------- 框架工具类 ----------------------

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self settingBaseViewControllerProperty];
    // Do any additional setup after loading the view.
//    [self.rdv_tabBarController setTabBarHidden:YES];  //隐藏tabBar
//    self.view.backgroundColor = Color(248, 248, 248, 1);
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor    = SWPColor(248, 248, 248, 1);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Do any additional setup after loading the view.
    [SVProgressHUD dismiss];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    self.view.backgroundColor = [UIColor whiteColor];

}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setting BaseViewController Property
/**
 *  设置 BaseViewController 自身的属性
 */
- (void) settingBaseViewControllerProperty {
    
    self.edgesForExtendedLayout           = UIRectEdgeNone;
    self.view.backgroundColor             = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    // 导航控制器的颜色
    [self.navigationController.navigationBar swp_SetBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBar64"]]];
}


#pragma mark - Setting NavigationBar Title And TitleFontSize

/**
 *  设置 导航控制器 显示 文字 颜色 字体 小大
 *
 *  @param title        标题名称
 *  @param textColot    文字 颜色 (nil 默认 显示黑色)
 *  @param fontSize     文字大小
 */
- (void)settingNavigationBarTitle:(NSString *)title textColor:(UIColor *)textColot titleFontSize:(CGFloat)fontSize {

    //自定义标题
    UILabel* titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.font               = [UIFont systemFontOfSize:fontSize];
    titleLabel.backgroundColor    = nil;
    //设置Label背景透明
    titleLabel.textColor          = textColot == nil ? [UIColor blackColor] : textColot;
    //设置文本颜色
    titleLabel.textAlignment      = NSTextAlignmentCenter;
    titleLabel.opaque             = NO;
    titleLabel.text               = title;
    //设置标题
    self.navigationItem.titleView = titleLabel;
}

#pragma mark - Setting Refresshing
/**
 *  设置tableView 刷新组件
 *
 *  @param tableView    需要设置tableView
 *  @param target       刷新组件的控制器
 *  @param headerAction 头部刷新方法
 *  @param footerAction 尾部刷新方法
 */
- (void) settingTableViewRefreshing:(UITableView *)tableView target:(id)target headerAction:(SEL)headerAction footerAction:(SEL)footerAction  {
    
    // 头部刷新控件
    tableView.mj_header = [self settingRefreshHeader:target footerAction:headerAction];
//    // 设置 为不刷新控件
    tableView.mj_footer = [self settingRefreshFooter:target footerAction:footerAction];
    
    
}

#pragma mark - Setting Refreshing
/**
 *  设置tableView 刷新组件
 *
 *  @param tableView    需要设置tableView
 *  @param target       刷新组件的控制器
 *  @param headerAction 头部刷新方法
 */
- (void) settingTableViewRefreshing:(UITableView *)tableView target:(id)target headerAction:(SEL)headerAction{
    
    // 头部刷新控件
    tableView.mj_header = [self settingRefreshHeader:target footerAction:headerAction];
    
    
}


#pragma mark - Setting NavigationBar Title And TitleFontSize
/**
 *  设置 导航控制器 title 文字
 *
 *  @param navTitle 标题名称
 *  @param navFont  文字大小
 */
- (void)setNavBarTitle:(NSString *)navTitle withFont:(CGFloat)navFont {
    
    //自定义标题
    UILabel* titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.font               = [UIFont systemFontOfSize:navFont];
    titleLabel.backgroundColor    = nil;
    //设置Label背景透明
    titleLabel.textColor          = [UIColor whiteColor];
    //设置文本颜色
    titleLabel.textAlignment      = NSTextAlignmentCenter;
    titleLabel.opaque             = NO;
    titleLabel.text               = navTitle;
    //设置标题
    self.navigationItem.titleView = titleLabel;
}




/**
 *  设置collectionView 刷新组件
 *
 *  @param collectionView    需要设置tableView
 *  @param target            刷新组件的控制器
 *  @param headerAction      头部刷新方法
 *  @param footerAction      尾部刷新方法
 */
- (void) settingCollectionViewRefreshing:(UICollectionView *)collectionView target:(id)target headerAction:(SEL)headerAction footerAction:(SEL)footerAction  {
    // 头部刷新控件
    collectionView.mj_header = [self settingRefreshHeader:target footerAction:headerAction];
//    // 设置 为不刷新控件
    collectionView.mj_footer = [self settingRefreshFooter:target footerAction:footerAction];
}



/**
 *  设置 控件头部刷新 属性
 *
 *  @param  target       刷新组件的控制器
 *  @param  headerAction 头部刷新方法
 *
 *  @return header
 */
- (MJRefreshNormalHeader *) settingRefreshHeader:(id)target footerAction:(SEL)headerAction {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
    [header setTitle:headerRereshingDataTitle forState:MJRefreshStateRefreshing];
    return header;
}

/**
 *  设置 控件尾部刷新 属性
 *
 *  @param  target         刷新组件的控制器
 *  @param  footerAction   头部刷新方法
 *
 *  @return footer
 */
- (MJRefreshAutoNormalFooter *) settingRefreshFooter:(id)target footerAction:(SEL)footerAction {
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    footer.automaticallyRefresh       = automaticallyRefresh;
    footer.automaticallyHidden        = NO;
    [footer setTitle:footerRereshingDataTitle forState:MJRefreshStateRefreshing];
    [footer setTitle:notHaveDataTitle         forState:MJRefreshStateNoMoreData];
    
    return footer;
}

/**
 *  设置导航控制器
 *
 *  @param leftBarButton NO 显示左侧返回按钮   YES 隐藏左侧返回按钮
 *  @param title         导航显示文字
 */
- (void)setNavWithLeftBarButton:(BOOL)leftBarButton title:(NSString *)title{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(64, 0, SCREEN_WIDTH - 128, 44)];
    lable.text = title;
    lable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lable];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 24, 24)];
    [button setImage:[UIImage imageNamed:@"nav-返回"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = leftBarButton;
    [view addSubview:button];
    [self.view addSubview:view];
}

- (void)didView:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) messageWithOK:(NSString *)title {
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alerView show];
}

//NSString转NSDate
- (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
//    NSString *dateString = @"2015-06-26 08:08:08";
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

/**
 *  加密
 *
 *  @param content 预加密字符串
 *
 *  @return 加密后字符串
 */
- (NSString*) sha256:(NSString *)content
{
    const char *cstr = [content cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:content.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
