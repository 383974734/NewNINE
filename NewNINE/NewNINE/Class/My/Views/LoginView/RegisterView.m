//
//  RegisterView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 注册veiw

#import "RegisterView.h"

@interface RegisterView ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *backView2;
@property (nonatomic, strong) UIView *backView3;

/** 性别背景*/
@property (nonatomic, strong) UIView *genderView;

/** 男*/
@property (nonatomic, strong) UIButton *manBtn;
/** 女*/
@property (nonatomic, strong) UIButton *womanBtn;

/** 账号控件*/
@property (nonatomic, strong) UITextField *telephoneNumber;
/** 验证码控件*/
@property (nonatomic, strong) UITextField *verificationNumber;
/** 密码控件*/
@property (nonatomic, strong) UITextField *password;
/** 用户名控件*/
@property (nonatomic, strong) UITextField *userName;

/** 确定按钮*/
@property (nonatomic, strong) UIButton *determineBtn;
/** 发送验证码按钮*/
@property (nonatomic, strong) UIButton *verificationBtn;
/** 协议图片控件*/
@property (nonatomic, strong) UIImageView *registerImage;
/** 我已阅读并同意*/
@property (nonatomic, strong) UILabel *titleLable;
/** 注册协议*/
@property (nonatomic, strong) UIButton *titleButton;
/** 注册协议线*/
@property (nonatomic, strong) UILabel *xxLabel;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation RegisterView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRegister) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.backView2];
    [self.backView2 addSubview:self.backView];

    [self.backView addSubview:self.backView3];
    [self.backView addSubview:self.genderView];
    [self.backView addSubview:self.telephoneNumber];
    [self.backView addSubview:self.verificationNumber];
    [self.backView addSubview:self.password];
    [self.backView addSubview:self.verificationBtn];
    [self.backView addSubview:self.userName];
    
    [self addSubview:self.determineBtn];
    [self addSubview:self.registerImage];
    [self addSubview:self.titleLable];
    [self addSubview:self.titleButton];
    [self addSubview:self.xxLabel];
    
    [self.genderView addSubview:self.manBtn];
    [self.genderView addSubview:self.womanBtn];
}

- (void)settingAutoLayout {
    [self.backView2 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView2 autoSetDimension:ALDimensionHeight toSize:183];
    
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 20, 0, 20) excludingEdge:ALEdgeBottom];
    [self.backView autoSetDimension:ALDimensionHeight toSize:183];
    
    [self.backView3 autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(46, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView3 autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.telephoneNumber autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [self.telephoneNumber autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.verificationNumber autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(46, 0, 0, 100) excludingEdge:ALEdgeBottom];
    [self.verificationNumber autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.password autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(92, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.password autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.userName autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 100) excludingEdge:ALEdgeTop];
    [self.userName autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.genderView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userName withOffset:0];
    [self.genderView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.userName];
    [self.genderView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.userName];
    [self.genderView autoSetDimension:ALDimensionWidth toSize:100];
    
    [self.determineBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backView2 withOffset:18];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.determineBtn autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.registerImage autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.determineBtn];
    [self.registerImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.determineBtn withOffset:20];
    [self.registerImage autoSetDimension:ALDimensionWidth toSize:20];
    [self.registerImage autoSetDimension:ALDimensionHeight toSize:20];
    
    [self.titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.registerImage];
    [self.titleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.registerImage withOffset:5];
    [self.titleLable autoSetDimension:ALDimensionWidth toSize:120];
    [self.titleLable autoSetDimension:ALDimensionHeight toSize:20];
    
    [self.titleButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.registerImage];
    [self.titleButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.titleLable withOffset:1];
    [self.titleButton autoSetDimension:ALDimensionWidth toSize:100];
    [self.titleButton autoSetDimension:ALDimensionHeight toSize:20];
    
    [self.xxLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.titleButton];
    [self.xxLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.titleLable withOffset:1];
    [self.xxLabel autoSetDimension:ALDimensionWidth toSize:100];
    [self.xxLabel autoSetDimension:ALDimensionHeight toSize:1];
    
    
    
    [self.verificationBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.telephoneNumber withOffset:11];
    [self.verificationBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.verificationBtn autoSetDimension:ALDimensionWidth toSize:100];
    [self.verificationBtn autoSetDimension:ALDimensionHeight toSize:25];
}

