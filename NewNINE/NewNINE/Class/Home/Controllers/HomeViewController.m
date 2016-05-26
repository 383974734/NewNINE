//
//  HomeViewController.m
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页控制器

#import "HomeViewController.h"
// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "DetailsWebViewController.h"    //web-----------> web控制器
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "HomeBannerTableViewCell.h"     //首页 ----> 轮播视图
#import "HomeStarHotTableViewCell.h"    //首页 ----> 明星标题、明星轮播、热门标题 视图
#import "HomeTableViewCell.h"           //首页 ----> 热门发型视图
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

static NSString *cellBannerID   = @"cellBannerID";
static NSString *cellStarHotID  = @"cellStarHotID";
static NSString *cellID         = @"homeTableViewCellID";

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, HomeBannerTableViewCellDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 首页展示底层控件*/
@property (nonatomic, strong) UITableView *homeTableView;



#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 头部轮播数据*/
@property (nonatomic, strong) NSArray *bannerArray;
/** 头部轮播跳转详情数据*/
@property (nonatomic, strong) NSArray *bannerUrlArray;


@end

@implementation HomeViewController

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
    // 头部轮播数据接口
    [self getHomeBannerWithData];
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
    self.navigationController.navigationBar.hidden = YES;
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.homeTableView];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.homeTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-22, 0, 46, 0)];
}

#pragma mark - 接口数据
// 头部轮播数据接口
- (void) getHomeBannerWithData {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"home/getBanners"];
    NSArray *array = @[];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            NSMutableArray *array = [NSMutableArray array];
            NSMutableArray *arrayUrl = [NSMutableArray array];
            for (NSDictionary *dict in resultObject) {
                [array addObject:[dict objectForKey:@"activityBanner"]];
                [arrayUrl addObject:[dict objectForKey:@"actUrl"]];
            }
            self.bannerArray = array;
            self.bannerUrlArray = arrayUrl;
            [self.homeTableView reloadData];
            
        }else {
            NSLog(@"%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"%@", error);
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

    return 6;
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
    return indexPath.row == 0 ? [self homeBannerTableViewCell:tableView] : (indexPath.row == 1 ? [self homeStarHotTableViewCell:tableView] : [self homeTableViewCell:tableView]);
}

/**
 *  头部轮播视图
 *
 *  @param tableView tableView
 *
 *  @return HomeBannerTableViewCell
 */
- (UITableViewCell *) homeBannerTableViewCell :(UITableView *) tableView{
    HomeBannerTableViewCell *cell = [HomeBannerTableViewCell homeBannerCellWithTableView:tableView forCellReuseIdentifier:cellBannerID];
    cell.bannerArray = self.bannerArray;
    cell.delegate    = self;
    return cell;
}

/**
 *  明星轮播视图 （明星标题、轮播、热门标题）
 *
 *  @param tableView tableView
 *
 *  @return HomeStarHotTableViewCell
 */
- (UITableViewCell *) homeStarHotTableViewCell :(UITableView *) tableView {
    HomeStarHotTableViewCell *cell = [HomeStarHotTableViewCell homeStarHotCellWithTableView:tableView forCellReuseIdentifier:cellStarHotID];
    return cell;
}

/**
 *  热门展示视图
 *
 *  @param tableView tableView
 *
 *  @return HomeTableViewCell
 */
- (UITableViewCell *) homeTableViewCell :(UITableView *) tableView {
    HomeTableViewCell *cell = [HomeTableViewCell homeCellWithTableView:tableView forCellReuseIdentifier:cellID];
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
    return indexPath.row == 0 ? SCREEN_HEIGHT * 0.29 : (indexPath.row == 1 ? SCREEN_HEIGHT * 0.37 : SCREEN_HEIGHT * 0.54);
}

#pragma mark - 头部轮播cell 代理 -- HomeBannerTableViewCellDelegate
- (void)stPushBannerView:(HomeBannerTableViewCell *)stBannerView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"头部轮播cell代理 ----- %@", self.bannerUrlArray[indexPath.row]);
    if (self.bannerUrlArray.count> 0) {
        if (!([self.bannerUrlArray[indexPath.row] length] > 0)) {
            return;
        }
    }
    DetailsWebViewController *webViewController = [[DetailsWebViewController alloc] init];
    webViewController.strUrl = self.bannerUrlArray[indexPath.row];
    [self.navigationController pushViewController:webViewController animated:YES];
}

#pragma mark - 下拉刷新 -- 上拉加载
/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) headerRereshingData {

    [self.homeTableView.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingData {
    
    [self.homeTableView.mj_footer endRefreshing];
}

#pragma mark   -  所有控件懒加载
/**
 *  首页展示底层控件
 *
 *  @return UITableView
 */
- (UITableView *) homeTableView {
    if (!_homeTableView) {
        _homeTableView                  = [[UITableView alloc] initForAutoLayout];
        _homeTableView.delegate         = self;
        _homeTableView.dataSource       = self;
        _homeTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
        
        [_homeTableView registerClass:[HomeBannerTableViewCell  class] forCellReuseIdentifier:cellBannerID];
        [_homeTableView registerClass:[HomeStarHotTableViewCell class] forCellReuseIdentifier:cellStarHotID];
        [_homeTableView registerClass:[HomeTableViewCell        class] forCellReuseIdentifier:cellID];

        [self settingTableViewRefreshing:_homeTableView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
    }
    return _homeTableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
