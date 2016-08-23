//
//  MyViewController.m
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器

#import "MyViewController.h"

static NSString *cellHeadCellID = @"cellHeadCellID";
static NSString *cellContentCellID = @"cellContentCellID";

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "DetailsWebViewController.h"
#import "LoginViewController.h"
#import "ModifyNameViewController.h"
#import "CollectionViewController.h"
#import "IntegralViewController.h"
#import "DiscountViewController.h"
#import "OrderViewController.h"
#import "AccountSettingViewController.h"
#import "MyEvaluationViewController.h"
#import "StoreAddressViewController.h"
#import "MakeAppointmentViewController.h"
#import "IntegralPurchaseViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "MyHeadTableViewCell.h"
#import "MyContentTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "UserModel.h"
// ---------------------- model      ----------------------

@interface MyViewController ()<UITableViewDelegate, UITableViewDataSource, MyHeadTableViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImage *imageUser;
}

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------

@property (nonatomic, strong) UITableView *myTableView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@property (nonatomic, strong) NSArray *arrayImage;
@property (nonatomic, strong) NSArray *arrayLable;


@end

@implementation MyViewController

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

#pragma mark - 通知回调
-(void)cancelOrderCallBack:(NSNotification*)notify {
    [self.navigationController pushViewController:[MakeAppointmentViewController alloc] animated:YES];
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
    SetUserDefault(@"4", @"selectedIndex");
    [self getUserinfoWithData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelOrderCallBack:) name:@"cancelOrderCallBack" object:nil];
}

/**
 *  视图已经消失 调用
 *
 *  @param animated
 */
- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  已经加载出视图 调用
 *
 *  @param animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

/**
 *  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@" selfViewController Destroy ");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Init Data Method
/**
 *  数据初始化
 */
- (void) initData {
//    self.arrayImage = @[@[],@[@"限时抢购", @"积分购买",@"签到有奖"], @[@"我的推广", @"我的评价", @"账号设置"], @[@"门店地址", @"关于我们"]];
//    self.arrayLable = @[@[],@[@"限时抢购", @"积分购买", @"签到有奖"], @[@"合伙人", @"我的评价", @"账号设置"], @[@"门店地址", @"关于我们"]];
    self.arrayImage = @[@[],@[@"签到有奖"], @[@"我的推广", @"我的评价", @"账号设置"], @[@"门店地址", @"关于我们"]];
    self.arrayLable = @[@[],@[@"签到有奖"], @[@"合伙人", @"我的评价", @"账号设置"], @[@"门店地址", @"关于我们"]];
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
    self.navigationController.navigationBar.hidden = YES;
//    [self settingNavigationBarTitle:@"模板" textColor:nil titleFontSize:NAVIGATION_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.myTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.myTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-22, 0, 50, 0)];
}


#pragma mark - 接口数据
//个人接口
- (void) getUserinfoWithData{
    if (!([GetUserDefault(userUid) length] > 0)) {
        [self.myTableView reloadData];
        return;
    }
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getUserinfo"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],//账号
                       ];
//    [SVProgressHUD showWithStatus:HEADER_RERESHING_DATA_TITLE];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        [SVProgressHUD showInfoWithStatus:@"登录成功"];
//        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            SetUserDefault(resultObject, @"getUserinfo");
            [self userDataDispose:resultObject];
            [self.myTableView reloadData];
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"login/login数据错误%@", error);
    }];
}


//修改头像接口
- (void) getUploadAvatarWithData:(NSString *)avatar{
    if (!([GetUserDefault(userUid) length] > 0)) {
        [self.myTableView reloadData];
        return;
    }
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/uploadAvatar"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],//账号
                       [NSString stringWithFormat:@"avatar,%@", avatar],//头像
                       ];
    [SVProgressHUD showWithStatus:DATA_COMMITE];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            [self.myTableView reloadData];
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/uploadAvatar数据错误%@", error);
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

