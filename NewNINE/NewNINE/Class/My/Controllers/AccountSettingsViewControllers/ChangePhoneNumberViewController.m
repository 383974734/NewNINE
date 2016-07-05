//
//  ChangePhoneNumberViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ChangePhoneNumberViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface ChangePhoneNumberViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *backView3;

/** 性别背景*/
@property (nonatomic, strong) UIView        *genderView;
/** 当前绑定手机号文字*/
@property (nonatomic, strong) UILabel       *nowNmae;
/** 当前绑定手机号*/
@property (nonatomic, strong) UILabel       *nowTelephoneNumber;
/** 请输入新手机号码控件*/
@property (nonatomic, strong) UITextField   *newmobile;
/** 请输入短信验证码控件*/
@property (nonatomic, strong) UITextField   *authcode;
/** 请输入登录密码控件*/
@property (nonatomic, strong) UITextField   *passwd;

/** 确定按钮*/
@property (nonatomic, strong) UIButton      *determineBtn;
/** 发送验证码按钮*/
@property (nonatomic, strong) UIButton      *verificationBtn;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation ChangePhoneNumberViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRegister) name:UITextFieldTextDidChangeNotification object:nil];
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
    [self setNavWithLeftBarButton:NO title:@"更换手机号"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.backView2];
    [self.view addSubview:self.determineBtn];
    [self.backView2 addSubview:self.backView];
    
    [self.backView addSubview:self.backView3];
    [self.backView addSubview:self.genderView];
    [self.backView addSubview:self.nowTelephoneNumber];
    [self.backView addSubview:self.nowNmae];
    [self.backView addSubview:self.newmobile];
    [self.backView addSubview:self.authcode];
    [self.backView addSubview:self.verificationBtn];
    [self.backView addSubview:self.passwd];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.backView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView2 autoSetDimension:ALDimensionHeight toSize:183];
    
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 20, 0, 20) excludingEdge:ALEdgeBottom];
    [self.backView autoSetDimension:ALDimensionHeight toSize:183];
    
    [self.backView3 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(46, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView3 autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.nowTelephoneNumber autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH - 150, 0, 0) excludingEdge:ALEdgeBottom];
    [self.nowTelephoneNumber autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.nowNmae autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 110) excludingEdge:ALEdgeBottom];
    [self.nowNmae autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.newmobile autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(46, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.newmobile autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.authcode autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(92, 0, 0, 100) excludingEdge:ALEdgeBottom];
    [self.authcode autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.passwd autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.passwd autoSetDimension:ALDimensionHeight toSize:45];

    [self.determineBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backView2 withOffset:18];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.determineBtn autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.verificationBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.newmobile withOffset:11];
    [self.verificationBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.verificationBtn autoSetDimension:ALDimensionWidth toSize:100];
    [self.verificationBtn autoSetDimension:ALDimensionHeight toSize:25];
    
    [self.genderView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.authcode withOffset:0];
    [self.genderView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.authcode];
    [self.genderView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.authcode];
    [self.genderView autoSetDimension:ALDimensionWidth toSize:100];
}



#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    if (button.tag == 0) {
        [self getEditMobileWithData:self.newmobile.text authcode:self.authcode.text passwd:self.passwd.text];
    }
    else {
       [self getAuthcodeWithData];
    }
    
}

#pragma mark - 接口数据
//获取验证码
- (void) getAuthcodeWithData{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"login/authcode"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , GetUserDefault(userUid)],//账号
                       [NSString stringWithFormat:@"type,%@"    , @"2"],
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

//更改手机号接口
- (void) getEditMobileWithData:(NSString *)newmobile authcode:(NSString *)authcode passwd:(NSString *)passwd{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/editMobile"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"    , GetUserDefault(userUid)],//账号
                       [NSString stringWithFormat:@"newmobile,%@" , newmobile],
                       [NSString stringWithFormat:@"authcode,%@"  , authcode],
                       [NSString stringWithFormat:@"passwd,%@"    , passwd],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([[resultObject objectForKey:@"isSuccess"] boolValue]) {
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [SVProgressHUD showInfoWithStatus:[[resultObject objectForKey:@"errors"] firstObject]];
            }
        }
        
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/editMobile数据错误%@", error);
    }];
}

