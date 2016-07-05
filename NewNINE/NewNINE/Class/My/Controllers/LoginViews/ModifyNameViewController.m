//
//  ModifyNameViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 修改名字控制器

#import "ModifyNameViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "UserModel.h"
// ---------------------- model      ----------------------

@interface ModifyNameViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UIView *backView;
/** 输入用户昵称*/
@property (nonatomic, strong) UITextField *nameTextField;
/** 确定*/
@property (nonatomic, strong) UIButton *determineBtn;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation ModifyNameViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
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
    UserModel *user = [UserModel shareInstance];
    self.nameTextField.text = user.userName;
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
    
//    [self settingNavigationBarTitle:@"模板" textColor:nil titleFontSize:NAVIGATION_TITLE_FONT_SIZE];
    [self setNavWithLeftBarButton:NO title:@"修改昵称"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.nameTextField];
    [self.view addSubview:self.determineBtn];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.backView autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.nameTextField autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
    
    [self.determineBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameTextField withOffset:18];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.determineBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.determineBtn autoSetDimension:ALDimensionHeight toSize:45];
}

#pragma mark - 接口数据
//修改昵称
- (void) getEditUserNameWithData:(NSString *)username {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/editUserName"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],//账号
                       [NSString stringWithFormat:@"username,%@", username],
                       ];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD showSuccessWithStatus:@"修改成功"];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([[resultObject objectForKey:@"isSuccess"] integerValue] == 1) {
                [self getUserinfoWithData];
            }
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/editUserName数据错误%@", error);
    }];
}

//个人接口
- (void) getUserinfoWithData{
    if (!([GetUserDefault(userUid) length] > 0)) {
        return;
    }
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getUserinfo"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],//账号
                       ];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            SetUserDefault(resultObject, @"getUserinfo");
            [self userDataDispose:resultObject];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"login/login数据错误%@", error);
    }];
}

/**
 *  个人信息 保存数据
 *
 *  @param dict
 */
- (void) userDataDispose:(NSDictionary *)dict {
    // 保存用户数据
    [UserModel saveUser:[UserModel userWithDict:dict]];
    
}



#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    if (self.nameTextField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"昵称不能为空"];
        return;
    }
    if (self.nameTextField.text.length > 9) {
        [SVProgressHUD showInfoWithStatus:@"昵称格式输入错误"];
        return;
    }
    [self getEditUserNameWithData:self.nameTextField.text];
}

#pragma mark   -  所有控件懒加载

- (UIView *) backView {
    if (!_backView) {
        _backView                 = [[UIView alloc] initForAutoLayout];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UITextField *) nameTextField {
    if (!_nameTextField) {
        _nameTextField                  = [[UITextField alloc] initForAutoLayout];
        _nameTextField.placeholder      = @"请输入昵称";
        _nameTextField.clearButtonMode  = UITextFieldViewModeWhileEditing;
    }
    return _nameTextField;
}

- (UIButton *) determineBtn {
    if (!_determineBtn) {
        _determineBtn                   = [[UIButton alloc] initForAutoLayout];
        _determineBtn.backgroundColor   = [UIColor redColor];
        [_determineBtn setTitle:@"确认修改" forState:UIControlStateNormal];
        [_determineBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _determineBtn;
}


@end
