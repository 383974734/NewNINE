//
//  ChangePasswordViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ChangePasswordViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface ChangePasswordViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backView2;
/** 原密码控件*/
@property (nonatomic, strong) UITextField *oldPassword;
/** 新密码控件*/
@property (nonatomic, strong) UITextField *newPassword;

/** 登录确定按钮*/
@property (nonatomic, strong) UIButton    *determine;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation ChangePasswordViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLogin) name:UITextFieldTextDidChangeNotification object:nil];
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
    
}

/**
 *  已经加载出视图 调用
 *
 *  @param animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //    [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
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
    [self setNavWithLeftBarButton:NO title:@"修改密码"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.backView2];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.oldPassword];
    [self.backView addSubview:self.newPassword];
    
    [self.view addSubview:self.determine];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.backView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView2 autoSetDimension:ALDimensionHeight toSize:91];
    
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 20, 0, 20) excludingEdge:ALEdgeBottom];
    [self.backView autoSetDimension:ALDimensionHeight toSize:91];
    
    [self.oldPassword autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.oldPassword autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.newPassword autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.newPassword autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.determine autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backView withOffset:18];
    [self.determine autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.determine autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.determine autoSetDimension:ALDimensionHeight toSize:40];
    
}



#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    [self getEditPasswdWithData:self.oldPassword.text newpasswd:self.newPassword.text];
}

#pragma mark - 接口数据
//获取验证码
- (void) getEditPasswdWithData:(NSString *)passwd newpasswd:(NSString *)newpasswd{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/editPasswd"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"      , GetUserDefault(userUid)],//账号
                       [NSString stringWithFormat:@"passwd,%@"      , passwd],
                       [NSString stringWithFormat:@"newpasswd,%@"   , newpasswd],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([[resultObject objectForKey:@"isSuccess"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"修改成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [SVProgressHUD showInfoWithStatus:[[resultObject objectForKey:@"errors"] firstObject]];
            }
        }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/editPasswd数据错误%@", error);
    }];
}


-(void)changeLogin
{
    [self.determine setEnabled:(self.oldPassword.text.length > 0 && self.newPassword.text.length > 0)];
    
    if (self.determine.enabled)
    {
        self.determine.alpha = 1.0f;
        _determine.userInteractionEnabled = YES;
    }
    else
    {
        self.determine.alpha = 0.3f;
    }
}

#pragma mark   -  所有控件懒加载

- (UIView *) backView {
    if (!_backView) {
        _backView = [[UIView alloc] initForAutoLayout];
        _backView.backgroundColor = Color(248, 248, 248, 1);
    }
    return _backView;
}

- (UIView *) backView2 {
    if (!_backView2) {
        _backView2 = [[UIView alloc] initForAutoLayout];
        _backView2.backgroundColor = [UIColor whiteColor];
    }
    return _backView2;
}

- (UITextField *) oldPassword {
    if (!_oldPassword) {
        _oldPassword = [[UITextField alloc] initForAutoLayout];
        _oldPassword.placeholder     = @"请输入原密码";
        _oldPassword.backgroundColor = [UIColor whiteColor];
//        _oldPassword.keyboardType    = UIKeyboardTypeNumberPad;
        _oldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _oldPassword;
}

- (UITextField *) newPassword {
    if (!_newPassword) {
        _newPassword = [[UITextField alloc] initForAutoLayout];
        _newPassword.placeholder     = @"请输入新密码";
        _newPassword.backgroundColor = [UIColor whiteColor];
        _newPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
        _newPassword.secureTextEntry = YES;
    }
    return _newPassword;
}

- (UIButton *) determine {
    if (!_determine) {
        _determine                          = [[UIButton alloc] initForAutoLayout];
        _determine.tag                      = 0;
        _determine.alpha                    = 0.3f;
        _determine.backgroundColor          = [UIColor redColor];
        _determine.userInteractionEnabled   = NO;
        [_determine.layer setCornerRadius:5.0];
        [_determine setTitle:@"确认修改" forState:UIControlStateNormal];
        [_determine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.determine addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _determine;
}



@end
