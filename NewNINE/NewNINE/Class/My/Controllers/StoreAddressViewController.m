//
//  StoreAddressViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 门店地址控制器

#import "StoreAddressViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "StoreAddressTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "StoreAddressModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"StoreAddressViewControllerCell";

@interface StoreAddressViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UITableView *storeAddressTableView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@property (nonatomic, strong) NSMutableArray *storeAddressArray;

@end

@implementation StoreAddressViewController

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
    self.storeAddressArray = [NSMutableArray array];
    [self getMyStudiosWithData];
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
    
    [self setNavWithLeftBarButton:NO title:@"门店地址"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.storeAddressTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.storeAddressTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0)];
}


#pragma mark - 接口数据
//门店
- (void) getMyStudiosWithData{

    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getMyStudios"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"cityName,%@", GetUserDefault(@"cityName")],//当前定位城市
                       ];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.storeAddressArray = [self myStudiosDispose:resultObject];
            [self.storeAddressTableView reloadData];
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"%@", errorMessage);
    }];
}

- (NSMutableArray *) myStudiosDispose:(NSArray *)param {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in param) {
        StoreAddressModel *model = [StoreAddressModel storeAddressWithDict:dict];
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

    return self.storeAddressArray.count;
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
    StoreAddressModel *model = self.storeAddressArray[indexPath.row];
    StoreAddressTableViewCell *cell = [StoreAddressTableViewCell soreAddressCellWithTableView:tableView forCellReuseIdentifier:cellID];
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
    return 65 ;
}


#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    
}

#pragma mark   -  所有控件懒加载
- (UITableView *) storeAddressTableView {
    if (!_storeAddressTableView) {
        _storeAddressTableView = [[UITableView alloc] initForAutoLayout];
        _storeAddressTableView.delegate = self;
        _storeAddressTableView.dataSource = self;
        [_storeAddressTableView registerClass:[StoreAddressTableViewCell class] forCellReuseIdentifier:cellID];
        [_storeAddressTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _storeAddressTableView;
}




@end
