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
#import "PlaceOrderViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "MakeAppointmentOneTableViewCell.h"
#import "MakeAppointmentTwoTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------

// ---------------------- model      ----------------------

@interface MakeAppointmentViewController ()<UITableViewDelegate, UITableViewDataSource, MakeAppointmentOneTableViewCellDelegate, DesignerViewControllerDelegate, MakeAppointmentTwoTableViewCellDelegate, ModalViewControllerDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UITableView   *makeAppointmentTableView;

@property (nonatomic, strong) UIView        *backFooterView;
/** 下一步按钮*/
@property (nonatomic, strong) UIButton      *nextStepButton;
/** 合计控件*/
@property (nonatomic, strong) UILabel       *totalLable;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 设计师预约首页数据*/
@property (nonatomic, strong) NSDictionary   *makeAppointmentDic;
/** 选择护理类型默认数据*/
@property (nonatomic, strong) NSMutableArray *productTypeArray;
/** 提交订单选择的数据(传到提交订单页面的数据) */
@property (nonatomic, strong) NSMutableArray *placeOrderArray;
/** 选择护理类型烫发默认数据*/
@property (nonatomic, copy) NSString         *selectedSegmentStr1;
/** 选择护理类型染发默认数据*/
@property (nonatomic, copy) NSString         *selectedSegmentStr2;

@property (nonatomic, copy) NSString         *didSelectProductId1;

@property (nonatomic, copy) NSString         *didSelectProductId2;

@property (nonatomic, copy) NSString         *didSelectProductId3;

@property (nonatomic, copy) NSString         *didSelectProductId4;
/** 洗剪吹、洗吹   选择状态是否复原*/  //默认无选择  false
@property (nonatomic, getter=isHiddenSelected) BOOL hiddenSelected;
/** 合计金额(立减)*/
@property (nonatomic, copy) NSString         *totalString;
/** 合计金额(原价)*/
@property (nonatomic, copy) NSString         *priceString;
/** 洗剪吹金额(立减)*/
@property (nonatomic, copy) NSString         *haircut;
/** 洗吹金额(立减)*/
@property (nonatomic, copy) NSString         *shampoo;
/** 烫发金额(立减)*/
@property (nonatomic, copy) NSString         *perm;
/** 染发金额(立减)*/
@property (nonatomic, copy) NSString         *hairColour;
/** 护理金额(立减)*/
@property (nonatomic, copy) NSString         *nursing;
/** 养护金额(立减)*/
@property (nonatomic, copy) NSString         *curing;

/** 洗剪吹金额(原价)*/
@property (nonatomic, copy) NSString         *haircutPrice;
/** 洗吹金额(原价)*/
@property (nonatomic, copy) NSString         *shampooPrice;
/** 烫发金额(原价)*/
@property (nonatomic, copy) NSString         *permPrice;
/** 染发金额(原价)*/
@property (nonatomic, copy) NSString         *hairColourPrice;
/** 护理金额(原价)*/
@property (nonatomic, copy) NSString         *nursingPrice;
/** 养护金额(原价)*/
@property (nonatomic, copy) NSString         *curingPrice;

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
    SetUserDefault(nil, @"makeTime");
//    [self addObserver:self forKeyPath:@"totalString" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
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
    if (GetUserDefault(@"makeTime") != nil) {
        [self.makeAppointmentTableView reloadData];
    }
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
}

/**
 *  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@" selfViewController Destroy ");

//    @try {
//        [self removeObserver:self forKeyPath:@"totalString"];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"多次删除了");
//    }
}

#pragma mark - Init Data Method
/**
 *  数据初始化
 */
