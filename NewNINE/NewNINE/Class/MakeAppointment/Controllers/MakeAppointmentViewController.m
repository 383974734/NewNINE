//
//  MakeAppointmentViewController.m
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 预约控制器

#import "MakeAppointmentViewController.h"


static NSString *cellOneID = @"MakeAppointmentOneTableViewCell";
static NSString *cellTwoID = @"MakeAppointmentTwoTableViewCell";
// ---------------------- 框架工具类 ----------------------
#import "UINavigationController+FDFullscreenPopGesture.h"
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "DesignerViewController.h"
#import "ChooseTimeViewController.h"
#import "ModalViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "MakeAppointmentOneTableViewCell.h"
#import "MakeAppointmentTwoTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------

// ---------------------- model      ----------------------

@interface MakeAppointmentViewController ()<UITableViewDelegate, UITableViewDataSource, MakeAppointmentOneTableViewCellDelegate, DesignerViewControllerDelegate, MakeAppointmentTwoTableViewCellDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UITableView   *makeAppointmentTableView;

@property (nonatomic, strong) UIView        *backFooterView;
/** 下一步按钮*/
@property (nonatomic, strong) UIButton      *nextStepButton;
/** 合计*/
@property (nonatomic, strong) UILabel       *totalLable;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
@property (nonatomic, strong) NSDictionary *makeAppointmentDic;

@end

@implementation MakeAppointmentViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    self.fd_interactivePopDisabled = YES;
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
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];}


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

    [self setNavWithLeftBarButton:NO titleName:@"预约美发"];
//    GetUserDefault(@"selectedIndex");
}

- (void)setNavWithLeftBarButton:(BOOL)leftBarButton titleName:(NSString *)title{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(64, 0, SCREEN_WIDTH - 128, 44)];
    lable.text = title;
    lable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lable];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 24, 24)];
    [button setImage:[UIImage imageNamed:@"nav-返回"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    button.hidden = leftBarButton;
    [view addSubview:button];
    [self.view addSubview:view];
}

- (void)didView:(UIButton *)btn {
    NSLog(@"%d", [NSString stringWithFormat:@"%@", GetUserDefault(@"selectedIndex")].intValue);
    self.rdv_tabBarController.selectedIndex = [NSString stringWithFormat:@"%@", GetUserDefault(@"selectedIndex")].intValue;
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.makeAppointmentTableView];
    [self.view addSubview:self.backFooterView];
    [self.backFooterView addSubview:self.nextStepButton];
    [self.backFooterView addSubview:self.totalLable];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.makeAppointmentTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0)];
    
    [self.backFooterView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.backFooterView autoSetDimension:ALDimensionHeight toSize:50];
    
    [self.nextStepButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 0, 9, 14) excludingEdge:ALEdgeLeft];
    [self.nextStepButton autoSetDimension:ALDimensionWidth toSize:85];
}

// 设计师预约产品数据接口

- (void) getProductInfosWithData:(NSString *)levelId productType:(NSString *)productType productClas:(NSString *)productClas {
    
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/getProductInfos"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"stylistinfoId,%@", levelId],//设计师ID
                       [NSString stringWithFormat:@"productType,%@", productType],//产品类型 1-烫发 2-染发 3－护理 4- 养发
                       [NSString stringWithFormat:@"productClas,%@", productClas],//发型分类 11烫发（整体） 12烫发（局部） 21染发（长） 22染发（中） 23染发（短） 31、护理 41、养发
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            
        }else {
            NSLog(@"book/getProductInfos%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/getProductInfos数据错误%@", error);
    }];
}

// 设计师预约首页数据接口
- (void) getBookStylisByIdWithData:(NSString *)stylistinfoId{
    NSArray *array = @[
                       [NSString stringWithFormat:@"stylistinfoId,%@", stylistinfoId],//设计师ID
                       ];
//    NSArray *array = @[
//                       [NSString stringWithFormat:@"stylistinfoId,%@", stylistinfoId],//设计师ID
//                       [NSString stringWithFormat:@"userCouponId,%@", userCouponId],//用户优惠券ID
//                       ];
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/getBookStylisById"];
    
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.makeAppointmentDic = resultObject;
            [self.makeAppointmentTableView reloadData];
        }else {
            NSLog(@"book/getBookStylisById%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/getBookStylisById数据错误%@", error);
    }];
}


// 获取订单中 可以使用积分 和 抵用现金
- (void) obtBookIntegralWithData:(NSString *)mobile stylistId:(NSString *)stylistId timeId:(NSString *)timeId comboId:(NSString *)comboId productIds:(NSString *)productIds userCouponId:(NSString *)userCouponId {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/obtBookIntegral"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", mobile],//手机号
                       [NSString stringWithFormat:@"stylistId,%@", stylistId],//设计师ID
                       [NSString stringWithFormat:@"timeId,%@", timeId],//预约时间ID
                       [NSString stringWithFormat:@"comboId,%@", comboId],//套餐ID
                       [NSString stringWithFormat:@"productIds,%@", productIds],//产品ID 多个,隔开
                       [NSString stringWithFormat:@"userCouponId,%@", userCouponId],//用户优惠券ID
                       ];

    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            
        }else {
            NSLog(@"book/obtBookIntegral%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/obtBookIntegral数据错误%@", error);
    }];
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
    return 2;
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

    return section == 0 ? 1 : 4;
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
    return indexPath.section == 0 ? [self makeAppointmentOnemTableViewCell:tableView cellForRowAtIndexPath:indexPath] : [self makeAppointmentTwomTableViewCell:tableView cellForRowAtIndexPath:indexPath];
}