#pragma mark UITableView DataSource
/**
 *  tableView 数据源方法 返回tabvelView 分组个数
 *
 *  @param tableView
 *
 *  @return NSInteger
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayImage.count;
}

/**
 *  tableView 数据源方法  返回tableView 每个分组中cell的个数
 *
 *  @param tableView
 *  @param section
 *
 *  @return NSInteger
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.arrayImage[section] count];
}

/**
 *  tableView 数据源方法 返回每个cell显示的样式和数据
 *
 *  @param  tableView
 *  @param  indexPath
 *
 *  @return OrderTableViewCell
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        MyHeadTableViewCell *cell = [MyHeadTableViewCell myHeadCellWithTableView:tableView forCellReuseIdentifier:cellHeadCellID];
        cell.userDict  = GetUserDefault(@"getUserinfo");
        cell.delegate  = self;
        if (imageUser != nil) {
            cell.imageUser = imageUser;
        }
        
        return cell;
    }else {
    
        MyContentTableViewCell *cell = [MyContentTableViewCell myContentCellWithTableView:tableView forCellReuseIdentifier:cellContentCellID];
        cell.strImage = self.arrayImage[indexPath.section][indexPath.row];
        cell.strLable = self.arrayLable[indexPath.section][indexPath.row];
        return cell;
    }
}

/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!([GetUserDefault(userUid) length] > 0)){
        [self goToLogin];
    }else {
        NSString *sign = [self sha256:[NSString stringWithFormat:@"mobile=%@&key=3e9bb86c6980c3b79e5b936ce10b9b96",GetUserDefault(userUid)]];
        DetailsWebViewController *webView = [[DetailsWebViewController alloc] init];
        if (indexPath.section == 1) {
            switch (indexPath.row) {
//                case 0:
//                {
//                    NSLog(@"限时抢购");
//                }
//                    break;
//                case 1:
//                {
//                    NSLog(@"积分购买");
//                    IntegralPurchaseViewController *viewController = [[IntegralPurchaseViewController alloc] init];
//                    [self.navigationController pushViewController:viewController animated:YES];
//                }
//                    break;
                 case 0://case 2:
                {
                    webView.titleStr = @"签到";
                    webView.strUrl    = [NSString stringWithFormat:@"%@Activity/sign/mobile/%@/sign/%@",developmentURL,GetUserDefault(userUid),sign] ;
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        if (indexPath.section == 2) {
            switch (indexPath.row) {
                case 0:
                {
                    webView.strUrl = [NSString stringWithFormat:@"%@Partner/index/mobile/%@/sign/%@",developmentURL,GetUserDefault(userUid),sign] ;
                    [self.navigationController pushViewController:webView animated:YES];
                }
                    break;
                case 1:
                    //我的评价
                    [self.navigationController pushViewController:[MyEvaluationViewController alloc] animated:YES];
                    break;
                case 2:
                    //账号设置
                    [self.navigationController pushViewController:[AccountSettingViewController alloc] animated:YES];
                    break;
                    
                default:
                    break;
            }
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:[StoreAddressViewController alloc] animated:YES];
            }
            if (indexPath.row == 1) {
                webView.titleStr = @"关于我们";
                webView.strUrl   = [NSString stringWithFormat:@"%@Index/about", developmentURL];
                [self.navigationController pushViewController:webView animated:YES];
            }
        }
    }
}

/**
 *  tableView 代理方法 返回对应索引返回的row的高度
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return CGFloat
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 320 : 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 10;
}

#pragma mark - myHeadTableViewCell  代理  事件
/**
 *  点击不同button按钮的代理事件
 *
 *  @param myHeadTableViewCell MyHeadTableViewCell
 *  @param tag                 点击的那个button
 *  @param name                用来区分是哪个代理  (0 点击我的头像  全部订单   修改昵称  事件) (1 是 我的控制器 ---收藏 --积分 --优惠卷  代理) (2 是 我的控制器 ---未付款 --预约成功 --已完成 --退款  按钮  代理)
 */
