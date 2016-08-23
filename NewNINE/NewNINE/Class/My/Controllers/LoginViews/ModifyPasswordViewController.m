//
//  ModifyPasswordViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 修改密码控制器

#import "ModifyPasswordViewController.h"


// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface ModifyPasswordViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *backView3;
/** 账号控件*/
@property (nonatomic, strong) UITextField *telephoneNumber;
/** 验证码控件*/
@property (nonatomic, strong) UITextField *verificationNumber;
/** 密码控件*/
@property (nonatomic, strong) UITextField *password;

/** 确定按钮*/
@property (nonatomic, strong) UIButton *determineBtn;
/** 发送验证码按钮*/
@property (nonatomic, strong) UIButton *verificationBtn;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation ModifyPasswordViewController


#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeModifyPassword) name:UITextFieldTextDidChangeNotification object:nil];
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
    [self setNavWithLeftBarButton:NO title:@"忘记登录密码"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.backView2];
    [self.backView2 addSubview:self.backView];
    [self.backView addSubview:self.backView3];
    [self.backView addSubview:self.telephoneNumber];
    [self.backView addSubview:self.verificationNumber];
    [self.backView addSubview:self.password];
    [self.backView addSubview:self.verificationBtn];
    
    [self.view addSubview:self.determineBtn];

}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.backView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(76, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView2 autoSetDimension:ALDimensionHeight toSize:137];
    
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 20, 0, 20) excludingEdge:ALEdgeBottom];
    [self.backView autoSetDimension:ALDimensionHeight toSize:137];
    
    [self.backView3 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(46, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView3 autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.telephoneNumber autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.telephoneNumber autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.verificationNumber autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(46, 0, 0, 100) excludingEdge:ALEdgeBottom];
    [self.verificationNumber autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.password autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.password autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.determineBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backView withOffset:18];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.determineBtn autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.verificationBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.telephoneNumber withOffset:11];
    [self.verificationBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.verificationBtn autoSetDimension:ALDimensionWidth toSize:100];
    [self.verificationBtn autoSetDimension:ALDimensionHeight toSize:25];
}

-(void)changeModifyPassword
{
    [self.determineBtn setEnabled:(self.telephoneNumber.text.length > 0 && self.password.text.length > 0 && self.verificationNumber.text.length > 0)];
    
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

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    NSLog(@"%@", button);
    if (button.tag == 0) {
        NSLog(@"确定修改");
    }
    if (button.tag == 1) {
        NSLog(@"发送验证码");
        
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

- (UITextField *) telephoneNumber {
    if (!_telephoneNumber) {
        _telephoneNumber = [[UITextField alloc] initForAutoLayout];
        _telephoneNumber.placeholder     = @"请输入注册手机号码";
        _telephoneNumber.backgroundColor = [UIColor whiteColor];
        _telephoneNumber.keyboardType    = UIKeyboardTypeNumberPad;
        _telephoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _telephoneNumber;
}

- (UITextField *) verificationNumber {
    if (!_verificationNumber) {
        _verificationNumber = [[UITextField alloc] initForAutoLayout];
        _verificationNumber.placeholder     = @"请输入短信验证码";
        _verificationNumber.backgroundColor = [UIColor whiteColor];
        _verificationNumber.keyboardType    = UIKeyboardTypeNumberPad;
        _verificationNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _verificationNumber;
}

- (UITextField *) password {
    if (!_password) {
        _password = [[UITextField alloc] initForAutoLayout];
        _password.placeholder     = @"请输入6-16位新登录密码";
        _password.backgroundColor = [UIColor whiteColor];
        _password.clearButtonMode = UITextFieldViewModeWhileEditing;
        _password.secureTextEntry = YES;
    }
    return _password;
}

- (UIButton *) determineBtn {
    if (!_determineBtn) {
        _determineBtn                        = [[UIButton alloc] initForAutoLayout];
        _determineBtn.tag                    = 0;
        _determineBtn.alpha                  = 0.3f;
        _determineBtn.userInteractionEnabled = NO;
        _determineBtn.backgroundColor        = [UIColor redColor];
        [_determineBtn setTitle:@"确定修改" forState:UIControlStateNormal];
        [_determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.determineBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _determineBtn;
}

- (UIButton *) verificationBtn {
    if (!_verificationBtn) {
        _verificationBtn                   = [[UIButton alloc] initForAutoLayout];
        _verificationBtn.tag               = 1;
        _verificationBtn.layer.borderWidth = 0.5;
        _verificationBtn.layer.borderColor = [UIColor redColor].CGColor;
        [_verificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verificationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_verificationBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verificationBtn;
}

@end