/**
 *  预约美发 section == 0
 *
 *  @param tableView tableView
 *
 *  @return HomeBannerTableViewCell
 */
- (UITableViewCell *) makeAppointmentOnemTableViewCell :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MakeAppointmentOneTableViewCell *cell = [MakeAppointmentOneTableViewCell makeAppointmentOneCellWithTableView:tableView forCellReuseIdentifier:cellOneID];
    cell.delegate = self;
    if (self.makeAppointmentDic != nil) {
        cell.dict = self.makeAppointmentDic;
    }
    return cell;
}

/**
 *  预约美发 section == 1
 *
 *  @param tableView tableView
 *
 *  @return HomeStarHotTableViewCell
 */
- (UITableViewCell *) makeAppointmentTwomTableViewCell :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = @[@"烫发", @"染发", @"护理", @"养护"];
    MakeAppointmentTwoTableViewCell *cell = [MakeAppointmentTwoTableViewCell makeAppointmentTwoCellWithTableView:tableView forCellReuseIdentifier:cellTwoID];
    cell.title      = array[indexPath.row];
    cell.delegate   = self;
    cell.indexPath  = indexPath;
    if (self.makeAppointmentDic != nil) {
        cell.dict   = [self.makeAppointmentDic objectForKey:@"typeList"][indexPath.row];
    }
    return cell;
}

/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

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
    return indexPath.section == 0 ? 245 : 45;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 10;
}


#pragma mark - MakeAppointmentOneTableViewCellDelegate
- (void) makeAppointmentOneTableViewCell:(MakeAppointmentOneTableViewCell *)makeAppointmentOneTableViewCell buttonWithTag:(NSInteger)tag {
    switch (tag) {
        case 0:
        {
            NSLog(@"第一行");
            DesignerViewController *viewController = [[DesignerViewController alloc] init];
            viewController.stateStr = @"1";
            viewController.delegate = self;
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1:
            NSLog(@"第二行");
            break;
        case 2:
            NSLog(@"第三行");
            break;
        case 3:
        {
            NSLog(@"第四行");
            ChooseTimeViewController *viewController = [[ChooseTimeViewController alloc] init];
            viewController.stylistinfoId = [self.makeAppointmentDic objectForKey:@"id"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - DesignerViewControllerDelegate
/**
 *  点击设计师跳转预约界面
 *
 *  @param designerViewController DesignerViewController
 *  @param stylistinfoId          预约的设计师id
 */
- (void) designerViewController:(DesignerViewController *)designerViewController stylistinfoId:(NSString *)stylistinfoId {
    [self getBookStylisByIdWithData:stylistinfoId];
}

- (void) MakeAppointmentTwoTableViewCell:(MakeAppointmentTwoTableViewCell *)MakeAppointmentTwoTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self getProductInfosWithData:self.stylistinfoId productType:<#(NSString *)#> productClas:<#(NSString *)#>]
    
    ModalViewController * modalView = [[ModalViewController alloc]init];
    self.definesPresentationContext = YES;
    modalView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    modalView.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    modalView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    // [self presentModalViewController:modalView animated:YES];  ios 6 弃用了该方法
    [self presentViewController:modalView animated:YES completion:nil];
}

#pragma mark   -  所有控件懒加载
- (UITableView *) makeAppointmentTableView {
    if (!_makeAppointmentTableView) {
        _makeAppointmentTableView                = [[UITableView alloc] initForAutoLayout];
        _makeAppointmentTableView.delegate       = self;
        _makeAppointmentTableView.dataSource     = self;
//        _makeAppointmentTableView.scrollEnabled  = NO; //设置tableview 不能滚动
        [_makeAppointmentTableView registerClass:[MakeAppointmentOneTableViewCell class] forCellReuseIdentifier:cellOneID];
        [_makeAppointmentTableView registerClass:[MakeAppointmentTwoTableViewCell class] forCellReuseIdentifier:cellTwoID];
        _makeAppointmentTableView.separatorStyle  = NO;//cell线隐藏
        _makeAppointmentTableView.backgroundColor = Color(248, 248, 248, 1);
    }
    return _makeAppointmentTableView;
}

- (UIView *) backFooterView {
    if (!_backFooterView) {
        _backFooterView = [[UIView alloc] initForAutoLayout];
        _backFooterView.backgroundColor = [UIColor whiteColor];
    }
    return _backFooterView;
}

- (UIButton *) nextStepButton {
    if (!_nextStepButton) {
        _nextStepButton = [[UIButton alloc] initForAutoLayout];
        _nextStepButton.layer.borderWidth = 1;
        _nextStepButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_nextStepButton.layer setCornerRadius:2];
        [_nextStepButton setTitle:@"下一页" forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _nextStepButton;
}


- (UILabel *) totalLable {
    if (!_totalLable) {
        _totalLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, SCREEN_WIDTH - 150, 22)];
        [self titleWithName:@"合计:￥0"];
    }
    return _totalLable;
}


//文字颜色
- (void) titleWithName:(NSString *)str {
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:str];
    [hintString addAttribute:NSForegroundColorAttributeName value:Color(64, 64, 64, 1) range:NSMakeRange(0, 2)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[hintString string] rangeOfString:[str substringFromIndex:3]]];
    _totalLable.attributedText = hintString;
}


- (void) setStylistinfoId:(NSString *)stylistinfoId {
    _stylistinfoId = stylistinfoId;
    [self getBookStylisByIdWithData:_stylistinfoId];
}

@end