- (void) initData {
    self.totalString           = @"0";
    self.haircut               = @"0";
    self.shampoo               = @"0";
    self.perm                  = @"0";
    self.hairColour            = @"0";
    self.nursing               = @"0";
    self.curing                = @"0";
    self.selectedSegmentStr1   = @"长发";
    self.selectedSegmentStr2   = @"长发";
    self.didSelectProductId1   = @"";
    self.didSelectProductId2   = @"";
    self.didSelectProductId3   = @"";
    self.didSelectProductId4   = @"";
    self.hiddenSelected        = false;//默认无选择
    self.productTypeArray      = [[NSMutableArray alloc] initWithObjects:@"请选择", @"请选择", @"请选择", @"请选择", nil];
    self.placeOrderArray       = [[NSMutableArray alloc] initWithObjects:@"请选择", @"请选择", @"请选择", @"请选择", @"请选择", nil];
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
            SetUserDefault(@"", @"makeTime");//显示预约时间
            self.makeAppointmentDic    = resultObject;
            [self initData];
            [self titleWithName:@"0"];
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
    cell.delegate       = self;
    cell.hiddenSelected = self.hiddenSelected;
    if (self.makeAppointmentDic != nil) {
        cell.dict       = self.makeAppointmentDic;
    }
    if (GetUserDefault(@"makeTime") != nil) {
        cell.timeMake   = GetUserDefault(@"makeTime");
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
    cell.title       = array[indexPath.row];
    cell.productType = self.productTypeArray[indexPath.row];
    cell.delegate    = self;
    cell.indexPath   = indexPath;
    if ([[self.makeAppointmentDic objectForKey:@"typeList"] count] > indexPath.row) {
        cell.dict    = [self.makeAppointmentDic objectForKey:@"typeList"][indexPath.row];
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
/**
 *  预约美发头像分区代理
 *
 *  @param makeAppointmentOneTableViewCell MakeAppointmentOneTableViewCell
 *  @param tag                             选择的第几行
 *  @param selectCategory                  选择的分类  //选中分类    （0：洗剪吹没选中         1：选中了洗剪吹         2：洗吹没选中      3：选中了洗吹））
 */
- (void) makeAppointmentOneTableViewCell:(MakeAppointmentOneTableViewCell *)makeAppointmentOneTableViewCell buttonWithTag:(NSInteger)tag selectCategory:(NSString *)selectCategory{

    if (tag == 0) {
        NSLog(@"第一行");
        DesignerViewController *viewController = [[DesignerViewController alloc] init];
        viewController.stateStr = @"1";
        viewController.delegate = self;
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    if (tag == 3) {
        NSLog(@"第四行");
        if (self.makeAppointmentDic != nil) {
            ChooseTimeViewController *viewController = [[ChooseTimeViewController alloc] init];
            viewController.stylistinfoId = [self.makeAppointmentDic objectForKey:@"id"];
            viewController.makeTime      = GetUserDefault(@"makeTime");
            [self.navigationController pushViewController:viewController animated:YES];
        }else {
            [SVProgressHUD showInfoWithStatus:@"请先选择设计师!"];
        }
        return;
    }
    
    self.hiddenSelected = true;
    if (self.makeAppointmentDic != nil) {

        if (selectCategory.intValue == 0) {
            self.haircut = @"0";
            self.haircutPrice = @"0";
            [self replaceObjec:@"请选择" atIndex:0];
        }
        if (selectCategory.intValue == 1) {
            self.shampoo = @"0";
            self.shampooPrice = @"0";
            self.haircut = [NSString stringWithFormat:@"%@", [self realMoney:@"0"]];
            self.haircutPrice = [NSString stringWithFormat:@"%@", [self priceMoney:@"0"]];
            [self replaceObjec:[NSString stringWithFormat:@"洗剪吹,%@", self.haircut] atIndex:0];
        }
        if (selectCategory.intValue == 2) {
            self.shampoo = @"0";
            self.shampooPrice = @"0";
            [self replaceObjec:@"请选择" atIndex:0];
        }
        if (selectCategory.intValue == 3) {
            self.haircut = @"0";
            self.haircutPrice = @"0";
            self.shampoo = [NSString stringWithFormat:@"%@", [self realMoney:@"1"]];
            self.shampooPrice = [NSString stringWithFormat:@"%@", [self priceMoney:@"1"]];
            [self replaceObjec:[NSString stringWithFormat:@"洗吹,%@", self.shampoo] atIndex:0];
        }
    }
    
    self.priceString = [NSString stringWithFormat:@"%d", self.haircutPrice.intValue + self.shampooPrice.intValue + self.permPrice.intValue + self.hairColourPrice.intValue + self.nursingPrice.intValue + self.curingPrice.intValue ];//计算所选的项目合计（没有参加立减）
    
    self.totalString = [NSString stringWithFormat:@"%d", self.haircut.intValue + self.shampoo.intValue + self.perm.intValue + self.hairColour.intValue + self.nursing.intValue + self.curing.intValue ];//计算所选的项目合计（立减后）
    [self titleWithName:self.totalString];
}

#pragma mark - 处理   提交订单选择的数据(传到提交订单页面的数据)
- (void)replaceObjec:(NSString *)obj atIndex:(NSUInteger)atIndex {
    [self.placeOrderArray replaceObjectAtIndex:atIndex withObject:obj];
}

#pragma mark - 处理   立减后的价位
- (NSString *)realMoney:(NSString *)index {
    
    NSArray *array = [self.makeAppointmentDic objectForKey:@"bookProducts"];
    if (!(array.count > index.intValue)) return @"0";
    
    NSString *price = [[self.makeAppointmentDic objectForKey:@"bookProducts"][index.intValue] objectForKey:@"price"];//原价
    NSString *cutvalues = [[self.makeAppointmentDic objectForKey:@"bookProducts"][index.intValue] objectForKey:@"cutvalues"];//立减金额
    NSString *realMoney = [NSString stringWithFormat:@"%d", price.intValue - cutvalues.intValue];//实收金额
    
//    return realMoney.intValue > 0 ? realMoney : 0;
    return realMoney;
}

#pragma mark - 处理   所选项目是否有立减金额   （有立减返回0    没有立减返回原价）
- (NSString *)priceMoney:(NSString *)index {
    NSArray *array = [self.makeAppointmentDic objectForKey:@"bookProducts"];
    if (!(array.count > index.intValue)) return @"0";
    
    NSString *price = [[self.makeAppointmentDic objectForKey:@"bookProducts"][index.intValue] objectForKey:@"price"];//原价
    NSString *cutvalues = [[self.makeAppointmentDic objectForKey:@"bookProducts"][index.intValue] objectForKey:@"cutvalues"];//立减金额

    return cutvalues.intValue > 0 ? @"0" : price;
}

#pragma mark - DesignerViewControllerDelegate
/**
 *  点击设计师跳转预约界面
 *
 *  @param designerViewController DesignerViewController
 *  @param stylistinfoId          预约的设计师id
 */
- (void) designerViewController:(DesignerViewController *)designerViewController stylistinfoId:(NSString *)stylistinfoId {
    if (self.stylistinfoId.intValue != stylistinfoId.intValue) {
        [self getBookStylisByIdWithData:stylistinfoId];
        self.stylistinfoId = stylistinfoId;
        self.hiddenSelected = false;
    }
}

- (void) MakeAppointmentTwoTableViewCell:(MakeAppointmentTwoTableViewCell *)MakeAppointmentTwoTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.makeAppointmentDic == nil) {
        [SVProgressHUD showInfoWithStatus:@"请先选择设计师!"];
        return;
    }
    
    ModalViewController * modalView = [[ModalViewController alloc]init];
    modalView.delegate              = self;
    self.definesPresentationContext = YES;
    modalView.stylistinfoId         = self.stylistinfoId;
    modalView.productType           = [NSString stringWithFormat:@"%ld", indexPath.row + 1];//产品类型 1-烫发 2-染发 3－护理 4- 养发
    if (indexPath.row == 0) {//发型分类 11烫发（长发） 12烫发（中发）13(短发) 21染发（长） 22染发（中） 23染发（短） 31、护理 41、养发
        modalView.productTypeName       = self.productTypeArray[indexPath.row];
        modalView.productId             = self.didSelectProductId1;
        if ([self.selectedSegmentStr1 isEqualToString:@"长发"]) {
            modalView.productClas       = @"11";
        }
        if ([self.selectedSegmentStr1 isEqualToString:@"中发"]) {
            modalView.productClas       = @"12";
        }
        if ([self.selectedSegmentStr1 isEqualToString:@"短发"]) {
            modalView.productClas       = @"13";
        }
        modalView.productClasBtn        = YES;
    }
    if (indexPath.row == 1) {
        modalView.productId             = self.didSelectProductId2;
        modalView.productTypeName       = self.productTypeArray[indexPath.row];
        if ([self.selectedSegmentStr2 isEqualToString:@"长发"]) {
            modalView.productClas       = @"21";
        }
        if ([self.selectedSegmentStr2 isEqualToString:@"中发"]) {
            modalView.productClas       = @"22";
        }
        if ([self.selectedSegmentStr2 isEqualToString:@"短发"]) {
            modalView.productClas       = @"23";
        }
        modalView.productClasBtn        = YES;
    }
    if (indexPath.row == 2) {
        modalView.productId             = self.didSelectProductId3;
        modalView.productTypeName       = self.productTypeArray[indexPath.row];
        modalView.productClas           = @"31";
        modalView.productClasBtn        = NO;
    }
    if (indexPath.row == 3) {
        modalView.productId             = self.didSelectProductId4;
        modalView.productTypeName       = self.productTypeArray[indexPath.row];
        modalView.productClas           = @"41";
        modalView.productClasBtn        = NO;
    }
    modalView.modalTransitionStyle  = UIModalTransitionStyleCrossDissolve;
    modalView.view.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    modalView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    // [self presentModalViewController:modalView animated:YES];  ios 6 弃用了该方法
    [self presentViewController:modalView animated:YES completion:nil];
}

/**
 *  ModalViewControllerDelegate   模态视图发型选择分类代理
 *
 *  @param modalViewController ModalViewController
 *  @param didSelectStr        选择的发型分类内容
 *  @param productType         产品类型
 *  @param selectedSegmentStr  发型分类
 *  @param productId           产品id
 *  @param productName         选择产品名称产品
 */
- (void)modalViewController:(ModalViewController *)modalViewController didSelectStr:(NSString *)didSelectStr productType:(NSString *)productType selectedSegmentStr:(NSString *)selectedSegmentStr productId:(NSString *)productId productName:(NSString *)productName{
    NSUInteger index = productType.integerValue;

    NSString *str;
    if (didSelectStr.length > 0) {
        str = [didSelectStr componentsSeparatedByString:@"￥"][1];
    }
    
    if (!([[self.makeAppointmentDic objectForKey:@"typeList"] count] > index - 1)) return;
    
    if (index == 1) {
        NSLog(@"%@", [[self.makeAppointmentDic objectForKey:@"typeList"][0] objectForKey:@"cutvalues"]);
        if (str.intValue > 0) {
            self.perm = [NSString stringWithFormat:@"%d", str.intValue - [[[self.makeAppointmentDic objectForKey:@"typeList"][0] objectForKey:@"cutvalues"] intValue]];
            
            self.permPrice = [[[self.makeAppointmentDic objectForKey:@"typeList"][0] objectForKey:@"cutvalues"] intValue] > 0 ? @"0" : str;
            
            [self replaceObjec:[NSString stringWithFormat:@"%@,%@", productName, self.perm] atIndex:1];
        }else {
            self.perm = @"0";
            self.permPrice = @"0";
            [self replaceObjec:@"请选择" atIndex:1];
        }
        self.selectedSegmentStr1 = selectedSegmentStr;
        self.didSelectProductId1 = productId;
        [self didSelectStrWithLength:index didSelectStr:didSelectStr selectedSegmentStr:self.selectedSegmentStr1];
    }
    if (index == 2) {
        if (str.intValue > 0) {
            self.hairColour = [NSString stringWithFormat:@"%d", str.intValue - [[[self.makeAppointmentDic objectForKey:@"typeList"][1] objectForKey:@"cutvalues"] intValue]];
            
            self.hairColourPrice = [[[self.makeAppointmentDic objectForKey:@"typeList"][1] objectForKey:@"cutvalues"] intValue] > 0 ? @"0" : str;
            
            [self replaceObjec:[NSString stringWithFormat:@"%@,%@", productName, self.hairColour] atIndex:2];
        }else {
            self.hairColour = @"0";
            self.hairColourPrice = @"0";
            [self replaceObjec:@"请选择" atIndex:2];
        }
        self.selectedSegmentStr2 = selectedSegmentStr;
        self.didSelectProductId2 = productId;
        [self didSelectStrWithLength:index didSelectStr:didSelectStr selectedSegmentStr:self.selectedSegmentStr2];
    }
    if (index == 3) {
        if (str.intValue > 0) {
            self.nursing = [NSString stringWithFormat:@"%d", str.intValue - [[[self.makeAppointmentDic objectForKey:@"typeList"][2] objectForKey:@"cutvalues"] intValue]];
            
            self.nursingPrice = [[[self.makeAppointmentDic objectForKey:@"typeList"][2] objectForKey:@"cutvalues"] intValue] > 0 ? @"0" : str;
            
            [self replaceObjec:[NSString stringWithFormat:@"%@,%@", productName, self.nursing] atIndex:3];
        }else {
            self.nursing = @"0";
            self.nursingPrice = @"0";
            [self replaceObjec:@"请选择" atIndex:3];
        }
        self.didSelectProductId3 = productId;
        [self didSelectStrWithLength:index didSelectStr:didSelectStr selectedSegmentStr:nil];
    }
    if (index == 4) {
        if (str.intValue > 0) {
            self.curing = [NSString stringWithFormat:@"%d", str.intValue - [[[self.makeAppointmentDic objectForKey:@"typeList"][3] objectForKey:@"cutvalues"] intValue]];
            
            self.curingPrice = [[[self.makeAppointmentDic objectForKey:@"typeList"][3] objectForKey:@"cutvalues"] intValue] > 0 ? @"0" : str;
            
            [self replaceObjec:[NSString stringWithFormat:@"%@,%@", productName, self.curing] atIndex:4];
        }else {
            self.curing = @"0";
            self.curingPrice = @"0";
            [self replaceObjec:@"请选择" atIndex:4];
        }
        self.didSelectProductId4 = productId;
        [self didSelectStrWithLength:index didSelectStr:didSelectStr selectedSegmentStr:nil];
    }
    self.priceString = [NSString stringWithFormat:@"%d", self.haircutPrice.intValue + self.shampooPrice.intValue + self.permPrice.intValue + self.hairColourPrice.intValue + self.nursingPrice.intValue + self.curingPrice.intValue ];//计算所选的项目合计（没有参加立减）
    
    self.totalString = [NSString stringWithFormat:@"%d", self.haircut.intValue + self.shampoo.intValue + self.perm.intValue + self.hairColour.intValue + self.nursing.intValue + self.curing.intValue ];//计算所选的项目合计（立减后）
    
    [self titleWithName:self.totalString];
    [self.makeAppointmentTableView reloadData];
}

- (void)didSelectStrWithLength:(NSUInteger)index didSelectStr:(NSString *)didSelectStr selectedSegmentStr:(NSString *)selectedSegmentStrNumber{
    if (didSelectStr.length > 1) {
        [self.productTypeArray replaceObjectAtIndex:index - 1 withObject:didSelectStr];
    }else {
        [self.productTypeArray replaceObjectAtIndex:index - 1 withObject:@"请选择"];
        if (index == 1) {
            self.selectedSegmentStr1 = @"长发";
        }
        if (index == 2) {
            self.selectedSegmentStr2 = @"长发";
        }
    }
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
        _nextStepButton.userInteractionEnabled = NO;
        [_nextStepButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}


- (UILabel *) totalLable {
    if (!_totalLable) {
        _totalLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, SCREEN_WIDTH - 150, 22)];
        [self titleWithName:@"0"];
    }
    return _totalLable;
}


//文字颜色
- (void) titleWithName:(NSString *)str {
    
    if (str.intValue > 0) {
        self.nextStepButton.layer.borderColor = [UIColor redColor].CGColor;
        [self.nextStepButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.nextStepButton.userInteractionEnabled = YES;
    }else {
        self.nextStepButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.nextStepButton.userInteractionEnabled = NO;
    }
    
    NSString *string = [NSString stringWithFormat:@"合计:￥%@", str];
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:string];
    [hintString addAttribute:NSForegroundColorAttributeName value:Color(64, 64, 64, 1) range:NSMakeRange(0, 3)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, str.length + 1)];
    _totalLable.attributedText = hintString;
}


