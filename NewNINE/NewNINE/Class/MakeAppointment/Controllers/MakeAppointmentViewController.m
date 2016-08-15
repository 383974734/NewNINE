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
#import "PlaceOrderViewController.h"
#import "ServiceClassificationViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "MakeAppointmentOneTableViewCell.h"
#import "MakeAppointmentTwoTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface MakeAppointmentViewController ()<UITableViewDelegate, UITableViewDataSource, MakeAppointmentOneTableViewCellDelegate, DesignerViewControllerDelegate, MakeAppointmentTwoTableViewCellDelegate, ServiceClassificationViewControllerDelegate>

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

@property (nonatomic, strong) NSArray        *classificationMain;

/** 洗剪吹  第一个section的价位集合*/
@property (nonatomic, strong) NSMutableArray *moneyArray0;
/** 烫发价位集合*/
@property (nonatomic, strong) NSMutableArray *moneyArray1;
/** 染发价位集合*/
@property (nonatomic, strong) NSMutableArray *moneyArray2;
/** 护理价位集合*/
@property (nonatomic, strong) NSMutableArray *moneyArray3;
/** 洗色价位集合*/
@property (nonatomic, strong) NSMutableArray *moneyArray4;
/** 养发价位集合*/
@property (nonatomic, strong) NSMutableArray *moneyArray5;
/** 接发价位集合*/
@property (nonatomic, strong) NSMutableArray *moneyArray6;

/** 烫发显示内容集合*/
@property (nonatomic, strong) NSMutableArray *classificationArray1;
/** 染发显示内容集合*/
@property (nonatomic, strong) NSMutableArray *classificationArray2;
/** 护理显示内容集合*/
@property (nonatomic, strong) NSMutableArray *classificationArray3;
/** 洗色显示内容集合*/
@property (nonatomic, strong) NSMutableArray *classificationArray4;
/** 养发显示内容集合*/
@property (nonatomic, strong) NSMutableArray *classificationArray5;
/** 接发显示内容集合*/
@property (nonatomic, strong) NSMutableArray *classificationArray6;

/** 染发id集合*/
@property (nonatomic, strong) NSMutableArray *productArrayArrayId1;
/** 染发id集合*/
@property (nonatomic, strong) NSMutableArray *productArrayArrayId2;
/** 护理id集合*/
@property (nonatomic, strong) NSMutableArray *productArrayArrayId3;
/** 洗色id集合*/
@property (nonatomic, strong) NSMutableArray *productArrayArrayId4;
/** 养发id集合*/
@property (nonatomic, strong) NSMutableArray *productArrayArrayId5;
/** 接发id集合*/
@property (nonatomic, strong) NSMutableArray *productArrayArrayId6;


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

}

#pragma mark - Init Data Method
/**
 *  数据初始化
 */
- (void) initData {
    [self titleWithName];
    
    self.classificationArray1  = [NSMutableArray arrayWithObjects:@"烫发", nil];
    self.classificationArray2  = [NSMutableArray arrayWithObjects:@"染发", nil];
    self.classificationArray3  = [NSMutableArray arrayWithObjects:@"护理", nil];
    self.classificationArray4  = [NSMutableArray arrayWithObjects:@"洗色", nil];
    self.classificationArray5  = [NSMutableArray arrayWithObjects:@"养发", nil];
    self.classificationArray6  = [NSMutableArray arrayWithObjects:@"接发", nil];
    
    self.moneyArray0 = [NSMutableArray array];
    self.moneyArray1 = [NSMutableArray array];
    self.moneyArray2 = [NSMutableArray array];
    self.moneyArray3 = [NSMutableArray array];
    self.moneyArray4 = [NSMutableArray array];
    self.moneyArray5 = [NSMutableArray array];
    self.moneyArray6 = [NSMutableArray array];
    
    self.productArrayArrayId1 = [NSMutableArray array];
    self.productArrayArrayId2 = [NSMutableArray array];
    self.productArrayArrayId3 = [NSMutableArray array];
    self.productArrayArrayId4 = [NSMutableArray array];
    self.productArrayArrayId5 = [NSMutableArray array];
    self.productArrayArrayId6 = [NSMutableArray array];
    
    self.classificationMain = @[self.classificationArray1, self.classificationArray2, self.classificationArray3, self.classificationArray4, self.classificationArray5, self.classificationArray6];
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
//    [self setNavWithLeftBarButton:NO title:@"预约美发"];
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
    [self.makeAppointmentTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 52, 0)];
    
    [self.backFooterView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.backFooterView autoSetDimension:ALDimensionHeight toSize:50];
    
    [self.nextStepButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 0, 9, 14) excludingEdge:ALEdgeLeft];
    [self.nextStepButton autoSetDimension:ALDimensionWidth toSize:85];
}

