//
//  LoginView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 登录veiw

#import "LoginView.h"

@interface LoginView ()
#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backView2;
/** 账号控件*/
@property (nonatomic, strong) UITextField *telephoneNumber;
/** 密码控件*/
@property (nonatomic, strong) UITextField *password;

/** 登录确定按钮*/
@property (nonatomic, strong) UIButton *determineLogin;
/** 忘记密码按钮*/
@property (nonatomic, strong) UIButton *forgetPasswork;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation LoginView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLogin) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.backView2];
    [self addSubview:self.backView];
    [self.backView addSubview:self.telephoneNumber];
    [self.backView addSubview:self.password];
    
    [self addSubview:self.determineLogin];
    [self addSubview:self.forgetPasswork];
}

- (void)settingAutoLayout {
    [self.backView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.backView2 autoSetDimension:ALDimensionHeight toSize:91];
    
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 20, 0, 20) excludingEdge:ALEdgeBottom];
    [self.backView autoSetDimension:ALDimensionHeight toSize:91];
    
    [self.telephoneNumber autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.telephoneNumber autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.password autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.password autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.determineLogin autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backView withOffset:18];
    [self.determineLogin autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.determineLogin autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.determineLogin autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.forgetPasswork autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.determineLogin withOffset:15];
    [self.forgetPasswork autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.forgetPasswork autoSetDimension:ALDimensionWidth toSize:80];
    [self.forgetPasswork autoSetDimension:ALDimensionHeight toSize:20];
}

- (void)settingData {
    
}

- (void) didButton:(UIButton *)btn {

    if ([self.delegete respondsToSelector:@selector(LoginView:btnWithTag:telephoneNumber:password:)]) {
        [self.delegete LoginView:self btnWithTag:btn.tag telephoneNumber:self.telephoneNumber.text password:self.password.text];
    }
    
    
}

-(void)changeLogin
{
    [self.determineLogin setEnabled:(self.telephoneNumber.text.length > 0 && self.password.text.length > 0)];
    
    if (self.determineLogin.enabled)
    {
        self.determineLogin.alpha = 1.0f;
        self.determineLogin.userInteractionEnabled = YES;
    }
    else
    {
        self.determineLogin.alpha = 0.3f;
    }
}

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

- (UITextField *) telephoneNumber {
    if (!_telephoneNumber) {
        _telephoneNumber = [[UITextField alloc] initForAutoLayout];
        _telephoneNumber.placeholder     = @"请输入注册手机号";
        _telephoneNumber.backgroundColor = [UIColor whiteColor];
        _telephoneNumber.keyboardType    = UIKeyboardTypeNumberPad;
        _telephoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _telephoneNumber;
}

- (UITextField *) password {
    if (!_password) {
        _password = [[UITextField alloc] initForAutoLayout];
        _password.placeholder     = @"请输入登录密码";
        _password.backgroundColor = [UIColor whiteColor];
        _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _password;
}

- (UIButton *) determineLogin {
    if (!_determineLogin) {
        _determineLogin                         = [[UIButton alloc] initForAutoLayout];
        _determineLogin.tag                     = 0;
        _determineLogin.alpha                   = 0.3f;
        _determineLogin.backgroundColor         = [UIColor redColor];
        _determineLogin.userInteractionEnabled  = NO;
        [_determineLogin setTitle:@"确定" forState:UIControlStateNormal];
        [_determineLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_determineLogin addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _determineLogin;
}

- (UIButton *) forgetPasswork {
    if (!_forgetPasswork) {
        _forgetPasswork                 = [[UIButton alloc] initForAutoLayout];
        _forgetPasswork.tag             = 1;
        [_forgetPasswork setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPasswork setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forgetPasswork addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPasswork;
}

@end
