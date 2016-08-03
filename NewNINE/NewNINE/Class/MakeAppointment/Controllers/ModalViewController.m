//
//  ModalViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/4.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ModalViewController.h"

// ---------------------- 框架工具类   ----------------------
// ---------------------- 框架工具类   ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "ModalTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "ChooseTimeModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"ModalTableViewCellID";

@interface ModalViewController ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, ModalTableViewCellDelegate>
{
    /**   tableview 的 y 点*/
    CGFloat  tableviewHeight;
}

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 选项背景视图*/
@property (nonatomic, strong) UIView *backView;
/** 选项类别视图*/
@property (nonatomic, strong) UILabel *titleLable;
/** 取消按钮*/
@property (nonatomic, strong) UIButton *cancelButton;
/** 确定按钮*/
@property (nonatomic, strong) UIButton *determineButton;
/** 长发，中发，短发*/
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

/** 选项视图*/
@property (nonatomic, strong) UITableView *modalTableView;
/** 长发，中发，短发 高变化值*/
@property (nonatomic, strong) NSLayoutConstraint *segmentedControlFrame;
/** 选项 高变化值*/
@property (nonatomic, strong) NSLayoutConstraint *modalTableViewFrame;
#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
@property (nonatomic, strong) NSArray *modalArray;
/** 确定选项按钮*/
@property (nonatomic, strong) NSMutableArray *buttonArray;
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

@implementation ModalViewController


#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建 单个手指单次点击 手势对象
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    singleTapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
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
    self.selectedSegmentStr = @"长发";
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

}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.modalTableView];
    [self.backView addSubview:self.titleLable];
    [self.backView addSubview:self.cancelButton];
    [self.backView addSubview:self.determineButton];
    [self.backView addSubview:self.segmentedControl];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 15, 0, 15) excludingEdge:ALEdgeBottom];
    [self.titleLable autoSetDimension:ALDimensionHeight toSize:25];
    
    [self.segmentedControl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLable withOffset:10];
    [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    self.segmentedControlFrame = [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.determineButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.modalTableView withOffset:10];
    [self.determineButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.determineButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.determineButton autoSetDimension:ALDimensionWidth toSize:70];
    [self.determineButton autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.cancelButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.cancelButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.determineButton withOffset:-10];
    [self.cancelButton autoSetDimension:ALDimensionWidth toSize:70];
    [self.cancelButton autoSetDimension:ALDimensionHeight toSize:30];
    
}
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
    // 处理单次点击事件
    [self dismissViewControllerAnimated:YES completion:^{
        [SVProgressHUD dismiss];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView* touchedView = [touch view];
    if(touchedView.tag == 1001) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    // 处理单次点击事件
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", self.productSelectStr);
        NSLog(@"%@", self.productType);
        NSLog(@"%@", self.selectedSegmentStr);
        NSLog(@"%@", self.productIdModal);
        NSLog(@"%@", self.selectedOK);
        if (self.selectedOK != nil) {
            if (button.tag == 2) {
                if ([self.delegate respondsToSelector:@selector(modalViewController:didSelectStr:productType:selectedSegmentStr:productId:productName:)]) {
                    [self.delegate modalViewController:self didSelectStr:self.productSelectStr productType:self.productType selectedSegmentStr:self.selectedOK productId:self.productIdModal productName:self.productName];
                }
            }
        }
    }];
}

#pragma mark - 实现oneSegmentedControl的监听事件
- (void)segmentedControlAction:(UISegmentedControl *) sender {
    // 获取当前的选中项的索引值
    NSUInteger index = sender.selectedSegmentIndex;
    // 判断索引值
    switch (index) {
        case 0:
            
        {
            NSLog(@"第一项被选中");
            self.selectedSegmentStr = @"长发";
            if (self.productType.intValue == 1) {
               [self bookgetProductInfosWithData:@"11"];
            }else {
                [self bookgetProductInfosWithData:@"21"];
            }
        }
            break;
        case 1:
        {
            NSLog(@"第二项被选中");
            self.selectedSegmentStr = @"中发";
            if (self.productType.intValue == 1) {
                [self bookgetProductInfosWithData:@"12"];
            }else {
                [self bookgetProductInfosWithData:@"22"];
            }
        }
            break;
        case 2:
        {
            NSLog(@"第三项被选中");
            self.selectedSegmentStr = @"短发";
            if (self.productType.intValue == 1) {
                [self bookgetProductInfosWithData:@"13"];
            }else {
                [self bookgetProductInfosWithData:@"23"];
            }
        }
            break;
        default:
            break;
    }
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

            self.modalArray              = [self productInfosDispose:resultObject];
            
            if (tableviewHeight == 45) {
               self.backView.frame       = CGRectMake(0, SCREEN_HEIGHT - 95 - (self.modalArray.count * 45), SCREEN_WIDTH, 95 + self.modalArray.count * 45);
            }else {
                self.backView.frame      = CGRectMake(0, SCREEN_HEIGHT - 130 - (self.modalArray.count * 45), SCREEN_WIDTH, 130 + self.modalArray.count * 45);
            }
            self.modalTableView.frame    = CGRectMake(-1, tableviewHeight, SCREEN_WIDTH + 2, self.modalArray.count * 45);
            self.modalTableView.layer.borderWidth = 0.3;
            self.buttonArray             = [[NSMutableArray array] init];
            
            
            for (int i = 0; i < self.modalArray.count; i ++) {
                ChooseTimeModel *model = self.modalArray[i];
                if (model.productId.intValue == self.productId.intValue) {
                    [self.buttonArray addObject:@"2"];
                }else {
                    [self.buttonArray addObject:@"1"];
                }
            }

            [self.modalTableView reloadData];
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

    return self.modalArray.count;
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
    ChooseTimeModel *model      = self.modalArray[indexPath.row];
    ModalTableViewCell *cell    = [ModalTableViewCell modalTableViewCellWithTableView:tableView forCellReuseIdentifier:cellID];
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

- (void)modalTableViewCell:(ModalTableViewCell *)modalTableViewCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseTimeModel *model             = self.modalArray[indexPath.row];
    if (self.productType.intValue == 3 || self.productType.intValue == 4) {
        
        self.productSelectStr          = [NSString stringWithFormat:@"%@ ￥%@", model.productName, model.price];
    }else {
        self.productSelectStr          = [NSString stringWithFormat:@"%@ - %@ ￥%@", model.productName , self.selectedSegmentStr, model.price];
    }
    
    NSLog(@"%@", self.productSelectStr);
    
    for (int i = 0; i < self.buttonArray.count; i ++) {
        [self.buttonArray replaceObjectAtIndex:i withObject:@"1"];
    }
    if (self.productId.intValue == model.productId.intValue) {
        self.productName        = @"";
        self.productIdModal     = @"";
        self.productId          = @"";
        self.productSelectStr   = @"";
        self.selectedOK         = @"";
    }else {
        self.productName        = model.productName;
        self.selectedOK         = self.selectedSegmentStr;
        self.productIdModal     = model.productId;
        self.productId          = model.productId;
        [self.buttonArray replaceObjectAtIndex:indexPath.row withObject:@"2"];
    }

    [self.modalTableView reloadData];
}

