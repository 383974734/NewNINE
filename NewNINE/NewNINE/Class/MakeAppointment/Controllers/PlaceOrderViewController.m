//
//  PlaceOrderViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 提交订单、订单详情 -- 控制器

#import "PlaceOrderViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "ClassificationTableViewCell.h"
#import "InformationTableViewCell.h"
#import "PaymentTableViewCell.h"
#import "DepositTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------

#import "orderViewModel.h"
// ---------------------- model      ----------------------


static NSString *cellClassificationID   = @"cellClassificationID";
static NSString *cellInformationID      = @"cellInformationID";
static NSString *cellPaymentID          = @"cellPaymentID";
static NSString *cellDepositID          = @"cellDepositID";


@interface PlaceOrderViewController ()<UITableViewDelegate, UITableViewDataSource, DepositTableViewCellDelegate, PaymentTableViewCellDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UITableView   *placeOrderTableView;

@property (nonatomic, strong) UIView        *backFooterView;
/** 提交订单按钮*/
@property (nonatomic, strong) UIButton      *nextStepButton;
/** 合计控件*/
@property (nonatomic, strong) UILabel       *totalLable;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 是否选择仅支付50元定金*/
@property (nonatomic, getter=isSelectedBool) BOOL selectedBool;

/** 获取当前用户可用积分钱数*/
@property (nonatomic, copy) NSString *integral;


@end

@implementation PlaceOrderViewController

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
    if ([self.titleString isEqualToString:@"订单详情"]) {
       [self titleWithName:[NSString stringWithFormat:@"%@", self.orderViewModel.orderPayMoney]];
    }
    
    self.selectedBool = false;
    [self obtBookIntegralWithData:@"" stylistId:@"" timeId:@"" comboId:@"" productIds:self.productIDString userCouponId:@""];
    [self bookCalculateActivityFund:@"" userCouponId:@""];
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
    [self setNavWithLeftBarButton:NO title:self.titleString];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.placeOrderTableView];
    [self.view addSubview:self.backFooterView];
    [self.backFooterView addSubview:self.nextStepButton];
    [self.backFooterView addSubview:self.totalLable];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.placeOrderTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(70, 0, 71, 0)];
    
    [self.backFooterView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.backFooterView autoSetDimension:ALDimensionHeight toSize:70];
    
    [self.nextStepButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(32, 0, 9, 14) excludingEdge:ALEdgeLeft];
    [self.nextStepButton autoSetDimension:ALDimensionWidth toSize:85];
}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    NSLog(@"提交订单");
}

#pragma mark - 接口数据
// 获取订单中 可以使用积分 和 抵用现金
- (void) obtBookIntegralWithData:(NSString *)mobile stylistId:(NSString *)stylistId timeId:(NSString *)timeId comboId:(NSString *)comboId productIds:(NSString *)productIds userCouponId:(NSString *)userCouponId {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/obtBookIntegral"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"   , GetUserDefault(userUid)],//手机号
                       [NSString stringWithFormat:@"stylistId,%@", [self.makeAppointmentDic objectForKey:@"id"]],//设计师ID
                       [NSString stringWithFormat:@"timeId,%@"   , GetUserDefault(@"chooseStylistTimesId")],//预约时间ID
                       [NSString stringWithFormat:@"comboId,%@"   , comboId],//套餐ID
                       [NSString stringWithFormat:@"productIds,%@", self.productIDString],//产品ID 多个,隔开
                       [NSString stringWithFormat:@"userCouponId,%@", userCouponId],//用户优惠券ID
                       [NSString stringWithFormat:@"isAddOrder,%@", @"1"],
                       ];
    
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.integral = [resultObject objectForKey:@"integralMoney"];//integralMoney  积分兑换成现金的钱数
            
            [self.placeOrderTableView reloadData];
        }else {
            NSLog(@"book/obtBookIntegral%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/obtBookIntegral数据错误%@", error);
    }];
}

