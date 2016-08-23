//
//  DesignerViewController.m
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 设计师控制器

#import "DesignerViewController.h"

static NSString *cellID = @"DesignerViewTableViewCellID";

// ---------------------- 框架工具类 ----------------------
#import <CoreLocation/CoreLocation.h>
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "CityViewController.h"
#import "ScreenViewController.h"
#import "MakeAppointmentViewController.h"
#import "ModalViewController.h"
#import "LoginViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "DesignerHeadView.h"
#import "DesignerViewTableViewCell.h"
#import "RMMapLocation.h"
#import "ClassificationView.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "DesignerViewModel.h"
#import "StylistLevlsModel.h"
// ---------------------- model      ----------------------

@interface DesignerViewController ()<UITableViewDelegate, UITableViewDataSource, DesignerHeadViewDelegate, ClassificationViewDelegate, DesignerViewTableViewCellDelegate, UITextFieldDelegate> {
    CLGeocoder *_geocoder;
}

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) RMMapLocation         *map;
/** 设计师控制器 导航*/
@property (nonatomic, strong) DesignerHeadView      *designerHeadView;

@property (nonatomic, strong) UITableView           *designerTableView;
/** 智能排序view*/
@property (nonatomic, strong) ClassificationView    *classification;
/** 搜索文字输入框*/
@property (nonatomic, strong) UITextField           *searchTextField;
/** 搜索 取消按钮*/
@property (nonatomic, strong) UIButton              *cancelSearchButton;
/** 搜索 图片*/
@property (nonatomic, strong) UIImageView           *searchImageView;
/** 搜索 背景*/
@property (nonatomic, strong) UIView                *backView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 美发师数据*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 职务数据*/
@property (nonatomic, strong) NSMutableArray *stylistLevlsArray;
/** 城市数据*/
@property (nonatomic, strong) NSArray *cityArray;
/** 设计师控制器 全部区域 数据*/
@property (nonatomic, strong) NSArray *wholeRegionAray;


@property (nonatomic, copy) NSString *page;
@property (nonatomic, copy) NSString *values;
@property (nonatomic, copy) NSString *bought;
@property (nonatomic, copy) NSString *starLevel;
/** 设计师职位ID*/
@property (nonatomic, copy) NSString *levlId;
@property (nonatomic, copy) NSString *stylistName;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *studioId;

/** 当前城市数据*/
@property (nonatomic, copy) NSString *locationCityStr;

@end

@implementation DesignerViewController

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
    SetUserDefault(@"1", @"selectedIndex");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelOrderCallBack:) name:@"cancelOrderCallBack" object:nil];
    
    _geocoder=[[CLGeocoder alloc]init];

    self.map = [[RMMapLocation alloc] init];
    [RMMapLocation getGps:^(double lattitude, double longitude) {
        NSLog(@"%f", lattitude);
        NSLog(@"%f", longitude);
        [self getAddressByLatitude:lattitude longitude:longitude];
    }];
    
    if (GetUserDefault(@"hotCity") != nil) {
        self.designerHeadView.strCity = GetUserDefault(@"hotCity");
        self.cityName = GetUserDefault(@"hotCity");
        [self getStylistinfosWithData];
        [self getStudiosWithData:self.cityName];
    }
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
    if (self.stateStr.intValue == 1) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    }else {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    }
    
}



/**
 *  当前 控制器 被销毁时 调用
 */
- (void) dealloc {
    NSLog(@" selfViewController Destroy ");
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Init Data Method
/**
 *  数据初始化
 */
- (void) initData {
    index = 1 ;
    self.values     = @"";
    self.bought     = @"";
    self.starLevel  = @"";
    self.levlId     = @"";
    self.stylistName = @"";
    self.cityName   = @"哈尔滨";
    self.locationCityStr = @"哈尔滨";
    SetUserDefault(self.locationCityStr, @"cityName");
    self.studioId   = @"";
    [self getHotCitysWithData];
    [self getStudiosWithData:@"哈尔滨"];
    [self getStylistinfosWithData];
    [self getStylistLevlsWithData];
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
    [self.view addSubview:self.searchImageView];
    [self.view addSubview:self.searchTextField];
    [self.view addSubview:self.cancelSearchButton];
    [self.view addSubview:self.designerHeadView];
    [self.view addSubview:self.designerTableView];
    [self.view addSubview:self.classification];
    
    
}


#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        NSLog(@"详细信息:%@",placemark.addressDictionary[@"City"]);
        NSLog(@"%@", [placemark.addressDictionary[@"City"] substringToIndex:([placemark.addressDictionary[@"City"] length]-1)]);
        self.designerHeadView.strCity = [placemark.addressDictionary[@"City"] substringToIndex:([placemark.addressDictionary[@"City"] length]-1)];
        self.locationCityStr = [placemark.addressDictionary[@"City"] substringToIndex:([placemark.addressDictionary[@"City"] length]-1)];
        SetUserDefault(self.locationCityStr, @"cityName");
    }];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