- (void)myHeadTableViewCell:(MyHeadTableViewCell *)myHeadTableViewCell buttonWithTag:(NSInteger)tag name:(NSString *)name{
    if (name.integerValue == 0) {
        if (!([GetUserDefault(userUid) length] > 0)){
            [self goToLogin];
            return;
        }else {
            if (tag == 0) {
                NSLog(@"点击头像");
                [self showOkayCancelAlert];
            }
            if (tag == 1) {
                NSLog(@"我的美单 --- 查看全部订单");
                [self orderWithViewController:@"0"];//全部订单
            }
            if (tag == 2) {
                NSLog(@"修改昵称");
                [self.navigationController pushViewController:[ModifyNameViewController alloc] animated:YES];
            }
        }
    }
    if (name.integerValue == 1) {
        if (!([GetUserDefault(userUid) length] > 0)){
            [self goToLogin];
            return;
        }else {
            if (tag == 0) {
                NSLog(@"收藏");
                CollectionViewController *collectionView = [[CollectionViewController alloc] init];
                [self.navigationController pushViewController:collectionView animated:YES];
            }
            if (tag == 1) {
                NSLog(@"积分");
                IntegralViewController *integralView = [[IntegralViewController alloc] init];
                [self.navigationController pushViewController:integralView animated:YES];
            }
            if (tag == 2) {
                NSLog(@"优惠劵");
                DiscountViewController *discountView = [[DiscountViewController alloc] init];
                [self.navigationController pushViewController:discountView animated:YES];
            }
        }
        
    }//状态 空 或者 0 是全部 1未支付 2已支付 6订单完成 7 退款
    //状态 空是全部 1待付款 2预约成功 10订单完成 11 退款
    if (name.integerValue == 2) {
        if (!([GetUserDefault(userUid) length] > 0)){
            [self goToLogin];
            return;
        }else {
            if (tag == 0) {
                NSLog(@"未付款");
                [self orderWithViewController:@"1"];//未付款
            }
            if (tag == 1) {
                NSLog(@"预约成功");
                [self orderWithViewController:@"2"];//预约成功
            }
            if (tag == 2) {
                NSLog(@"已完成");
                [self orderWithViewController:@"6"];//已完成
            }
            if (tag == 3) {
                NSLog(@"退款");
                [self orderWithViewController:@"7"];//退款
            }
        }
        
    }
    
}

- (void)goToLogin {
    LoginViewController *loginView = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginView animated:YES];
    
}

//我的美单 --- 查看全部订单
- (void)orderWithViewController:(NSString *)strID {
    OrderViewController *orderView = [[OrderViewController alloc] init];
    orderView.strID = strID;
    [self.navigationController pushViewController:orderView animated:YES];
}

- (void)showOkayCancelAlert {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil message: nil preferredStyle:UIAlertControllerStyleActionSheet];

    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        UIImagePickerController* pickPhoto = [[UIImagePickerController alloc]init];
        pickPhoto.delegate = self;
        BOOL support = NO;
        for(NSNumber* num in [UIImagePickerController availableCaptureModesForCameraDevice:UIImagePickerControllerCameraDeviceRear]){
            if([num intValue] == UIImagePickerControllerCameraCaptureModePhoto){
                support = YES;
                pickPhoto.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickPhoto.allowsEditing = YES ;
            }
        }
        if(support){
            [self presentViewController:pickPhoto animated:YES completion:nil];
        }
        else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该设备不支持照相功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        UIImagePickerController *pick = [[UIImagePickerController alloc]init];
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pick.delegate = self;
        pick.allowsEditing = YES;
        //pick.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
        [self presentViewController:pick animated:YES completion:nil];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;

    if ([mediaType isEqualToString:@"public.image"]){
        
        editedImage = (UIImage *) [info objectForKey:
                                   UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) [info objectForKey:
                                     UIImagePickerControllerOriginalImage];
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
        imageUser = imageToSave;
        
        NSData *data = UIImageJPEGRepresentation(imageToSave, 1);
        NSString *dataStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        //上传照片
        [self getUploadAvatarWithData:dataStr];

    }

    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark   -  所有控件懒加载

- (UITableView *) myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initForAutoLayout];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [_myTableView registerClass:[MyHeadTableViewCell class] forCellReuseIdentifier:cellHeadCellID];
        [_myTableView registerClass:[MyContentTableViewCell class] forCellReuseIdentifier:cellContentCellID];
        [_myTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _myTableView;
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