- (void) setStylistinfoId:(NSString *)stylistinfoId {
    _stylistinfoId = stylistinfoId;
    [self getBookStylisByIdWithData:_stylistinfoId];
}

//#pragma 预约时间的KVO 监听
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if (self.totalString.intValue > 0) {
//        self.nextStepButton.layer.borderColor = [UIColor redColor].CGColor;
//        [self.nextStepButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        self.nextStepButton.userInteractionEnabled = YES;
//    }else {
//        self.nextStepButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        [self.nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        self.nextStepButton.userInteractionEnabled = NO;
//    }
//}


#pragma mark - 下一步点击事件
- (void)didButton:(UIButton *)btn {
    NSLog(@"点击了");
    
    NSLog(@"%@", self.productTypeArray);
    NSLog(@"%@", self.makeAppointmentDic);
    NSLog(@"%@", self.placeOrderArray);
    NSLog(@"%@", self.priceString);

    NSString *str = GetUserDefault(@"makeTime");
    
    if (!(str.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请先选择预约时间!"];
        return;
    }
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.placeOrderArray.count; i ++) {
        if (![self.placeOrderArray[i] isEqualToString:@"请选择"]) {
            [array addObject:self.placeOrderArray[i]];
        }
    }
    
    PlaceOrderViewController *viewController = [[PlaceOrderViewController alloc] init];
    viewController.titleString           = @"提交订单";
    viewController.totalString           = self.totalString;
    viewController.deductibleTotalString = self.totalString;
    viewController.priceString           = self.priceString;
    viewController.makeAppointmentDic    = self.makeAppointmentDic;
    viewController.placeOrderArray       = array;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