#pragma mark - 接口数据
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
            [self titleWithName];
            [self.makeAppointmentTableView reloadData];
        }else {
            NSLog(@"book/getBookStylisById%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/getBookStylisById数据错误%@", error);
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
    return self.classificationMain.count + 1;
}

/**
 *  tableView 数据源方法  返回tableView 每个分组中cell的个数
 *
 *  @param tableView
 *  @param section
 *
 *  @return NSIntegerl
 */
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : [self.classificationMain[section - 1] count];
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
    MakeAppointmentTwoTableViewCell *cell = [MakeAppointmentTwoTableViewCell makeAppointmentTwoCellWithTableView:tableView forCellReuseIdentifier:cellTwoID];
    cell.indexPath   = indexPath;
    cell.delegate    = self;
    if ([[self.makeAppointmentDic objectForKey:@"typeList"] count] > indexPath.section - 1) {
        cell.dict    = [self.makeAppointmentDic objectForKey:@"typeList"][indexPath.section - 1];
    }
    cell.title       = self.classificationMain[indexPath.section - 1][indexPath.row];
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
 *  @param selectCategory1                 选择的分类  洗剪吹
 *  @param selectCategory2                 选择的分类  洗吹造型
 */
- (void)makeAppointmentOneTableViewCell:(MakeAppointmentOneTableViewCell *)makeAppointmentOneTableViewCell buttonWithTag:(NSInteger)tag selectCategory1:(NSString *)selectCategory1 selectCategory2:(NSString *)selectCategory2{

    self.moneyArray0 = [NSMutableArray array];
    if (selectCategory2 != nil && selectCategory1 != nil) {
        [self.moneyArray0 addObject:selectCategory1];
        [self.moneyArray0 addObject:selectCategory2];
    }
    [self titleWithName];
    if (tag == 0) {
        NSLog(@"第一行");
        DesignerViewController *viewController = [[DesignerViewController alloc] init];
        viewController.stateStr = @"1";
        viewController.delegate = self;
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }else {
        
        if (self.makeAppointmentDic != nil) {
            if (tag == 3) {
                ChooseTimeViewController *viewController = [[ChooseTimeViewController alloc] init];
                viewController.stylistinfoId = [self.makeAppointmentDic objectForKey:@"id"];
                viewController.makeTime      = GetUserDefault(@"makeTime");
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }else {
            [SVProgressHUD showInfoWithStatus:@"请先选择设计师!"];
        }
        return;
    }
}

#pragma mark - 处理   提交订单选择的数据(传到提交订单页面的数据)
- (void)replaceObjec:(NSString *)obj atIndex:(NSUInteger)atIndex {
//    [self.placeOrderArray replaceObjectAtIndex:atIndex withObject:obj];
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
//        self.hiddenSelected = false;
    }
}