///book/calculateActivityFund   首单减免接口
- (void)bookCalculateActivityFund:(NSString *)comboId userCouponId:(NSString *)userCouponId{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/calculateActivityFund"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"      , GetUserDefault(userUid)],//手机号
                       [NSString stringWithFormat:@"stylistId,%@"   , [self.makeAppointmentDic objectForKey:@"id"]],//设计师ID
                       [NSString stringWithFormat:@"timeId,%@"      , GetUserDefault(@"chooseStylistTimesId")],//预约时间ID
                       [NSString stringWithFormat:@"comboId,%@"     , comboId],//套餐ID
                       [NSString stringWithFormat:@"productIds,%@"  , self.productIDString],//产品ID 多个,隔开
                       [NSString stringWithFormat:@"userCouponId,%@", userCouponId],//用户优惠券ID
                       [NSString stringWithFormat:@"fund,%@"        , self.deductibleTotalString],//金额
                       ];
    
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            BOOL isSuccess = [[resultObject objectForKey:@"isSuccess"] boolValue];
            if (isSuccess == TRUE) {
                self.deductibleTotalString = [resultObject objectForKey:@"errors"][0];
                [self titleWithName:self.deductibleTotalString];
                [self.placeOrderTableView reloadData];
            }
        }else {
            NSLog(@"book/calculateActivityFund数据错误%@", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/calculateActivityFund数据错误%@", error);
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
    return 4;
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
    if ([self.titleString isEqualToString:@"订单详情"]) {
        return section == 0 ? self.orderViewModel.OrderBookProducts.count + 2 : section == 3 ? 1 : section == 2 ? self.orderViewModel.orderPayMoney.intValue > 0 ? 1 : 2 : 3;
    }
    return section == 0 ? self.placeOrderArray.count + 2 : section == 3 ? 1 : 3;
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
    return indexPath.section == 0 ? [self classificationCellWithTableView:tableView cellForRowAtIndexPath:indexPath] : indexPath.section == 1 ? [self informationCellWithTableView:tableView cellForRowAtIndexPath:indexPath] : indexPath.section == 2 ? [self paymentCellWithTableView:tableView cellForRowAtIndexPath:indexPath] : [self depositCellWithTableView:tableView cellForRowAtIndexPath:indexPath];
}

/**
 *  分类view section == 0
 *
 *  @param tableView tableView
 *
 *  @return ClassificationTableViewCell
 */
- (UITableViewCell *) classificationCellWithTableView :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ClassificationTableViewCell *cell = [ClassificationTableViewCell classificationCellWithTableView:tableView forCellReuseIdentifier:cellClassificationID];
    cell.indexPath = indexPath;
    
    if ([self.titleString isEqualToString:@"订单详情"])  {
        cell.orderViewModel = self.orderViewModel;
    }else {
        if (indexPath.row != 0 && indexPath.row != self.placeOrderArray.count + 1) {
            cell.classificationStr = self.placeOrderArray[indexPath.row - 1];
        }
        if (indexPath.row == self.placeOrderArray.count + 1) {
            cell.classificationStr = [NSString stringWithFormat:@"%@", self.totalString];
        }
        cell.makeAppointmentDic = self.makeAppointmentDic;
    }
    
    return cell;
}

/**
 *  个人信息view section == 1
 *
 *  @param tableView tableView
 *
 *  @return InformationTableViewCell
 */
- (UITableViewCell *) informationCellWithTableView :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array1 = @[@"用户昵称", @"预约时间", @"服务门店"];
    
    NSArray *array2 = [self informationCellNameStr];
    
    InformationTableViewCell *cell = [InformationTableViewCell informationCellWithTableView:tableView forCellReuseIdentifier:cellInformationID];
    cell.indexPath = indexPath;
    cell.titleStr = array1[indexPath.row];
    if ([self.titleString isEqualToString:@"订单详情"])  {
        array2 = @[self.orderViewModel.orderName, self.orderViewModel.orderAppointTimes, [self.orderViewModel.Orderstudio objectForKey:@"names"]];
    }
    cell.nameStr  = array2[indexPath.row];
    return cell;
}

- (NSArray *)informationCellNameStr {
    
    NSString *nameStr = [GetUserDefault(@"getUserinfo") objectForKey:@"userName"];
    nameStr = nameStr != nil ? nameStr : @"没有编辑昵称";
    
    NSString *timeStr = GetUserDefault(@"makeTime") != nil ? GetUserDefault(@"makeTime") : @"未成功选择时间";
    
    NSString *addStr  = [[self.makeAppointmentDic objectForKey:@"studio"] objectForKey:@"names"] != nil ? [[self.makeAppointmentDic objectForKey:@"studio"] objectForKey:@"names"] : @"没有地址";
    
    NSArray *array = @[nameStr, timeStr, addStr];
    return array;
}

/**
 *  支付view section == 2
 *
 *  @param tableView tableView
 *
 *  @return PaymentTableViewCell
 */
- (UITableViewCell *) paymentCellWithTableView :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *integralStr = @"0";////当前用的可用积分

    integralStr =  self.integral.integerValue > 0 ? [NSString stringWithFormat:@"可用积分%@0抵 ￥%@", self.integral, self.integral] : @"无可用积分";
    
    NSArray *arrayTitleStr     = @[@"优惠劵", integralStr, @"实付金额"];
    NSArray *arrayNameStr      = [self paymentCellNameStr];
    
    PaymentTableViewCell *cell = [PaymentTableViewCell paymentCellWithTableView:tableView forCellReuseIdentifier:cellPaymentID];
    
    if ([self.titleString isEqualToString:@"订单详情"]){
        arrayTitleStr          = self.orderViewModel.orderPayMoney.intValue > 0 ?  @[@"订单金额"] : @[@"积分抵扣", @"订单金额"];
        arrayNameStr           = self.orderViewModel.orderPayMoney.intValue > 0 ? @[[NSString stringWithFormat:@"￥%@", self.orderViewModel.orderPayMoney]]: @[[NSString stringWithFormat:@"-￥%@", self.orderViewModel.orderIntegralMoney], [NSString stringWithFormat:@"￥%@", self.orderViewModel.orderPayMoney]];
    }else {
        if (indexPath.row      == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//箭头
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;//没有任何的样式
        }
    }
    
    cell.titleString           = self.titleString;
    cell.titleStr              = arrayTitleStr[indexPath.row];
    cell.nameStr               = arrayNameStr[indexPath.row];
    cell.indexPath             = indexPath;
    cell.delegate              = self;
    
    return cell;
}

