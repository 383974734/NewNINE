//
//  AccountSettingViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  ---------账号设置控制器

#import "AccountSettingViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "ModifyNameViewController.h"
#import "ChangePhoneNumberViewController.h"
#import "ChangePasswordViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "UserMessageOneableViewCell.h"
#import "UserMessageTwoTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "UserModel.h"  
// ---------------------- model      ----------------------

@interface AccountSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UITableView   *userMessageTableView;
@property (nonatomic, strong) UIButton      *exitButton;


/** 显示修改信息的名称*/
@property (nonatomic, strong) NSArray       *cellArray;

/** 显示用户信息数据源 */
@property (strong, nonatomic) NSArray     *userMessageArray;
/** 保存用户电话 */
@property (copy  , nonatomic) NSString    *userTel;
/** 保存用户性别 */
@property (copy  , nonatomic) NSString    *userSex;
/** 保存用户名称 */
@property (copy  , nonatomic) NSString    *userName;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation AccountSettingViewController

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
    [self.userMessageTableView reloadData];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [self initData];
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
    NSLog(@"%@", user);
    
    UserModel *oneUserData   = [[UserModel alloc] init];
    oneUserData.oneTitle     = @"头像";
    oneUserData.onejudge     = NO;
    oneUserData.twojudge     = YES;
    oneUserData.userIconPhotoUrl  = user.userIconPhotoUrl;
    
    
    UserModel *twoUserData   = [[UserModel alloc] init];
    twoUserData.oneTitle     = @"昵称";
    twoUserData.onejudge     = YES;
    twoUserData.twojudge     = NO;
    twoUserData.userName     = user.userName.length == 0 ? @"请编辑昵称" : user.userName;
    
    NSArray *oneArray        = @[oneUserData, twoUserData];
    
    UserModel *threeUserData = [[UserModel alloc] init];
    threeUserData.oneTitle   = @"联系电话";
    threeUserData.onejudge   = YES;
    threeUserData.twojudge   = NO;
    threeUserData.twoTitle = user.userMobile;
    
    
    UserModel *fourUserData  = [[UserModel alloc] init];
    fourUserData.oneTitle    = @"登录密码";
    fourUserData.onejudge    = YES;
    fourUserData.twojudge    = NO;
    fourUserData.twoTitle    = @"已设置";
    
    NSArray *twoArray        = @[threeUserData, fourUserData];
    
    self.cellArray           = @[oneArray, twoArray];
    [self.userMessageTableView reloadData];
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
    [self setNavWithLeftBarButton:NO title:@"账号设置"];
//    [self settingNavigationBarTitle:@"个人资料修改" textColor:nil titleFontSize:NAVIGATION_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.userMessageTableView];
    [self.view addSubview:self.exitButton];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.userMessageTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.userMessageTableView autoSetDimension:ALDimensionHeight toSize:200];
  
    [self.exitButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(274, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.exitButton autoSetDimension:ALDimensionHeight toSize:45];
}


#pragma mark UITableView delegete
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cellArray[section] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.cellArray[indexPath.section];
    if (indexPath.section == 0) {
        UserMessageOneableViewCell *cell = [UserMessageOneableViewCell userMessageOneCellWithTableView:tableView];
        cell.textLabel.font              = [UIFont systemFontOfSize:14];
        cell.userData                    = array[indexPath.row];
        return cell;
    }
    UserMessageTwoTableViewCell *cell = [UserMessageTwoTableViewCell userMessageTwoCellWithTableView:tableView];
    cell.twoUserData                  = array[indexPath.row];
    cell.textLabel.font              = [UIFont systemFontOfSize:14];
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark - UITableView Delegate Method
/**
 *  tableView 代理方法 点击每个cell (点击进入对应的控制器)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        }
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[ModifyNameViewController alloc] animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ChangePhoneNumberViewController *view = [[ChangePhoneNumberViewController alloc] init];
            view.tetNumber = GetUserDefault(userUid);
            [self.navigationController pushViewController:view animated:YES];
        }
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[ChangePasswordViewController alloc] animated:YES];
        }
    }
    
}

#pragma mark 点击事件
- (void) didButton:(UIButton *)btn {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否要退出登录?" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
}

#pragma mark - UIAlertView Delegate Method
/**
 *  UIAlertView 代理方法
 *
 *  @param alertView
 *  @param buttonIndex
 */
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self userExit];
        SetUserDefault(@"", @"getUserinfo");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 * 退出登录 用户数据清零
 */
- (void) userExit {
    SetUserDefault(@"", userUid);
    SetUserDefault(@"", UserMobile);
    // 清除数据模型
    [UserModel saveUser:[[UserModel alloc] init]];

}


#pragma mark - UIInitMethod
- (UITableView *)userMessageTableView {
    
    if (!_userMessageTableView) {
        _userMessageTableView                   = [[UITableView alloc] initForAutoLayout];
        [_userMessageTableView registerClass:[UserMessageOneableViewCell class] forCellReuseIdentifier:@"UserMessageOneableViewCell"];
        [_userMessageTableView registerClass:[UserMessageTwoTableViewCell class] forCellReuseIdentifier:@"UserMessageTwoTableViewCell"];
        _userMessageTableView.dataSource        = self;
        _userMessageTableView.delegate          = self;
        _userMessageTableView.rowHeight         = 43;
        _userMessageTableView.separatorStyle    = UITableViewCellSeparatorStyleNone;
        _userMessageTableView.separatorColor    = [UIColor grayColor];
//        [SwpCommonMethod hiddleExtendCellFromTableview:_userMessageTableView];
    }
    return _userMessageTableView;
}



/**
 *  懒加载控件
 *
 *  @return UIButton
 */
- (UIButton *) exitButton {
    if (!_exitButton) {
        _exitButton = [[UIButton alloc] initForAutoLayout];
        [_exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_exitButton setTitleColor:Color(64, 64, 64, 1) forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        _exitButton.backgroundColor = [UIColor whiteColor];
    }
    return _exitButton;
}


@end
