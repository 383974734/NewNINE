//
//  LoginViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "LoginViewController.h"
// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "ModifyPasswordViewController.h"
#import "DetailsWebViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "LoginView.h"
#import "RegisterView.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface LoginViewController ()<LoginViewDelegate, RegisterViewDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 导航视图*/
@property (nonatomic, strong) UIView    *navView;
/** 返回按钮*/
@property (nonatomic, strong) UIButton  *returnButton;
/** 登录按钮*/
@property (nonatomic, strong) UIButton  *loginButton;
/** 注册按钮*/
@property (nonatomic, strong) UIButton  *registerButton;

/** 登录注册按钮线面的线*/
@property (nonatomic, strong) UILabel   *xxLable;

/** 注册视图*/
@property (nonatomic, strong) RegisterView  *registerView;
/** 登录视图*/
@property (nonatomic, strong) LoginView     *loginView;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation LoginViewController


#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
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
 *  已经加载出视图 调用
 *
 *  @param animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/**
 *  视图即将消失 调用
 *
 *  @param animated
 */
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.hidden = NO;
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
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.returnButton];
    [self.navView addSubview:self.loginButton];
    [self.navView addSubview:self.registerButton];
    [self.navView addSubview:self.xxLable];
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.registerView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.navView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(22, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.navView autoSetDimension:ALDimensionHeight toSize:42];
    
    [self.returnButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [self.returnButton autoSetDimension:ALDimensionWidth toSize:60];
    
    [self.loginButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH / 2) excludingEdge:ALEdgeLeft];
    [self.loginButton autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.registerButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH / 2, 0, 0) excludingEdge:ALEdgeRight];
    [self.registerButton autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.loginView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0)];
    
    [self.registerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0)];
    
}

#pragma mark - 接口数据
//用户登录
- (void) getloginWithData:(NSString *)mobile passwd:(NSString *)passwd {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"login/login"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", mobile],//账号
                       [NSString stringWithFormat:@"passwd,%@", passwd],//密码
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([[resultObject objectForKey:@"isSuccess"] integerValue] == 1) {
                [SVProgressHUD showInfoWithStatus:@"登录成功"];
                SetUserDefault(mobile, userUid);
                SetUserDefault(mobile, UserMobile);
                SetUserDefault(passwd, UserPasswd);
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [SVProgressHUD showInfoWithStatus:[resultObject objectForKey:@"errors"][0]];
            }
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"login/login数据错误%@", error);
    }];
}

//获取验证码
- (void) getAuthcodeWithData:(NSString *)mobile type:(NSString *)type {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"login/authcode"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , mobile],//账号
                       [NSString stringWithFormat:@"type,%@"    , type],//验证码
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([[resultObject objectForKey:@"isSuccess"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"验证码已发送"];
            }else {
                [SVProgressHUD showInfoWithStatus:[[resultObject objectForKey:@"errors"] firstObject]];
            }
        }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"login/login数据错误%@", error);
    }];
}
//用户注册
- (void) getRegisterWithData:(NSString *)username sexy:(NSString *)sexy mobile:(NSString *)mobile authcode:(NSString *)authcode passwd:(NSString *)passwd {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"login/register"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"username,%@", username],//用户昵称
                       [NSString stringWithFormat:@"sexy,%@"    , sexy],//性别 1、男 2、女
                       [NSString stringWithFormat:@"mobile,%@"  , mobile],//手机号
                       [NSString stringWithFormat:@"authcode,%@", authcode],//验证码
                       [NSString stringWithFormat:@"passwd,%@"  , passwd],//密码
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([[resultObject objectForKey:@"isSuccess"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"注册成功"];
                SetUserDefault(mobile, userUid);
                SetUserDefault(mobile, UserMobile);
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [SVProgressHUD showInfoWithStatus:[[resultObject objectForKey:@"errors"] firstObject]];
            }
        }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"login/login数据错误%@", error);
    }];
}
#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    if (button.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (button.tag == 1002) {
        [self.loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.xxLable.frame              = CGRectMake(SCREEN_WIDTH / 2 - 55, 38, 40, 1);
        self.loginView.hidden           = NO;
        self.registerView.hidden        = YES;
    }
    if (button.tag == 1003) {
        [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.xxLable.frame              = CGRectMake(SCREEN_WIDTH / 2 + 15, 38, 40, 1);
        self.loginView.hidden           = YES;
        self.registerView.hidden        = NO;
    }
}