- (NSArray *)paymentCellNameStr {
    NSString *couponValues = [self.makeAppointmentDic objectForKey:@"couponValues"];
    couponValues           = couponValues != nil ? [NSString stringWithFormat:@"%@张优惠劵", couponValues] : @"0张优惠劵";
    
    NSArray *array         = @[couponValues, @"", [NSString stringWithFormat:@"￥%@", self.deductibleTotalString]];
    return array;
}

/**
 *  定金view section == 3
 *
 *  @param tableView tableView
 *
 *  @return DepositTableViewCell
 */
- (UITableViewCell *) depositCellWithTableView :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DepositTableViewCell *cell = [DepositTableViewCell depositCellWithTableView:tableView forCellReuseIdentifier:cellDepositID];
    cell.totalString           = [NSString stringWithFormat:@"%d", self.deductibleTotalString.intValue - 50];
    cell.delegate              = self;
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
    
    if (indexPath.section == 3) {
        if (!(self.deductibleTotalString.intValue > 0)) {
            return 0;
        }
    }
    return 45;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 10;
}

#pragma mark - 所有cell 代理

/**
 *  提价订单积分抵扣 - 代理         点击积分抵扣  传递抵扣金额
 *
 *  @param paymentTableViewCell PaymentTableViewCellDelegate
 *  @param deductibleStr        抵扣金额
 *  @param selectedBool         是否选择
 */
- (void)paymentTableViewCell:(PaymentTableViewCell *)paymentTableViewCell deductibleStr:(NSString *)deductibleStr selectedBool:(BOOL)selectedBool{
    if (selectedBool) {
        self.deductibleTotalString = [NSString stringWithFormat:@"%d",self.deductibleTotalString.intValue - deductibleStr.intValue];
        if (!self.selectedBool) {
            [self titleWithName:self.deductibleTotalString];
        }
        [self.placeOrderTableView reloadData];
    }else {
        self.deductibleTotalString = [NSString stringWithFormat:@"%d",self.deductibleTotalString.intValue + deductibleStr.intValue];
        if (!self.selectedBool) {
            [self titleWithName:self.deductibleTotalString];
        }
        [self.placeOrderTableView reloadData];
    }
}


/**
 *  提交订单 仅支付定金 cell 代理   选择 - 只支付50元   不选择不改变原有金额
 *
 *  @param depositTableViewCell DepositTableViewCell
 *  @param selectedBool         是否选择
 */
- (void) depositTableViewCell:(DepositTableViewCell *)depositTableViewCell selectedBool:(BOOL)selectedBool {
    if (!selectedBool) {
        self.selectedBool = false;
        [self titleWithName:self.deductibleTotalString];
    }else {
        self.selectedBool = true;
        [self titleWithName:@"50"];
    }
}

#pragma mark   -  所有控件懒加载
- (UITableView *) placeOrderTableView {
    if (!_placeOrderTableView) {
        _placeOrderTableView                 = [[UITableView alloc] initForAutoLayout];
        _placeOrderTableView.delegate        = self;
        _placeOrderTableView.dataSource      = self;
        //        _makeAppointmentTableView.scrollEnabled  = NO; //设置tableview 不能滚动
        [_placeOrderTableView registerClass:[ClassificationTableViewCell class] forCellReuseIdentifier:cellClassificationID];
        [_placeOrderTableView registerClass:[InformationTableViewCell class] forCellReuseIdentifier:cellInformationID];
        [_placeOrderTableView registerClass:[PaymentTableViewCell class] forCellReuseIdentifier:cellPaymentID];
        [_placeOrderTableView registerClass:[DepositTableViewCell class] forCellReuseIdentifier:cellDepositID];
        
        [_placeOrderTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];//隐藏多余的cell
    }
    return _placeOrderTableView;
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
        _nextStepButton.layer.borderColor = [UIColor redColor].CGColor;
        [_nextStepButton.layer setCornerRadius:2];
        [_nextStepButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_nextStepButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_nextStepButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepButton;
}

- (UILabel *) totalLable {
    if (!_totalLable) {
        _totalLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, SCREEN_WIDTH - 150, 22)];
        [self titleWithName:self.deductibleTotalString];
    }
    return _totalLable;
}


//文字颜色
- (void) titleWithName:(NSString *)str {
    NSString *string = [NSString stringWithFormat:@"待支付金额:￥%@", str];
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:string];
    [hintString addAttribute:NSForegroundColorAttributeName value:Color(64, 64, 64, 1) range:NSMakeRange(0, 6)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, str.length + 1)];
    _totalLable.attributedText = hintString;
}


@end
