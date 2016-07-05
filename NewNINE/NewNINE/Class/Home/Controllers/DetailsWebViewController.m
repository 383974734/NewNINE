//
//  DetailsWebViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  web-----------> web控制器

#import "DetailsWebViewController.h"
// ---------------------- 框架工具类 ----------------------
#import "UINavigationController+FDFullscreenPopGesture.h"
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface DetailsWebViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------

@property (nonatomic, strong) UIWebView *webView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation DetailsWebViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fd_interactivePopDisabled = YES;
    // Do any additional setup after loading the view.
    [self initUI];
    
    
}

/**
 *  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  将要加载出视图 调用
 *
 *  @param animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
}

/**
 *  视图即将消失 调用
 *
 *  @param animated
 */
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
}

/**
 *  视图已经消失 调用
 *
 *  @param animated
 */
- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    
}


/**
 *  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@" selfViewController Destroy ");
}

#pragma mark - Init Data Method
/**
 *  数据初始化
 */
- (void) initData {
    
}

#pragma mark - Setting UI Methods
/**
 *  初始化UI控件
 */
- (void) initUI {
    
    [self settingNav];
    [self addUI];
    [self settingUIAutoLayout];
    
}

/**
 *  设置导航控制器
 */
- (void) settingNav {
    if (self.titleStr.length > 0) {
        [self setNavWithLeftBarButton:NO title:self.titleStr];
    }else {
        [self setNavWithLeftBarButton:NO title:@"详情"];
    }
    
}

- (void)didView:(UIButton *)btn {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.webView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.webView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(67, 0, 0, 0)];
}


#pragma mark   -  所有控件懒加载
- (UIWebView *) webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initForAutoLayout];
        _webView.backgroundColor  = [UIColor whiteColor];
    }
    return _webView;
}


- (void) setStrUrl:(NSString *)strUrl {
    _strUrl = strUrl;
    [MainCommonMethod webViewUpLoadUrl:self.webView withString:_strUrl];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
