//
//  ServiceClassificationViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/9.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 预约美发服务分类控制器

#import "ServiceClassificationViewController.h"
// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "ServiceClassificationTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "ChooseTimeModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"ServiceClassificationTableViewCellID";

@interface ServiceClassificationViewController ()<UITableViewDelegate, UITableViewDataSource, ServiceClassificationTableViewCellDelegate> {
    /**   tableview 的 y 点*/
    CGFloat  tableviewHeight;
}

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 选项背景视图*/
@property (nonatomic, strong) UIView             *backView;
/** 选项类别视图*/
@property (nonatomic, strong) UILabel            *titleLable;
/** 取消按钮*/
@property (nonatomic, strong) UIButton           *cancelButton;
/** 确定按钮*/
@property (nonatomic, strong) UIButton           *determineButton;
/** 选项视图*/
@property (nonatomic, strong) UITableView        *serviceClassificationTableView;
/** 长发，中发，短发*/
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 记录所有被选择的发型分类名称-长短-价钱*/
@property (nonatomic, strong) NSMutableArray *productSelectArray;
/** 产品ID数组*/
@property (nonatomic, strong) NSMutableArray *productArrayArrayId;
/** 产品价钱数组*/
@property (nonatomic, strong) NSMutableArray *productArrayMoney;
/** 确定选项按钮*/
@property (nonatomic, strong) NSMutableArray *buttonArray;

@property (nonatomic, strong) NSArray        *serviceClassificationArray;
/** 被选择的发型分类名称-长短-价钱*/
@property (nonatomic, copy) NSString *productSelectStr;
/** 记录发型长短分类*/
@property (nonatomic, copy) NSString *selectedSegmentStr;
/** 产品ID*/
@property (nonatomic, copy) NSString *productIdModal;
/** 选择产品名称产品*/
@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *selectedOK;
@end

@implementation ServiceClassificationViewController

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
    self.productSelectArray = [NSMutableArray array];
    self.productArrayArrayId = [NSMutableArray array];
    self.productArrayMoney = [NSMutableArray array];
    //1-烫发 2-染发 3－护理 4- 养发 7-洗色  8 - 接发-
    switch (self.productType.intValue) {
        case 1:
            self.selectedSegmentStr = @"烫发";
            break;
        case 2:
            self.selectedSegmentStr = @"染发";
            break;
        case 3:
            self.selectedSegmentStr = @"护理";
            break;
        case 4:
            self.selectedSegmentStr = @"养发";
            break;
        case 7:
            self.selectedSegmentStr = @"洗色";
            break;
        case 8:
            self.selectedSegmentStr = @"接发";
            break;
            
        default:
            break;
    }
    [self bookgetProductInfosWithData:self.productClas];
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

    [self setNavWithLeftBarButton:NO title:self.titleName];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.backView];
    [self.view addSubview:self.titleLable];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.determineButton];
    
    [self.backView addSubview:self.serviceClassificationTableView];
    [self.backView addSubview:self.segmentedControl];
    
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {

}

// 获取门店数据接口
- (void) bookgetProductInfosWithData: (NSString *)productClas{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/getProductInfos"];
    //设计师预约套餐接口，门店不可选择,返回数据格式参考测试结果,返回数据为空时,返回[]
    NSArray *array = @[
                       [NSString stringWithFormat:@"stylistinfoId,%@", self.stylistinfoId],//设计师ID
                       [NSString stringWithFormat:@"productType,%@"  , self.productType],//产品类型 1-烫发 2-染发 3－护理 4- 养发
                       [NSString stringWithFormat:@"productClas,%@"  , productClas],//发型分类 11烫发（长发） 12烫发（中发）13(短发) 21染发（长） 22染发（中） 23染发（短） 31、护理 41、养发
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            self.buttonArray                = [[NSMutableArray array] init];
            self.serviceClassificationArray = [self productInfosDispose:resultObject];
            self.productArrayArrayId        = [[NSMutableArray array] init];
            self.productArrayMoney          = [[NSMutableArray array] init];
            
            for (int i = 0; i < self.serviceClassificationArray.count; i ++) {
                ChooseTimeModel *model = self.serviceClassificationArray[i];
                [self.productArrayArrayId addObject:@"-1"];
                [self.productArrayMoney   addObject:@"-1"];
                if (model.productId.intValue == self.productId.intValue) {
                    [self.buttonArray addObject:@"2"];
                    
                }else {
                    [self.buttonArray addObject:@"1"];
                }
            }
            self.productSelectArray = self.buttonArray;
            
            [self.serviceClassificationTableView reloadData];
        }else {
            NSLog(@"book/getProductInfos%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/getProductInfos数据错误%@", error);
    }];
}