//    [self.designerTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(100, 0, 5, 0)];
    [self.classification autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(100, 0, 0, 0) ];
}

#pragma mark - 接口数据
// 美发师数据接口
- (void) getStylistinfosWithData {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"stylistinfo/getStylistinfos"];
    //获取发型,每页4条,返回数据格式参考测试结果,返回数据为空时,返回[],levlId 多个ID,隔开 1,2 studioId 多个ID,隔开 如 1,2
    
    NSMutableArray *muArray = [NSMutableArray array];
    
    [muArray addObject:[NSString stringWithFormat:@"page,%@", [NSString stringWithFormat:@"%d", index]]];
    if (![self.values       isEqualToString:@""]) {//价格排序 值 DESC ASC
        [muArray addObject:[NSString stringWithFormat:@"values,%@",      self.values]];
    }
    if (![self.bought       isEqualToString:@""]) {//美单排序 值 DESC ASC
        [muArray addObject:[NSString stringWithFormat:@"bought,%@",      self.bought]];
    }
    if (![self.starLevel    isEqualToString:@""]) {//好评优先 值 DESC
        [muArray addObject:[NSString stringWithFormat:@"starLevel,%@",   self.starLevel]];
    }
    if (![self.levlId       isEqualToString:@""]) {//设计师职位ID
        [muArray addObject:[NSString stringWithFormat:@"levlId,%@",      self.levlId]];
    }
    if (![self.stylistName  isEqualToString:@""]) {//设计师名称
        [muArray addObject:[NSString stringWithFormat:@"stylistName,%@", self.stylistName]];
    }
    if (![self.cityName     isEqualToString:@""]) {//城市名称
        [muArray addObject:[NSString stringWithFormat:@"cityName,%@",    self.cityName]];
    }
    if (![self.studioId     isEqualToString:@""]) {//门店ID
        [muArray addObject:[NSString stringWithFormat:@"studioId,%@",    self.studioId]];
    }
//    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:muArray isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.dataArray = [self stylistinfosDispose:resultObject];
            [self.designerTableView reloadData];
        }else {
            NSLog(@"stylistinfo/getStylistinfos%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"stylistinfo/getStylistinfos数据错误%@", error);
    }];
}

- (NSMutableArray *) stylistinfosDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.dataArray page:index firstPage:1];
    for (NSDictionary *dict in param) {
        DesignerViewModel *model = [DesignerViewModel designerWithDict:dict];
        [array addObject:model];
    }
    return array;
}

// 获取门店数据接口
- (void) getStudiosWithData:(NSString *)cityName{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"stylistinfo/getStudios"];
    //获取门店,返回数据格式参考测试结果,返回数据为空时,返回[]
    NSArray *array = @[
                       [NSString stringWithFormat:@"cityName,%@", cityName],//城市名称名称，不带'市'
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.wholeRegionAray                = resultObject;
            self.classification.wholeRegionAray = self.wholeRegionAray;
            
        }else {
            NSLog(@"stylistinfo/getStudios%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"stylistinfo/getStudios数据错误%@", error);
    }];
}

// 获取热门城市数据接口
- (void) getHotCitysWithData {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"stylistinfo/getHotCitys"];
    //获取门店,返回数据格式参考测试结果,返回数据为空时,返回[]
    NSArray *array = @[];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.cityArray = resultObject;
            
        }else {
            NSLog(@"stylistinfo/getHotCitys%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"stylistinfo/getHotCitys数据错误%@", error);
    }];
}

// 美发师 职务接口
- (void) getStylistLevlsWithData{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"stylistinfo/getStylistLevls"];
    NSArray *array = @[];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.stylistLevlsArray = [self getStylistLevlsDispose:resultObject];
            
        }else {
            NSLog(@"stylistinfo/getStylistLevls%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"stylistinfo/getStylistLevls数据错误%@", error);
    }];
}