- (void) MakeAppointmentTwoTableViewCell:(MakeAppointmentTwoTableViewCell *)MakeAppointmentTwoTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.makeAppointmentDic == nil) {
        [SVProgressHUD showInfoWithStatus:@"请先选择设计师!"];
        return;
    }
    
    if (indexPath.row == 0) {
        ServiceClassificationViewController *viewController = [[ServiceClassificationViewController alloc] init];
        viewController.titleName      = indexPath.section == 1 ? @"烫发" :indexPath.section == 2 ? @"染发" : indexPath.section == 3 ? @"护理" : indexPath.section         == 4 ? @"洗色"    : indexPath.section == 5 ? @"养发" : @"接发";
        viewController.productClas           = indexPath.section == 1 ? @"11"     : indexPath.section == 2 ? @"22" : indexPath.section == 3 ? @"31" : indexPath.section == 4 ? @"52"     : indexPath.section == 5 ? @"41"   : @"61";//@"11";
        viewController.productType           = indexPath.section == 1 ? @"1"      :indexPath.section == 2  ? @"2"  : indexPath.section == 3 ? @"3" : indexPath.section  == 4 ? @"7"      : indexPath.section == 5 ? @"4"    : @"8";//1-烫发 2-染发 3－护理 4- 养发 5- 洗剪吹 6- 洗吹  7- 洗色 8 -接发
        viewController.delegate              = self;
        viewController.stylistinfoId         = self.stylistinfoId;
        [self.navigationController pushViewController:viewController animated:YES];
        NSLog(@"跳页了");
        //发型分类 11烫发（长发） 12烫发（中发）13烫发 (短发) 21染发（长） 22染发（中） 23染发（短） 31护理{（烫发） 31护理（染发）  31护理（养发）-----  不要了}  41、养发  51洗色（长发） 52洗色（中发） 53洗色 (短发)  61（接发）
        
    }else {
        NSLog(@"******* ---删除数据--- ******");
        
        switch (indexPath.section) {
            case 1:
                NSLog(@"%@", self.classificationArray1);
                NSLog(@"%@", self.moneyArray1);
                
                [self.classificationArray1 removeObjectAtIndex:indexPath.row];
                [self.productArrayArrayId1 removeObjectAtIndex:indexPath.row - 1];
                [self.moneyArray1          removeObjectAtIndex:indexPath.row - 1];
                break;
            case 2:
                [self.classificationArray2 removeObjectAtIndex:indexPath.row];
                [self.productArrayArrayId2 removeObjectAtIndex:indexPath.row - 1];
                [self.moneyArray2          removeObjectAtIndex:indexPath.row - 1];
                break;
            case 3:
                [self.classificationArray3 removeObjectAtIndex:indexPath.row];
                [self.productArrayArrayId3 removeObjectAtIndex:indexPath.row - 1];
                [self.moneyArray3          removeObjectAtIndex:indexPath.row - 1];
                break;
            case 4:
                [self.classificationArray4 removeObjectAtIndex:indexPath.row];
                [self.productArrayArrayId4 removeObjectAtIndex:indexPath.row - 1];
                [self.moneyArray4          removeObjectAtIndex:indexPath.row - 1];
                break;
            case 5:
                [self.classificationArray5 removeObjectAtIndex:indexPath.row];
                [self.productArrayArrayId5 removeObjectAtIndex:indexPath.row - 1];
                [self.moneyArray5          removeObjectAtIndex:indexPath.row - 1];
                break;
            case 6:
                [self.classificationArray6 removeObjectAtIndex:indexPath.row];
                [self.productArrayArrayId6 removeObjectAtIndex:indexPath.row - 1];
                [self.moneyArray6          removeObjectAtIndex:indexPath.row - 1];
                break;
                
            default:
                break;
        }
        [self titleWithName];
        [self.makeAppointmentTableView reloadData];
    }
}


/**
 *  ServiceClassificationViewController        发型选择分类代理
 *
 *  @param serviceClassificationViewController ServiceClassificationViewController
 *  @param productSelectArray                  记录所有被选择的发型分类名称-长短-价钱
 *  @param productType                         产品类型 1-烫发 2-染发 3－护理 4- 养发 7-洗色 8- 接发
 *  @param selectedSegmentStr                  记录发型长中短分类
 *  @param productArrayArrayId                 产品ID数组
 *  @param productName                         选择产品名称产品
 *  @param productArrayMoney                   产品价钱数组
 */