#pragma mark  -  所有控件懒加载
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor        = [UIColor whiteColor];
        _backView.tag                    = 1001;
    }
    return _backView;
}

- (UITableView *)modalTableView {
    if (!_modalTableView) {
        _modalTableView                   = [[UITableView alloc] init];
        _modalTableView.delegate          = self;
        _modalTableView.dataSource        = self;
//        _modalTableView.layer.borderWidth = 0.3;
        _modalTableView.scrollEnabled     = NO;
        _modalTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _modalTableView.tableFooterView   = [[UIView alloc]init];
        _modalTableView.backgroundColor   = [UIColor clearColor];
        [_modalTableView registerClass:[ModalTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _modalTableView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
    }
    return _titleLable;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initForAutoLayout];
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.tag               = 1;
        _cancelButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_cancelButton.layer setCornerRadius:3];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)determineButton {
    if (!_determineButton) {
        _determineButton = [[UIButton alloc] initForAutoLayout];
        _determineButton.layer.borderWidth = 1;
        _determineButton.tag               = 2;
        _determineButton.layer.borderColor = [UIColor redColor].CGColor;
        [_determineButton.layer setCornerRadius:3];
        [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_determineButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineButton;
}

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl                       = [[UISegmentedControl alloc] initWithItems:@[@"长发", @"中发", @"短发"]];
        _segmentedControl.tintColor             = [UIColor redColor]; // 选中的颜色
        _segmentedControl.backgroundColor       = [UIColor whiteColor];
        _segmentedControl.layer.borderColor     = [UIColor redColor].CGColor;
        _segmentedControl.momentary             = NO; // 设置点击后是否恢复原样, 默认是NO， 不恢复
        [_segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

- (void) setProductClas:(NSString *)productClas {
    _productClas = productClas;
    
    if (_productClas.intValue == 11 || _productClas.intValue == 21) {
       self.segmentedControl.selectedSegmentIndex  = 0;
    }
    if (_productClas.intValue == 12 || _productClas.intValue == 22) {
        self.segmentedControl.selectedSegmentIndex  = 1;
    }
    if (_productClas.intValue == 13 || _productClas.intValue == 23) {
        self.segmentedControl.selectedSegmentIndex  = 2;
    }
    
}

- (void) setProductClasBtn:(BOOL)productClasBtn {
    _productClasBtn = productClasBtn;
    if (_productClasBtn) {
        self.segmentedControl.hidden    = NO;
        self.segmentedControlFrame      = [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:30];
        tableviewHeight                 = 85;
        self.modalTableView.frame       = CGRectMake(-1, tableviewHeight, SCREEN_WIDTH + 2, SCREEN_HEIGHT - 100);
    }else {
        self.segmentedControl.hidden    = YES;
        self.segmentedControlFrame      = [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:0];
        tableviewHeight                 = 45;
        self.modalTableView.frame       = CGRectMake(-1, tableviewHeight, SCREEN_WIDTH + 2, SCREEN_HEIGHT - 100);
    }
}

/** 产品类型 1-烫发 2-染发 3－护理 4- 养发*/
- (void) setProductType:(NSString *)productType {
    _productType = productType;
    switch (_productType.intValue) {
        case 1:
            self.titleLable.text = @"烫发";
            break;
        case 2:
            self.titleLable.text = @"染发";
            break;
        case 3:
            self.titleLable.text = @"护理";
            break;
        case 4:
            self.titleLable.text = @"养护";
            break;
            
        default:
            break;
    }
    
}

@end