- (NSMutableArray *) getStylistLevlsDispose:(NSArray *)param {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary * dict in param) {
        StylistLevlsModel *model = [StylistLevlsModel stylistLevlsWithDict:dict];
        [array addObject:model];
    }
    return array;
}

#pragma mark - UITextField delegate
/**
 *  UITextField 软键盘上return 按钮点击
 *
 *  @param textField
 *
 *  @return
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

/**
 *  UITextField 已经结束编辑
 *
 *  @param textField
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.stylistName = textField.text;
    [self getStylistinfosWithData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

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

    return self.dataArray.count;
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
    DesignerViewModel *model = self.dataArray[indexPath.row];
    DesignerViewTableViewCell *cell = [DesignerViewTableViewCell designerViewTableViewCellCellWithTableView:tableView forCellReuseIdentifier:cellID];
    cell.delegate = self;
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
    return SCREEN_WIDTH / 3 + 85 ;
}


#pragma mark - 设计师控制器 导航点击不同的按钮 响应不同的事件
/**
 *  设计师控制器 导航点击不同的按钮 响应不同的事件
 *
 *  @param designerHeadView designerHeadView
 *  @param btn              点击的button
 */
- (void)designerHeadView:(DesignerHeadView *)designerHeadView buttonWithTag:(UIButton *)btn {
    if (btn.tag == 4) {
        NSLog(@"搜索");
        [UIView animateWithDuration:0.3 animations:^{
            self.designerTableView.frame = CGRectMake(0, 150, SCREEN_WIDTH, SCREEN_HEIGHT - 155);
        }];
        self.searchTextField.text = @"";
    }
    if (btn.tag == 0) {
        NSLog(@"区域");
        self.classification.hidden = NO;
        _classification.designerStr = @"设计师区域";
        self.classification.wholeRegionAray = self.wholeRegionAray;
        
        
        __weak typeof(self) selfViewController = self;
        self.classification.buttonTouchUpInside = ^(){
            selfViewController.classification.hidden = YES;
            [selfViewController.rdv_tabBarController setTabBarHidden:!selfViewController.classification.hidden animated:YES];
        };
        self.classification.classificationID = ^(NSString *strId, NSString *strName){
            selfViewController.studioId = [NSString stringWithFormat:@"%@", strId];
            [selfViewController getStylistinfosWithData];
            selfViewController.designerHeadView.followStr = strName;
            selfViewController.classification.hidden = YES;
            [selfViewController.rdv_tabBarController setTabBarHidden:!selfViewController.classification.hidden animated:YES];
        };
        
        
        [self.rdv_tabBarController setTabBarHidden:!self.classification.hidden animated:YES];
    }
    if (btn.tag == 1) {
        NSLog(@"排序");
        self.classification.hidden = NO;
        NSArray *array = @[@"智能排序",@"美单最多",@"价格最高",@"价格最低"];
        _classification.designerStr = @"设计师排序";
        self.classification.designerArray = array;
        [self.rdv_tabBarController setTabBarHidden:!self.classification.hidden animated:YES];
    }
    if (btn.tag == 2) {
        NSLog(@"筛选");
        ScreenViewController *screenView = [[ScreenViewController alloc] init];
        self.classification.hidden       = YES;
        if (self.stylistLevlsArray       > 0) {
            screenView.arrayData         = self.stylistLevlsArray;
            screenView.stylistLevlsStrID = self.levlId;
            screenView.screenViewID = ^(NSString *strID){
                self.levlId = [NSString stringWithFormat:@"%@", strID];
                [self getStylistinfosWithData];
                self.designerHeadView.classificationStr = self.levlId;
            };
            
            [self.navigationController pushViewController:screenView animated:YES];
        }
    }
    if (btn.tag == 3) {
        NSLog(@"城市");
        CityViewController *cityView   = [[CityViewController alloc] init];
        if (self.cityArray > 0) {
            cityView.hotCityStr        = GetUserDefault(@"hotCity");
            cityView.locationCityStr   = self.locationCityStr;
            cityView.cityArray         = self.cityArray;
            self.classification.hidden = YES;
            [self.navigationController pushViewController:cityView animated:YES];
        }
    }
}

/**
 *  点击发型分类出点的下拉列表点击代理
 *
 *  @param classificationView ClassificationView
 *  @param classification     点击后相应的文字
 *  @param classificationID   di
 */