- (NSMutableArray *) productInfosDispose:(NSArray *)param {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary * dict in param) {
        ChooseTimeModel *model = [ChooseTimeModel productInfosWithDict:dict];
        [array addObject:model];
    }
    return array;
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
    return 1;
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
    
    return self.serviceClassificationArray.count;
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
    
    ChooseTimeModel *model      = self.serviceClassificationArray[indexPath.row];
    ServiceClassificationTableViewCell *cell    = [ServiceClassificationTableViewCell serviceClassificationCellWithTableView:tableView forCellReuseIdentifier:cellID];
    cell.delegate               = self;
    cell.model                  = model;
    cell.indexPath              = indexPath;
    cell.btnSele                = self.buttonArray[indexPath.row];
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
    return 45 ;
}

/**
 *  ServiceClassificationTableViewCell
 *
 *  @param serviceClassificationTableViewCell ServiceClassificationTableViewCell
 *  @param indexPath                          所选indexPath
 */
- (void)serviceClassificationTableViewCell:(ServiceClassificationTableViewCell *)serviceClassificationTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath btnSelected:(NSString *)btnSelected;{
    //btnSelected  0选中       1未选中
    
    ChooseTimeModel *model             = self.serviceClassificationArray[indexPath.row];
    if (self.productType.intValue == 4 || self.productType.intValue == 3 || self.productType.intValue == 8) {
        
        self.productSelectStr          = [NSString stringWithFormat:@"%@-￥%@", model.productName, model.price];
    }else {
        self.productSelectStr          = [NSString stringWithFormat:@"%@(%@)-￥%@", model.productName , self.selectedSegmentStr, model.price];
    }
    
    NSLog(@"%@", self.productSelectStr);
    
    if (btnSelected.intValue == 1) {
        
        [self.productArrayArrayId replaceObjectAtIndex:indexPath.row withObject:@"-1"];
        [self.productArrayMoney replaceObjectAtIndex:indexPath.row withObject:@"-1"];
        
        [self.buttonArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
        [self.productSelectArray replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }else {
        self.productName        = model.productName;
        self.selectedOK         = self.selectedSegmentStr;
        self.productIdModal     = model.productId;
        self.productId          = model.productId;
        [self.buttonArray replaceObjectAtIndex:indexPath.row withObject:self.productSelectStr];
        [self.productArrayArrayId replaceObjectAtIndex:indexPath.row withObject:model.productId];
        [self.productArrayMoney replaceObjectAtIndex:indexPath.row withObject:model.price];
        
    }
    [self.serviceClassificationTableView reloadData];

}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    NSLog(@"产品类型 1-烫发 2-染发 3－护理 4- 养发 7-洗色  8 - 接发------%@", self.productType);
    NSLog(@"记录发型长短分类                           ------ %@", self.selectedSegmentStr);
    NSLog(@"产品ID数组                                ------%@", self.productArrayArrayId);
    NSLog(@"产品价钱数组                               ------- %@", self.productArrayMoney);
    NSLog(@"记录所有被选择的发型分类名称-长短-价钱         -------- %@", self.productSelectArray);
    
    NSMutableArray *arrayIDs = [NSMutableArray array];
    NSMutableArray *arrayMoneys = [NSMutableArray array];
    for (int i = 0; i < self.productArrayArrayId.count; i ++) {
        if ([self.productArrayArrayId[i] intValue] > 0) {
            [arrayIDs    addObject:self.productArrayArrayId[i]];
            [arrayMoneys addObject:self.productArrayMoney[i]];
        }
    }
    
    self.productArrayArrayId = arrayIDs;
    self.productArrayMoney   = arrayMoneys;
    
    if (self.selectedOK != nil) {
        if (button.tag == 2) {
            if ([self.delegate respondsToSelector:@selector(serviceClassificationViewController:productSelectArray:productType:selectedSegmentStr:productArrayArrayId:productName:productArrayMoney:)]) {
                [self.delegate serviceClassificationViewController:self productSelectArray:self.productSelectArray productType:self.productType selectedSegmentStr:self.selectedOK productArrayArrayId:self.productArrayArrayId productName:self.productName productArrayMoney:self.productArrayMoney];
            }
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 实现oneSegmentedControl的监听事件
- (void)segmentedControlAction:(UISegmentedControl *) sender {
    // 获取当前的选中项的索引值
    NSUInteger index = sender.selectedSegmentIndex;
    self.productSelectArray = self.buttonArray;
    switch (self.productType.intValue) {
        case 1:
        {
            switch (index) {
                case 0:
                    self.selectedSegmentStr = @"烫发";
                    [self bookgetProductInfosWithData:@"11"];
                    break;
                case 1:
                    self.selectedSegmentStr = @"局部烫发";
                    [self bookgetProductInfosWithData:@"12"];
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (index) {
                case 0:
                    self.selectedSegmentStr = @"短发";
                    [self bookgetProductInfosWithData:@"22"];
                    break;
                case 1:
                    self.selectedSegmentStr = @"长发";
                    [self bookgetProductInfosWithData:@"21"];
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 7:
        {
            switch (index) {
                case 0:
                    self.selectedSegmentStr = @"短发";
                    [self bookgetProductInfosWithData:@"52"];
                    break;
                case 1:
                    self.selectedSegmentStr = @"长发";
                    [self bookgetProductInfosWithData:@"51"];
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark  -  所有控件懒加载
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, SCREEN_WIDTH, SCREEN_HEIGHT - 135)];
        _backView.backgroundColor        = [UIColor whiteColor];
        _backView.tag                    = 1001;
    }
    return _backView;
}

- (UITableView *)serviceClassificationTableView {
    if (!_serviceClassificationTableView) {
        _serviceClassificationTableView                   = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 115)];
        _serviceClassificationTableView.delegate          = self;
        _serviceClassificationTableView.dataSource        = self;
        _serviceClassificationTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _serviceClassificationTableView.tableFooterView   = [[UIView alloc]init];
        _serviceClassificationTableView.backgroundColor   = [UIColor clearColor];
        [_serviceClassificationTableView registerClass:[ServiceClassificationTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _serviceClassificationTableView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 55, SCREEN_WIDTH, 55)];
        _titleLable.backgroundColor = [UIColor whiteColor];
    }
    return _titleLable;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 170, SCREEN_HEIGHT - 45, 70, 35)];
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.tag               = 1;
        _cancelButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_cancelButton.layer setCornerRadius:2];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)determineButton {
    if (!_determineButton) {
        _determineButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, SCREEN_HEIGHT - 45, 70, 35)];
        _determineButton.layer.borderWidth = 1;
        _determineButton.tag               = 2;
        _determineButton.layer.borderColor = [UIColor redColor].CGColor;
        [_determineButton.layer setCornerRadius:2];
        [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_determineButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineButton;
}

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl                       = [[UISegmentedControl alloc] initWithItems:@[@"长发", @"中发"]];//[[UISegmentedControl alloc] initWithItems:@[@"长发", @"中发", @"短发"]];
        _segmentedControl.frame                 = CGRectMake(30, 3, SCREEN_WIDTH - 60, 40);
        _segmentedControl.tintColor             = [UIColor redColor]; // 选中的颜色
        _segmentedControl.backgroundColor       = [UIColor whiteColor];
        _segmentedControl.layer.borderColor     = [UIColor redColor].CGColor;
        _segmentedControl.momentary             = NO; // 设置点击后是否恢复原样, 默认是NO， 不恢复
        _segmentedControl.selectedSegmentIndex  = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}


#pragma mark - 修改UISegmentedControl控件的高度 和显示
- (void) setProductClas:(NSString *)productClas {
    _productClas = productClas;
    
    if (_productClas.intValue == 31 || _productClas.intValue == 41 || _productClas.intValue == 61) {
        self.segmentedControl.hidden                = YES;
        self.serviceClassificationTableView.frame   = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 115);
    }else {
        self.segmentedControl.hidden                = NO;
        self.serviceClassificationTableView.frame   = CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT - 115);
    }
    
    
}

- (void) setProductClasBtn:(BOOL)productClasBtn {
    _productClasBtn = productClasBtn;
    if (_productClasBtn) {
        self.segmentedControl.hidden    = NO;
        tableviewHeight                 = 85;
    }else {
        self.segmentedControl.hidden    = YES;
        tableviewHeight                 = 45;
    }
}

/** 产品类型 1-烫发 2-染发 3－护理 4- 养发 7- 洗色*/
- (void) setProductType:(NSString *)productType {
    _productType = productType;
    switch (_productType.intValue) {
        case 1:
            [self.segmentedControl setTitle:@"烫发" forSegmentAtIndex:0];
            [self.segmentedControl setTitle:@"局部烫发" forSegmentAtIndex:1];
            break;
        case 2:
            [self.segmentedControl setTitle:@"短发" forSegmentAtIndex:0];
            [self.segmentedControl setTitle:@"长发" forSegmentAtIndex:1];
            break;
        case 7:
            [self.segmentedControl setTitle:@"短发" forSegmentAtIndex:0];
            [self.segmentedControl setTitle:@"长发" forSegmentAtIndex:1];
            break;
            
        default:
            break;
    }
    
}



@end
