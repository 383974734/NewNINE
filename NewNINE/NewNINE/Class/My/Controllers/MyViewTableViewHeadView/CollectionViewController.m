//
//  CollectionViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

//  -----------> 我的控制器 --收藏

#import "CollectionViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "MakeAppointmentViewController.h"
#import "HomeDetailsViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "CollectionTableViewCell.h"
#import "HairstyleCollectionViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "DesignerViewModel.h"
#import "HomeBannerModels.h"
//#import "HairstyleViewControllerModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"collectionTableViewCell";
static NSString *cellControllerView = @"CollectionViewHairstyleViewCell";
@interface CollectionViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, CollectionTableViewCellDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------

/** 导航视图*/
@property (nonatomic, strong) UIView    *navView;
/** 返回按钮*/
@property (nonatomic, strong) UIButton  *returnButton;
/** 设计师按钮*/
@property (nonatomic, strong) UIButton  *loginButton;
/** 发型按钮*/
@property (nonatomic, strong) UIButton  *registerButton;
/** 登录注册按钮线面的线*/
@property (nonatomic, strong) UILabel   *xxLable;

/** 设计师 展示控件*/
@property (nonatomic, strong) UITableView       *collectionTableView;

/** 发型展示列表*/
@property (nonatomic, strong) UICollectionView  *collectionViewHairstyle;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 设计师 数据*/
@property (nonatomic, strong)NSMutableArray *designerArray;
/** 发型 数据*/
@property (nonatomic, strong)NSMutableArray *hairstyleArray;

@end

@implementation CollectionViewController

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
    index = 1;
    indexController = 1;
    self.designerArray  = [NSMutableArray array];
    self.hairstyleArray = [NSMutableArray array];
    [self getStylistinfoCollectsWithData:[NSString stringWithFormat:@"%d", index]];
    [self getOpusInfoCollectsWithData:[NSString stringWithFormat:@"%d", indexController]];
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
    [self.view addSubview:self.navView];
    [self.view addSubview:self.collectionTableView];
    [self.view addSubview:self.collectionViewHairstyle];
    
    [self.navView addSubview:self.returnButton];
    [self.navView addSubview:self.loginButton];
    [self.navView addSubview:self.registerButton];
    [self.navView addSubview:self.xxLable];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.navView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(22, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.navView autoSetDimension:ALDimensionHeight toSize:42];
    
    [self.collectionTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    [self.returnButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [self.returnButton autoSetDimension:ALDimensionWidth toSize:60];
    
    [self.loginButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, SCREEN_WIDTH / 2) excludingEdge:ALEdgeLeft];
    [self.loginButton autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.registerButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH / 2, 0, 0) excludingEdge:ALEdgeRight];
    [self.registerButton autoSetDimension:ALDimensionWidth toSize:70];
}

#pragma mark - 接口数据
// 设计师数据接口  //collec/getOpusInfoCollects
- (void) getStylistinfoCollectsWithData:(NSString *)page{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"collec/getStylistinfoCollects"];
    //获取门店,返回数据格式参考测试结果,返回数据为空时,返回[]
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , GetUserDefault(userUid)],
                       [NSString stringWithFormat:@"page,%@"    , page],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([page isEqualToString:@"1"]) {
                [self.designerArray removeAllObjects];
            }
            self.designerArray = [self stylistinfoCollectsDispose:resultObject];
            [self.collectionTableView reloadData];
        }else {
            NSLog(@"stylistinfo/getStudios%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"stylistinfo/getStudios数据错误%@", error);
    }];
}

- (NSMutableArray *) stylistinfoCollectsDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.designerArray page:index firstPage:1];
    for (NSDictionary * dict in param) {
        DesignerViewModel *model = [DesignerViewModel designerCollectionWithDict:dict];
        [array addObject:model];
    }
    return array;
}

// 发型师数据接口  
- (void) getOpusInfoCollectsWithData:(NSString *)page{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"collec/getOpusInfoCollects"];
    //获取门店,返回数据格式参考测试结果,返回数据为空时,返回[]
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , GetUserDefault(userUid)],
                       [NSString stringWithFormat:@"page,%@"    , page],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([page isEqualToString:@"1"]) {
                [self.hairstyleArray removeAllObjects];
            }
            self.hairstyleArray = [self hairstyleDispose:resultObject];
            [self.collectionViewHairstyle reloadData];
        }else {
            NSLog(@"stylistinfo/getStudios%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"stylistinfo/getStudios数据错误%@", error);
    }];
}

- (NSMutableArray *) hairstyleDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.hairstyleArray page:indexController firstPage:1];
    for (NSDictionary * dict in param) {
        HairstyleViewControllerModel *model = [HairstyleViewControllerModel hairstyleWithDict:dict];
        [array addObject:model];
    }
    return array;
}