- (void) classificationView:(ClassificationView *)classificationView didSelectRowWithClassification:(NSString *)classification classificationID:(NSString *)classificationID{
    index = 1 ;
    self.bought = @"";
    self.values = @"";
    if ([classification isEqualToString:@"智能排序"]) {
        self.bought = @"";
    }
    if ([classification isEqualToString:@"美单最多"]) {
        self.bought = @"DESC";
    }
    if ([classification isEqualToString:@"价格最高"]) {
        self.values = @"DESC";
    }
    if ([classification isEqualToString:@"价格最低"]) {
        self.values = @"ASC";
    }
    
    if (classification != nil) {
        self.designerHeadView.timeStr = classification;
    }
    self .classification.hidden = YES;
    [self.rdv_tabBarController setTabBarHidden:!self.classification.hidden animated:YES];
    [self getStylistinfosWithData];
}

#pragma mark - DesignerViewTableViewCellDelegate
/**
 *  点击预约跳页代理
 *
 *  @param designerViewTableViewCell DesignerViewTableViewCell
 *  @param stylistinfoId             预约的设计师id
 */
- (void)designerViewTableViewCell:(DesignerViewTableViewCell *)designerViewTableViewCell stylistinfoId:(NSString *)stylistinfoId {
    
    if (!([GetUserDefault(userUid) length] > 0)){
        [self goToLogin];
        return;
    }
    if (self.stateStr.intValue == 1) {
        if ([self.delegate respondsToSelector:@selector(designerViewController:stylistinfoId:)]) {
            [self.delegate designerViewController:self stylistinfoId:stylistinfoId];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        MakeAppointmentViewController *viewController = [[MakeAppointmentViewController alloc] init];
        viewController.stylistinfoId = stylistinfoId;
        viewController.noChoice      = @"1";///** 是否是追加订单  1 否  2 是*/ //   1.不是追加订单    2.追加订单
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)goToLogin {
    LoginViewController *loginView = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginView animated:YES];
}

#pragma mark - 控件点击事件
- (void)cancelSearchButtonClick:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        self.designerTableView.frame = CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 155);
    }];
    self.stylistName = @"";
    [self getStylistinfosWithData];
}

#pragma mark - 下拉刷新 -- 上拉加载
/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) headerRereshingData {
    index = 1 ;
    [self getStylistinfosWithData];
    [self.designerTableView.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingData {
    index++;
    [self getStylistinfosWithData];
    [self.designerTableView.mj_footer endRefreshing];
}

#pragma mark   -  所有控件懒加载
- (DesignerHeadView *)designerHeadView {
    if (!_designerHeadView) {
        _designerHeadView = [[DesignerHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _designerHeadView.delegate = self;
    }
    return _designerHeadView;
}

- (UITableView *) designerTableView {
    if (!_designerTableView) {
        _designerTableView              = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 105)];
        _designerTableView.delegate     = self;
        _designerTableView.dataSource   = self;
        [_designerTableView registerClass:[DesignerViewTableViewCell class] forCellReuseIdentifier:cellID];
        [self settingTableViewRefreshing:_designerTableView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
//        _designerTableView.separatorStyle = NO;//cell线隐藏
        _designerTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        [_designerTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _designerTableView;
}

- (ClassificationView *) classification {
    if (!_classification) {
        _classification             = [[ClassificationView alloc] initForAutoLayout];
        _classification.hidden      = YES;
        _classification.delegate    = self;
    }
    return _classification;
}

- (UIView *) backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 50)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 110, SCREEN_WIDTH - 150, 35)];
        _searchTextField.font            = [UIFont systemFontOfSize:14];
        _searchTextField.placeholder     = @"请输入设计师姓名";
        _searchTextField.delegate        = self;
    }
    return _searchTextField;
}

- (UIButton *) cancelSearchButton {
    if (!_cancelSearchButton) {
        _cancelSearchButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 110, 40, 40)];
        [_cancelSearchButton setTitleColor:UIColorFromRGB(0x9a9a9a) forState:UIControlStateNormal];
        [_cancelSearchButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelSearchButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelSearchButton addTarget:self action:@selector(cancelSearchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelSearchButton;
}

- (UIImageView *) searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 110, SCREEN_WIDTH - 110, 35)];
        _searchImageView.image  = [UIImage imageNamed:@"searchbar123"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        _searchImageView.contentMode = UIViewContentModeCenter;
    }
    return _searchImageView;
}

@end