- (void)serviceClassificationViewController:(ServiceClassificationViewController *)serviceClassificationViewController productSelectArray:(NSMutableArray *)productSelectArray productType:(NSString *)productType selectedSegmentStr:(NSString *)selectedSegmentStr productArrayArrayId:(NSArray *)productArrayArrayId productName:(NSString *)productName productArrayMoney:(NSMutableArray *)productArrayMoney {
    //产品类型 1-烫发 2-染发 3－护理 4- 养发 7-洗色  8 - 接发
    switch (productType.intValue) {
        case 1:
        {
            for (int i = 0; i < productSelectArray.count; i++) {
                if (![productSelectArray[i] isEqualToString:@"1"]) {
                    [self.classificationArray1 addObject:productSelectArray[i]];
                }
            }
            for (int i = 0; i < productArrayMoney.count; i ++) {
                [self.moneyArray1 addObject:productArrayMoney[i]];
                [self.productArrayArrayId1 addObject:productArrayArrayId[i]];
            }
            
        }
            break;
        case 2:
        {
            for (int i = 0; i < productSelectArray.count; i++) {
                if (![productSelectArray[i] isEqualToString:@"1"]) {
                    [self.classificationArray2 addObject:productSelectArray[i]];
                }
            }
            for (int i = 0; i < productArrayMoney.count; i ++) {
                [self.moneyArray2 addObject:productArrayMoney[i]];
                [self.productArrayArrayId2 addObject:productArrayArrayId[i]];
            }
        }
            break;
        case 3:
        {
            for (int i = 0; i < productSelectArray.count; i++) {
                if (![productSelectArray[i] isEqualToString:@"1"]) {
                    [self.classificationArray3 addObject:productSelectArray[i]];
                }
            }
            for (int i = 0; i < productArrayMoney.count; i ++) {
                [self.moneyArray3 addObject:productArrayMoney[i]];
                [self.productArrayArrayId3 addObject:productArrayArrayId[i]];
            }
        }
            break;
        case 7:
        {
            for (int i = 0; i < productSelectArray.count; i++) {
                if (![productSelectArray[i] isEqualToString:@"1"]) {
                    [self.classificationArray4 addObject:productSelectArray[i]];//   ******这里要注意******
                }
            }
            for (int i = 0; i < productArrayMoney.count; i ++) {
                [self.moneyArray4 addObject:productArrayMoney[i]];
                [self.productArrayArrayId4 addObject:productArrayArrayId[i]];
            }
        }
            break;
        case 4:
        {
            for (int i = 0; i < productSelectArray.count; i++) {
                if (![productSelectArray[i] isEqualToString:@"1"]) {
                    [self.classificationArray5 addObject:productSelectArray[i]];//   ******这里要注意******
                }
            }
            for (int i = 0; i < productArrayMoney.count; i ++) {
                [self.moneyArray5 addObject:productArrayMoney[i]];
                [self.productArrayArrayId5 addObject:productArrayArrayId[i]];
            }
        }
            break;
        case 8:
        {
            for (int i = 0; i < productSelectArray.count; i++) {
                if (![productSelectArray[i] isEqualToString:@"1"]) {
                    [self.classificationArray6 addObject:productSelectArray[i]];
                }
            }
            for (int i = 0; i < productArrayMoney.count; i ++) {
                [self.moneyArray6 addObject:productArrayMoney[i]];
                [self.productArrayArrayId6 addObject:productArrayArrayId[i]];
            }
        }
            break;
            
        default:
            break;
    }
    
    [self titleWithName];
    [self.makeAppointmentTableView reloadData];
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
    }
    return _totalLable;
}