#pragma mark - 下拉刷新 -- 上拉加载
/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) headerRereshingData {
    index = 1;
    [self getStylistinfoCollectsWithData:[NSString stringWithFormat:@"%d", index]];
    [self.collectionTableView.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingData {
    index++;
    [self getStylistinfoCollectsWithData:[NSString stringWithFormat:@"%d", index]];
    [self.collectionTableView.mj_footer endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) headerRereshingDataCollectionView {
    indexController = 1;
    [self getOpusInfoCollectsWithData:[NSString stringWithFormat:@"%d", indexController]];
    [self.collectionViewHairstyle.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingDataCollectionView {
    indexController++;
    [self getOpusInfoCollectsWithData:[NSString stringWithFormat:@"%d", indexController]];
    [self.collectionViewHairstyle.mj_footer endRefreshing];
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

    return self.designerArray.count;
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
    DesignerViewModel *model = self.designerArray[indexPath.row];
    CollectionTableViewCell *cell = [CollectionTableViewCell collectionCellWithTableView:tableView forCellReuseIdentifier:cellID];
    cell.dataModel = model;
    cell.delegate  = self;
    cell.indexPath = indexPath;
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
    return 85;
}


#pragma mark - UICollectionView Delegate
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.hairstyleArray.count;
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HairstyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellControllerView forIndexPath:indexPath];
    HairstyleViewControllerModel *model = self.hairstyleArray[indexPath.row];
    cell.dataModel = model;
    return cell;
    
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
    
    HairstyleViewControllerModel *model = self.hairstyleArray[indexPath.row];
    HomeDetailsViewController *detailsViewController = [[HomeDetailsViewController alloc] init];
    detailsViewController.hairstyleModel = model;
    [self.navigationController pushViewController:detailsViewController animated:YES];
    
}


- (void) CollectionTableViewCell:(CollectionTableViewCell *)CollectionTableViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"预约");
    DesignerViewModel *model = self.designerArray[indexPath.row];
    MakeAppointmentViewController *viewController = [[MakeAppointmentViewController alloc] init];
    viewController.stylistinfoId = model.designerId;
//    viewController.noChoice///** 是否是追加订单  1 否  2 是*/ //   1.不是追加订单    2.追加订单
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    if (button.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (button.tag == 1002) {
        [self.loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.xxLable.frame                  = CGRectMake(SCREEN_WIDTH / 2 - 65, 38, 60, 1);
        self.collectionTableView.hidden     = NO;
        self.collectionViewHairstyle.hidden = YES;
    }
    if (button.tag == 1003) {
        [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.xxLable.frame                  = CGRectMake(SCREEN_WIDTH / 2 + 15, 38, 40, 1);
        self.collectionTableView.hidden     = YES;
        self.collectionViewHairstyle.hidden = NO;
    }
}

#pragma mark   -  所有控件懒加载
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initForAutoLayout];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UIButton *) returnButton {
    if (!_returnButton) {
        _returnButton     = [[UIButton alloc] initForAutoLayout];
        _returnButton.tag = 1001;
        [_returnButton setImage:[UIImage imageNamed:@"nav-返回"] forState:UIControlStateNormal];
        [_returnButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}

- (UIButton *) loginButton {
    if (!_loginButton) {
        _loginButton     = [[UIButton alloc] initForAutoLayout];
        _loginButton.tag = 1002;
        [_loginButton setTitle:@"设计师" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *) registerButton {
    if (!_registerButton) {
        _registerButton     = [[UIButton alloc] initForAutoLayout];
        _registerButton.tag = 1003;
        [_registerButton setTitle:@"发型" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerButton;
}

- (UILabel *) xxLable {
    if (!_xxLable) {
        _xxLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 65, 38, 60, 1)];
        _xxLable.backgroundColor = [UIColor redColor];
    }
    return _xxLable;
}

- (UITableView *)collectionTableView {
    if (!_collectionTableView) {
        _collectionTableView            = [[UITableView alloc] initForAutoLayout];
        _collectionTableView.delegate   = self;
        _collectionTableView.dataSource = self;
        [_collectionTableView registerClass:[CollectionTableViewCell class] forCellReuseIdentifier:cellID];
        [self settingTableViewRefreshing:_collectionTableView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
        _collectionTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        _collectionTableView.separatorStyle = NO;//cell线隐藏
//        _collectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _collectionTableView;
}

#pragma mark   -  所有控件懒加载
- (UICollectionView *) collectionViewHairstyle {
    if (!_collectionViewHairstyle) {
        
        UICollectionViewFlowLayout *flowLayout      = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing               = 0;
        flowLayout.minimumInteritemSpacing          = 0;
        flowLayout.itemSize                         = CGSizeMake( (SCREEN_WIDTH - 40) / 2, (SCREEN_WIDTH - 40) / 2 + 46);
        flowLayout.minimumLineSpacing               = 15.0;
        flowLayout.minimumInteritemSpacing          = 5;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionViewHairstyle = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 64,  SCREEN_WIDTH - 30, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
        _collectionViewHairstyle.backgroundColor                = Color(248, 248, 248, 1);
        _collectionViewHairstyle.delegate                       = self;
        _collectionViewHairstyle.dataSource                     = self;
        _collectionViewHairstyle.pagingEnabled                  = NO;
        _collectionViewHairstyle.showsHorizontalScrollIndicator = NO;
        _collectionViewHairstyle.showsVerticalScrollIndicator   = NO;
        [self settingCollectionViewRefreshing:_collectionViewHairstyle target:self headerAction:@selector(headerRereshingDataCollectionView) footerAction:@selector(footerRereshingDataCollectionView)];
        [_collectionViewHairstyle registerClass:[HairstyleCollectionViewCell class] forCellWithReuseIdentifier:cellControllerView];
        _collectionViewHairstyle.hidden = YES;
    }
    return _collectionViewHairstyle;
}

@end