- (void)settingData {
    
}

-(void)changeRegister
{
    [self.determineBtn setEnabled:(self.telephoneNumber.text.length > 0 && self.password.text.length > 0 && self.verificationNumber.text.length > 0 && self.userName.text.length > 0)];
    
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
    NSString *genderStr = @"1";
    if (button.tag == 2) {
        genderStr = @"1";
        [_manBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [_womanBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
    if (button.tag == 3) {
        genderStr = @"2";
        [_manBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_womanBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        
    }
    if ([self.delegate respondsToSelector:@selector(registerView:buttonWithTag:telephoneNumber:verificationNumber:password:userName:gender:)]) {
        [self.delegate registerView:self buttonWithTag:button.tag telephoneNumber:self.telephoneNumber.text verificationNumber:self.verificationNumber.text password:self.password.text userName:self.userName.text gender:genderStr];
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
        _password.placeholder     = @"请输入6-16位数字和字母组合密码";
        _password.backgroundColor = [UIColor whiteColor];
        _password.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _password;
}

- (UITextField *) userName {
    if (!_userName) {
        _userName = [[UITextField alloc] initForAutoLayout];
        _userName.placeholder     = @"请输入用户昵称";
        _userName.backgroundColor = [UIColor whiteColor];
        _userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _userName;
}

- (UIButton *) determineBtn {
    if (!_determineBtn) {
        _determineBtn                        = [[UIButton alloc] initForAutoLayout];
        _determineBtn.tag                    = 0;
        _determineBtn.alpha                  = 0.3f;
        _determineBtn.backgroundColor        = [UIColor redColor];
        _determineBtn.userInteractionEnabled = NO;
        [_determineBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        [_determineBtn setTitle:@"注册" forState:UIControlStateNormal];
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
        _verificationBtn.titleLabel.font   = SWP_SYSTEM_FONT_SIZE(13);
        [_verificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_verificationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_verificationBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verificationBtn;
}

- (UIButton *) manBtn {
    if (!_manBtn) {
        _manBtn     = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
        _manBtn.tag = 2;
        [_manBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_manBtn setTitle:@"男" forState:UIControlStateNormal];
        [_manBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _manBtn;
}

- (UIButton *) womanBtn {
    if (!_womanBtn) {
        _womanBtn     = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 50, 45)];
        _womanBtn.tag = 3;
        [_womanBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [_womanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_womanBtn setTitle:@"女" forState:UIControlStateNormal];
        [_womanBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _womanBtn;
}

- (UIImageView *) registerImage {
    if (!_registerImage) {
        _registerImage = [[UIImageView alloc] initForAutoLayout];
        _registerImage.image = [UIImage imageNamed:@"注册协议icon"];
    }
    return _registerImage;
}

- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.text = @"我已阅读并同意";
    }
    return _titleLable;
}

- (UIButton *) titleButton {
    if (!_titleButton) {
        _titleButton        = [[UIButton alloc] initForAutoLayout];
        _titleButton.tag    = 4;
        _titleButton.titleLabel.font = SWP_SYSTEM_FONT_SIZE(16);
        [_titleButton setTitle:@"《注册协议》" forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _titleButton;
}

- (UILabel *) xxLabel {
    if (!_xxLabel) {
        _xxLabel = [[UILabel alloc] initForAutoLayout];
        _xxLabel.backgroundColor = [UIColor redColor];
    }
    return _xxLabel;
}

@end