#pragma mark - 计算合计金额
//文字颜色
- (void) titleWithName{

    long  monty = 0;
    for (int i = 0; i < self.moneyArray0.count; i ++) {
        monty += [self.moneyArray0[i] longLongValue];
    }
    
    for (int i = 0; i < self.moneyArray1.count; i ++) {
        monty += [self.moneyArray1[i] longLongValue] - [[[self.makeAppointmentDic objectForKey:@"typeList"][0] objectForKey:@"cutvalues"] longLongValue];
    }
    for (int i = 0; i < self.moneyArray2.count; i ++) {
        monty += [self.moneyArray2[i] longLongValue] - [[[self.makeAppointmentDic objectForKey:@"typeList"][1] objectForKey:@"cutvalues"] longLongValue];
    }
    for (int i = 0; i < self.moneyArray3.count; i ++) {
        monty += [self.moneyArray3[i] longLongValue] - [[[self.makeAppointmentDic objectForKey:@"typeList"][2] objectForKey:@"cutvalues"] longLongValue];
    }
    for (int i = 0; i < self.moneyArray4.count; i ++) {
        monty += [self.moneyArray4[i] longLongValue] - [[[self.makeAppointmentDic objectForKey:@"typeList"][3] objectForKey:@"cutvalues"] longLongValue];
    }
    for (int i = 0; i < self.moneyArray5.count; i ++) {
        monty += [self.moneyArray5[i] longLongValue] - [[[self.makeAppointmentDic objectForKey:@"typeList"][4] objectForKey:@"cutvalues"] longLongValue];
    }
    for (int i = 0; i < self.moneyArray6.count; i ++) {
        monty += [self.moneyArray6[i] longLongValue] - [[[self.makeAppointmentDic objectForKey:@"typeList"][5] objectForKey:@"cutvalues"] longLongValue];
    }
    
    
    if ([NSString stringWithFormat:@"%ld", monty].intValue > 0) {
        self.nextStepButton.layer.borderColor = [UIColor redColor].CGColor;
        [self.nextStepButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.nextStepButton.userInteractionEnabled = YES;
    }else {
        self.nextStepButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.nextStepButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.nextStepButton.userInteractionEnabled = NO;
    }
    
    
    NSLog(@"******* --- 合计金额 --- %ld",monty);
    
    
    NSString *string = [NSString stringWithFormat:@"合计:￥%@", [NSString stringWithFormat:@"%ld", monty]];
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:string];
    [hintString addAttribute:NSForegroundColorAttributeName value:Color(64, 64, 64, 1) range:NSMakeRange(0, 3)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, [NSString stringWithFormat:@"%ld", monty].length + 1)];
    _totalLable.attributedText = hintString;
}


- (void) setStylistinfoId:(NSString *)stylistinfoId {
    _stylistinfoId = stylistinfoId;
    [self getBookStylisByIdWithData:_stylistinfoId];
}

#pragma mark - 下一页点击事件
- (void)didButton:(UIButton *)btn {

    NSString *string = @"";//提取所选项目ID
    
    NSString *str = GetUserDefault(@"makeTime");

    if (!(str.length > 0)) {
        [SVProgressHUD showInfoWithStatus:@"请先选择预约时间!"];
        return;
    }

    NSMutableArray *array = [NSMutableArray array];//提取所选项目内容
    
    if ([self.moneyArray0[0] longLongValue] > 0) {
        [array addObject:[NSString stringWithFormat:@"剪发-￥%@", self.moneyArray0[0]]];
        string = [NSString stringWithFormat:@"%@,", [[self.makeAppointmentDic objectForKey:@"bookProducts"][0] objectForKey:@"productId"]];
    }
    if ([self.moneyArray0[1] longLongValue] > 0) {
        [array addObject:[NSString stringWithFormat:@"洗吹造型-￥%@", self.moneyArray0[1]]];
        string = [NSString stringWithFormat:@"%@%@,", string, [[self.makeAppointmentDic objectForKey:@"bookProducts"][1] objectForKey:@"productId"]];
    }
    
    for (int i = 0; i < self.classificationMain.count; i ++) {
        for (int a = 0 ; a < [self.classificationMain[i] count]; a ++) {
            if (a != 0) {
                [array addObject:self.classificationMain[i][a]];
            }
        }
    }
    
    NSArray *arrayProductID = @[self.productArrayArrayId1, self.productArrayArrayId2, self.productArrayArrayId3, self.productArrayArrayId4, self.productArrayArrayId5, self.productArrayArrayId6];
    
    for (int i = 0; i < arrayProductID.count; i ++) {
        for (int a = 0; a < [arrayProductID[i] count]; a ++) {
            string = [NSString stringWithFormat:@"%@%@,", string, arrayProductID[i][a]];
        }
    }

    PlaceOrderViewController *viewController = [[PlaceOrderViewController alloc] init];
    viewController.titleString               = @"提交订单";
    viewController.totalString               = [NSString stringWithFormat:@"%@", self.totalLable.text];
    viewController.deductibleTotalString     = [self.totalLable.text componentsSeparatedByString:@"￥"][1];
    viewController.productIDString           = [string substringToIndex:string.length - 1];
    viewController.makeAppointmentDic        = self.makeAppointmentDic;
    viewController.placeOrderArray           = array;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
