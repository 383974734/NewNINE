//
//  OrderViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器 --订单

#import "OrderViewController.h"

// ---------------------- 框架工具类 ----------------------
#include <HTHorizontalSelectionList/HTHorizontalSelectionList.h>  // 分类显示
#import "UIViewController+LewPopupViewController.h"             // 弹出视图框架
#import "LewPopupViewAnimationFade.h"                           // 弹出视图框架
#import "LewPopupViewAnimationSlide.h"                          // 弹出视图框架
#import "LewPopupViewAnimationSpring.h"                         // 弹出视图框架
#import "LewPopupViewAnimationDrop.h"                           // 弹出视图框架
#import "AlertViewView.h"
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "MyEvaluationViewController.h"
#import "PlaceOrderViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "OrderTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "OrderViewModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"orderTableViewCellID";

@interface OrderViewController ()<UITableViewDelegate, UITableViewDataSource, HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate, OrderTableViewCellDelegate, AlertViewViewDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 订单 展示控件*/
@property (nonatomic, strong) UITableView   *orderTableView;
/** 显示分类的View */
@property (strong, nonatomic) HTHorizontalSelectionList *hTHorizontalSelectionList;
@property (strong, nonatomic) AlertViewView *alerViewView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 订单 数据*/
@property (nonatomic, strong)NSMutableArray *orderArray;
@end

@implementation OrderViewController


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
    indexPage = 1;
    self.orderArray  = [NSMutableArray array];
    [self getOrdersCollectsWithData:[NSString stringWithFormat:@"%ld", (long)indexPage]];
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
    
    [self setNavWithLeftBarButton:NO title:@"我的美单"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.hTHorizontalSelectionList];
    [self.view addSubview:self.orderTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.orderTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(110, 0, 0, 0)];
}

#pragma mark - 接口数据
// 我的订单数据接口
- (void) getOrdersCollectsWithData:(NSString *)page{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"order/getOrders"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , GetUserDefault(userUid)],
                       [NSString stringWithFormat:@"page,%@"    , page],
                       [NSString stringWithFormat:@"status,%@"  , self.strID],//状态 空 或者 0 是全部 1未支付 2已支付 6订单完成 7 退款
                        //状态 空是全部 1待付款 2预约成功 10订单完成 11 退款
                       ];
//    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([page isEqualToString:@"1"]) {
                [self.orderArray removeAllObjects];
            }
            self.orderArray = [self ordersDispose:resultObject];
            [self.orderTableView reloadData];
        }else {
            NSLog(@"order/getOrders%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"order/getOrders数据错误%@", error);
    }];
}

- (NSMutableArray *) ordersDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.orderArray page:indexPage firstPage:1];
        for (NSDictionary * dict in param) {
            OrderViewModel *model = [OrderViewModel orderWithDict:dict];
            [array addObject:model];
        }
    return array;
}

// 退款接口
- (void) getRefundOrderWithData:(NSString *)reason orderId:(NSString *)orderId {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"order/refundOrder"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , GetUserDefault(userUid)],//手机号
                       [NSString stringWithFormat:@"orderId,%@" , orderId],//订单ID
                       [NSString stringWithFormat:@"reason,%@"  , reason],//退款原因
                       ];
//    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            [SVProgressHUD showInfoWithStatus:@"退款申请发送成功"];
            [self getOrdersCollectsWithData:@"1"];
        }else {
            NSLog(@"order/refundOrder%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"order/refundOrder数据错误%@", error);
    }];
}

