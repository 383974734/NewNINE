//
//  HomeDetailsViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/30.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情控制器

#import "HomeDetailsViewController.h"

static NSString *cellIDZero = @"HomeDetailsZeroViewCell";
static NSString *cellID     = @"HomeDetailsViewCell";

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "DetailsViewControllerCell.h"
#import "HomeTableViewCell.h"           //首页 ----> 热门发型视图
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "HomeBannerModels.h"
// ---------------------- model      ----------------------

@interface HomeDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 发型详情显示控件*/
@property (nonatomic, strong) UITableView *detailsTableView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 发型师详情信息*/
@property (nonatomic, strong) NSDictionary *detailsDict;

@end

@implementation HomeDetailsViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
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
    [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
    
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
    
    [self settingNavigationBarTitle:@"模板" textColor:nil titleFontSize:NAVIGATION_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.detailsTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.detailsTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - 接口数据
// 发型详情内容接口
- (void) getDetailsWithData:(NSString *)opusinfoId {
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", BaseURL, @"opusinfo/getOpusinfoById"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"opusinfoId,%@", opusinfoId],
//                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:strUrl parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        [SVProgressHUD dismiss];
        if (resultObject != nil) {
            self.detailsDict = resultObject;
            [self.detailsTableView reloadData];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"%@", errorMessage);
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
    return section == 0 ? 1 : [[self.detailsDict objectForKey:@"photos"] count];
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
    return indexPath.section == 0 ? [self detailsSectionZeroTableViewCell:tableView cellForRowAtIndexPath:indexPath] : [self homeTableViewCell:tableView cellForRowAtIndexPath:indexPath];
}

/**
 *  发型详情最上面的view
 *
 *  @param tableView tableView
 *  @param indexPath indexPath
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *) detailsSectionZeroTableViewCell :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewControllerCell *cell = [DetailsViewControllerCell detailsCellWithTableView:tableView forCellReuseIdentifier:cellIDZero];
    cell.detailsDict = self.detailsDict;
    return cell;
}

/**
 *  详情图片
 *
 *  @param tableView tableView
 *
 *  @return HomeTableViewCell
 */
- (UITableViewCell *) homeTableViewCell :(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [HomeTableViewCell homeCellWithTableView:tableView forCellReuseIdentifier:cellID];
    cell.photoUrl  = [[self.detailsDict objectForKey:@"photos"][indexPath.row] objectForKey:@"photoUrl"];
    cell.btnHidden = YES;
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
    return indexPath.section == 0 ? SCREEN_WIDTH + 160 : SCREEN_WIDTH - 30;
}



#pragma mark   -  所有控件懒加载
- (UITableView *) detailsTableView {
    if (!_detailsTableView) {
        _detailsTableView = [[UITableView alloc] initForAutoLayout];
        _detailsTableView.delegate = self;
        _detailsTableView.dataSource = self;
        [_detailsTableView registerClass:[DetailsViewControllerCell class] forCellReuseIdentifier:cellIDZero];
        [_detailsTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _detailsTableView;
}

- (void) setDataModel:(HomeBannerModels *)dataModel {
    _dataModel = dataModel;
    [self getDetailsWithData:_dataModel.homeID];
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