#pragma mark LoginViewDelegate 
/**
 *  登录页面代理事件
 *
 *  @param LoginView       LoginView
 *  @param tag             用来确定那个button
 *  @param telephoneNumber 电话号
 *  @param password        密码
 */
- (void)LoginView:(LoginView *)LoginView btnWithTag:(NSInteger)tag telephoneNumber:(NSString *)telephoneNumber password:(NSString *)password {
    if (tag == 0) {
        NSLog(@"登录");
        [self getloginWithData:telephoneNumber passwd:password];
    }
    if (tag == 1) {
        NSLog(@"跳忘记密码页");
        [self.navigationController pushViewController:[ModifyPasswordViewController alloc] animated:YES];
    }
}

#pragma mark RegisterViewDelegate
/**
 *  注册页面点击代理事件
 *
 *  @param registerView       RegisterView
 *  @param btn                用来确定那个button
 *  @param telephoneNumber    账号
 *  @param verificationNumber 验证码
 *  @param password           密码
 *  @param userName           昵称
 *  @param gender             性别
 */
- (void)registerView:(RegisterView *)registerView buttonWithTag:(NSInteger)btn telephoneNumber:(NSString *)telephoneNumber verificationNumber:(NSString *)verificationNumber password:(NSString *)password userName:(NSString *)userName gender:(NSString *)gender {
    if (btn == 0) {
        NSLog(@"确定修改");
        [self getRegisterWithData:userName sexy:gender mobile:telephoneNumber authcode:verificationNumber passwd:password];
    }
    if (btn == 1) {
        NSLog(@"发送验证码");
        [self getAuthcodeWithData:telephoneNumber type:@"1"];
    }
    if (btn == 4) {
        NSLog(@"注册协议");
        //http://img.mlmsalon.com/registration.pdf
        DetailsWebViewController *webViewController = [[DetailsWebViewController alloc] init];
        webViewController.strUrl = @"http://img.mlmsalon.com/registration.pdf";
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

#pragma mark   -  所有控件懒加载
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initForAutoLayout];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UIButton *) returnButton {
    if (!_returnButton) {
        _returnButton     = [[UIButton alloc] initForAutoLayout];
        _returnButton.tag = 1001;
        [_returnButton setImage:[UIImage imageNamed:@"nav-返回"] forState:UIControlStateNormal];
        [_returnButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}

- (UIButton *) loginButton {
    if (!_loginButton) {
        _loginButton     = [[UIButton alloc] initForAutoLayout];
        _loginButton.tag = 1002;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *) registerButton {
    if (!_registerButton) {
        _registerButton     = [[UIButton alloc] initForAutoLayout];
        _registerButton.tag = 1003;
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UILabel *) xxLable {
    if (!_xxLable) {
        _xxLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 55, 38, 40, 1)];
        _xxLable.backgroundColor = [UIColor redColor];
    }
    return _xxLable;
}

- (RegisterView *) registerView {
    if (!_registerView) {
        _registerView           = [[RegisterView alloc] initForAutoLayout];
        _registerView.hidden    = YES;
        _registerView.delegate  = self;
    }
    return _registerView;
}

- (LoginView *) loginView {
    if (!_loginView) {
        _loginView          = [[LoginView alloc] initForAutoLayout];
        _loginView.delegete = self;
    }
    return _loginView;
}

@end