//取消退款
- (void) getCancleRefundOrderWithData:(NSString *)orderId {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"order/cancleRefundOrder"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , GetUserDefault(userUid)],//手机号
                       [NSString stringWithFormat:@"orderId,%@" , orderId],//订单ID
                       ];
    //    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        //        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            [SVProgressHUD showInfoWithStatus:@"取消退款申请发送成功"];
            [self getOrdersCollectsWithData:@"1"];
        }else {
            NSLog(@"order/refundOrder%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"order/refundOrder数据错误%@", error);
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
    return self.orderArray.count;
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
    
    return 1;
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
    OrderViewModel *model = self.orderArray[indexPath.section];
    OrderTableViewCell *cell = [OrderTableViewCell orderCellWithTableView:tableView forCellReuseIdentifier:cellID];
    cell.delegate = self;
    cell.index = indexPath;
    cell.dataModel = model;
    return cell;
}

/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderViewModel *model = self.orderArray[indexPath.section];
    
    PlaceOrderViewController *viewController = [[PlaceOrderViewController alloc] init];
    viewController.titleString               = @"订单详情";
    viewController.orderViewModel            = model;
    [self.navigationController pushViewController:viewController animated:YES];
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
    OrderViewModel *model = self.orderArray[indexPath.section];
    
    if (model.orderStatus.intValue == 7) {
       return 190 ;
    }else {
        return 190 + model.OrderBookProducts.count * 30 ;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 10;
}


/**
 *  通过点击的按钮来确定出现的弹出框
 *
 *  @param orderTableViewCell OrderTableViewCell
 *  @param title              button的title
 */
- (void)orderTableViewCell:(OrderTableViewCell *)orderTableViewCell buttonWithTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath{
    NSLog(@"buttonWithTitle ------- %@", title);
    self.alerViewView = [AlertViewView popupView];
    self.alerViewView.index = indexPath;
    self.alerViewView.delegate = self;
    OrderViewModel *model = self.orderArray[indexPath.section];
    if ([title isEqualToString:@"查看评价"]) {
        NSLog(@"跳页");
        MyEvaluationViewController *viewController = [[MyEvaluationViewController alloc] init];
        viewController.orderId = [NSString stringWithFormat:@"%@", model.orderOrderId];
        [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    if ([title isEqualToString:@"去支付"]) {
        NSLog(@"跳页");
        return;
    }
    if ([title isEqualToString:@"去评价"]) {
        NSLog(@"跳页");
        return;
    }
    if ([title isEqualToString:@"取消退款"]) {
        [self.alerViewView setAlertView:@"温馨提示" textfileWithHidden:YES nameLable:@"是否确认取消退款？" leftButton:@"确定" rightButton:@"取消"];
    }
    if ([title isEqualToString:@"退款"]) {
        [self.alerViewView setAlertView:@"订单退款" textfileWithHidden:NO nameLable:@"请输入退款原因" leftButton:@"确定" rightButton:@"取消"];
    }
    [self lew_presentPopupView:self.alerViewView animation:[LewPopupViewAnimationSpring new] dismissed:^{
        NSLog(@"动画结束");
    }];
}

#pragma mark - AlertViewViewDelegate
- (void)alertViewView:(AlertViewView *)alertViewView buttonWithTag:(NSInteger)buttonWithTag textViewStr:(NSString *)textViewStr indexPath:(NSIndexPath *)indexPath{
    OrderViewModel *model = self.orderArray[indexPath.section];
    if (buttonWithTag == 0) {
        NSLog(@"走接口");
        if (textViewStr.length > 0) {
           [self getRefundOrderWithData:textViewStr orderId:model.orderOrderId];
        }
        [self getCancleRefundOrderWithData:model.orderOrderId];
        
    }
    [self lew_dismissPopupView];
}

#pragma mark HTHorizontalSelectionList dataSource
/**
 *  HTHorizontalSelectionList  数据源方法（设置分类显示的数据个数）
 *
 *  @param selectionList
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return 5;
}

/**
 *  HTHorizontalSelectionList  数据源方法（设置分类显示的数据内容）
 *
 *  @param selectionList
 *  @param index
 *
 *  @return NSString
 */
- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    NSArray *array = @[@"全部", @"未支付", @"已支付", @"已完成", @"退款"];
    NSString *str = array[index];
    return str;
}

#pragma mark HTHorizontalSelectionList delegate
/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    //状态 空 或者 0 是全部 1未支付 2已支付 6订单完成 7 退款
    switch (index) {
        case 0:
            self.strID = @"0";
            break;
        case 1:
            self.strID = @"1";
            break;
        case 2:
            self.strID = @"2";
            break;
        case 3:
            self.strID = @"6";
            break;
        case 4:
            self.strID = @"7";
            break;
            
        default:
            break;
    }
    index = 1;
    ////状态 空是全部 1待付款 2预约成功 10订单完成 11 退款
    [self getOrdersCollectsWithData:[NSString stringWithFormat:@"%ld", (long)index]];
}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    
}

#pragma mark - 下拉刷新 -- 上拉加载
/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) headerRereshingData {
    indexPage = 1;
    [self getOrdersCollectsWithData:[NSString stringWithFormat:@"%ld", (long)indexPage]];
    [self.orderTableView.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingData {
    indexPage++;
    [self getOrdersCollectsWithData:[NSString stringWithFormat:@"%ld", (long)indexPage]];
    [self.orderTableView.mj_footer endRefreshing];
}

#pragma mark   -  所有控件懒加载
- (UITableView *) orderTableView {
    if (!_orderTableView) {
        _orderTableView                  = [[UITableView alloc] initForAutoLayout];
        _orderTableView.delegate         = self;
        _orderTableView.dataSource       = self;
        _orderTableView.separatorStyle   = NO;//cell线隐藏
        [_orderTableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:cellID];
        [self settingTableViewRefreshing:_orderTableView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
        [_orderTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];//隐藏多余的cell
//        _orderTableView.estimatedRowHeight = 200;
//        _orderTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _orderTableView;
}


#pragma mark 所有控件的懒加载
- (HTHorizontalSelectionList *) hTHorizontalSelectionList {
    
    if (!_hTHorizontalSelectionList) {
        _hTHorizontalSelectionList            = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, 45)];
        
        _hTHorizontalSelectionList.delegate   = self;
        _hTHorizontalSelectionList.dataSource = self;
        _hTHorizontalSelectionList.centerAlignButtons = YES;
        [_hTHorizontalSelectionList setTitleFont:SWP_SYSTEM_FONT_SIZE(18) forState:UIControlStateNormal];
        [_hTHorizontalSelectionList setTitleFont:SWP_SYSTEM_FONT_SIZE(16) forState:UIControlStateSelected];
        _hTHorizontalSelectionList.selectionIndicatorColor = [UIColor redColor];
        [_hTHorizontalSelectionList setTitleFont:[UIFont systemFontOfSize:14] forState:UIControlStateNormal];
    }
    return _hTHorizontalSelectionList;
}

- (void) setStrID:(NSString *)strID {
    _strID = strID;
    ////状态 空 或者 0 是全部 1未支付 2已支付 6订单完成 7 退款
    switch (_strID.intValue) {
        case 0:
            self.hTHorizontalSelectionList.selectedButtonIndex = 0;
            break;
        case 1:
            self.hTHorizontalSelectionList.selectedButtonIndex = 1;
            break;
        case 2:
            self.hTHorizontalSelectionList.selectedButtonIndex = 2;
            break;
        case 6:
            self.hTHorizontalSelectionList.selectedButtonIndex = 3;
            break;
        case 7:
            self.hTHorizontalSelectionList.selectedButtonIndex = 4;
            break;
            
        default:
            break;
    }
}

@end
