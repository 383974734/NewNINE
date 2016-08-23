//
//  IntegralPurchaseViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "IntegralPurchaseViewController.h"
// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "IntegralPurchaseTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

static NSString *cellID = @"IntegralPurchaseTableViewCellID";

@interface IntegralPurchaseViewController ()<UITableViewDelegate, UITableViewDataSource>
#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UIImageView *imageView;
/** 积分*/
@property (nonatomic, strong) UITableView *IntegralPurchaseTableView;
#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@property (nonatomic, strong) NSMutableArray *IntegralPurchaseArray;
@end

@implementation IntegralPurchaseViewController

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
    [self getIntegralPriceWithData];
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

    [self setNavWithLeftBarButton:NO title:@"积分购买"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.IntegralPurchaseTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    [self.IntegralPurchaseTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(67, 0, 0, 0)];
}

#pragma mark - 接口数据
//购买积分接口
- (void) getIntegralPriceWithData{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getIntegralPrice"];
    NSArray *array = @[];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            [self.IntegralPurchaseArray addObjectsFromArray:resultObject];
            [self.IntegralPurchaseTableView reloadData];
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/getIntegralPrice数据错误%@", error);
    }];
}


#pragma mark - TableView

#pragma mark UITableView DataSource
/**
 *  tableView 数据源方法 返回tabvelView 分组个数
 *
 *  @param tableView
 *
 *  @return NSInteger
 */
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.IntegralPurchaseArray.count;
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
 *  @return IntegralPurchaseTableViewCell
 */
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntegralPurchaseTableViewCell *cell = [IntegralPurchaseTableViewCell integralPurchaseTableViewCellWithTableView:tableView forCellReuseIdentifier:cellID];
    cell.integralArray   = self.IntegralPurchaseArray[indexPath.section];
    cell.indexPath       = indexPath;
    cell.backgroundColor = [UIColor redColor];
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
    return 150 ;
}

#pragma mark UITable  Delegate
/**
 *  tableView        数据源方法 返回每个viewForHeader上的内容
 *
 *  @param tableView
 *  @param section
 *
 *  @return UIView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.alpha = 0;
    return view;
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

-(UITableView *)IntegralPurchaseTableView {
    if (!_IntegralPurchaseTableView) {
        _IntegralPurchaseTableView = [[UITableView alloc] initForAutoLayout];
        _IntegralPurchaseTableView.delegate   = self;
        _IntegralPurchaseTableView.dataSource = self;
        _IntegralPurchaseTableView.backgroundColor = [UIColor clearColor];
        [_IntegralPurchaseTableView registerClass:[IntegralPurchaseTableViewCell class] forCellReuseIdentifier:cellID];
        [_IntegralPurchaseTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    }
    return _IntegralPurchaseTableView;
}

- (UIImageView *) imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initForAutoLayout];
        _imageView.image = [UIImage imageNamed:@"购买积分bac"];
    }
    return _imageView;
}

@end