-(void)changeRegister
{
    [self.determineBtn setEnabled:(self.newmobile.text.length > 0 && self.authcode.text.length > 0 && self.passwd.text.length > 0)];
    
    if (self.determineBtn.enabled)
    {
        self.determineBtn.alpha = 1.0f;
        self.determineBtn.userInteractionEnabled = YES;
    }
    else
    {
        self.determineBtn.alpha = 0.3f;
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

- (UIView *) backView3 {
    if (!_backView3) {
        _backView3 = [[UIView alloc] initForAutoLayout];
        _backView3.backgroundColor = [UIColor whiteColor];
    }
    return _backView3;
}

- (UIView *) genderView {
    if (!_genderView) {
        _genderView = [[UIView alloc] initForAutoLayout];
        _genderView.backgroundColor = [UIColor whiteColor];
    }
    return _genderView;
}

- (UILabel *) nowNmae {
    if (!_nowNmae) {
        _nowNmae = [[UILabel alloc] initForAutoLayout];
        _nowNmae.text = @"当前绑定手机号码";
        _nowNmae.backgroundColor = [UIColor whiteColor];
    }
    return _nowNmae;
}

- (UILabel *) nowTelephoneNumber {
    if (!_nowTelephoneNumber) {
        _nowTelephoneNumber                 = [[UILabel alloc] initForAutoLayout];
        _nowTelephoneNumber.textAlignment   = NSTextAlignmentRight;
        _nowTelephoneNumber.textColor       = Color(154, 154, 154, 1);
        _nowTelephoneNumber.backgroundColor = [UIColor whiteColor];
        _nowTelephoneNumber.font             = SWP_SYSTEM_FONT_SIZE(14);
    }
    return _nowTelephoneNumber;
}

- (UITextField *) newmobile {
    if (!_newmobile) {
        _newmobile = [[UITextField alloc] initForAutoLayout];
        _newmobile.placeholder     = @"请输入新手机号码";
        _newmobile.backgroundColor = [UIColor whiteColor];
        _newmobile.keyboardType    = UIKeyboardTypeNumberPad;
        _newmobile.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _newmobile;
}

- (UITextField *) authcode {
    if (!_authcode) {
        _authcode = [[UITextField alloc] initForAutoLayout];
        _authcode.placeholder     = @"请输入短信验证码";
        _authcode.backgroundColor = [UIColor whiteColor];
        _authcode.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _authcode;
}

- (UITextField *) passwd {
    if (!_passwd) {
        _passwd = [[UITextField alloc] initForAutoLayout];
        _passwd.placeholder     = @"请输入登录密码";
        _passwd.backgroundColor = [UIColor whiteColor];
        _passwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _passwd;
}

- (UIButton *) determineBtn {
    if (!_determineBtn) {
        _determineBtn                        = [[UIButton alloc] initForAutoLayout];
        _determineBtn.tag                    = 0;
        _determineBtn.alpha                  = 0.3f;
        _determineBtn.backgroundColor        = [UIColor redColor];
        _determineBtn.userInteractionEnabled = NO;
        [_determineBtn.layer setCornerRadius:5.0];
        [_determineBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        [_determineBtn setTitle:@"确认更改" forState:UIControlStateNormal];
        [_determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    return _determineBtn;
}

- (UIButton *) verificationBtn {
    if (!_verificationBtn) {
        _verificationBtn                   = [[UIButton alloc] initForAutoLayout];
        _verificationBtn.tag               = 1;
        _verificationBtn.layer.borderWidth = 0.5;
        _verificationBtn.layer.borderColor = [UIColor redColor].CGColor;
        _verificationBtn.titleLabel.font   = SWP_SYSTEM_FONT_SIZE(15);
        [_verificationBtn.layer setCornerRadius:5.0];
        [_verificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verificationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_verificationBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verificationBtn;
}

- (void) setTetNumber:(NSString *)tetNumber {
    _tetNumber = tetNumber;
    self.nowTelephoneNumber.text = _tetNumber;
}

@end
