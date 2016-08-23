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
static NSString *cellIDPublicDesigner = @"HomeDetailsViewCellPublicDesigner";

// ---------------------- 框架工具类 ----------------------
#import "UMSocial.h"
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
#import "MakeAppointmentViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "DetailsViewControllerCell.h"   //首页 ----> 首页发型详情控制器cell
#import "HomeTableViewCell.h"           //首页 ----> 热门发型视图
#import "PublicDesignerTableViewCell.h" //首页 ----> 首页发型详情公共设计师控制器cell
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "HomeBannerModels.h"
#import "HairstyleViewControllerModel.h"
// ---------------------- model      ----------------------

@interface HomeDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, DetailsViewControllerCellDelegate, PublicDesignerTableViewCellDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 发型详情显示控件*/
@property (nonatomic, strong) UITableView *detailsTableView;


/** 导航view控件 */
@property (nonatomic, strong) UIView *navView;
/** 导航返回按钮控件 */
@property (nonatomic, strong) UIButton *backBtn;
/** 导航文字title控件 */
@property (nonatomic, strong) UILabel *navTitleLable;
/** 导航收藏显示数量控件 */
@property (nonatomic, strong) UILabel *collectionNumberLable;
/** 导航收藏控件 */
@property (nonatomic, strong) UIButton *collectionBtn;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 发型师详情信息*/
@property (nonatomic, strong) NSDictionary *detailsDict;
/** 是否收藏*/
@property (nonatomic, copy) NSString *isSuccess;

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
    //工具栏
//    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
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
//    [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
    
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

    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 66)];
    self.navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(9, 32, 24, 24)];
    [self.backBtn setImage:[UIImage imageNamed:@"nav-返回"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.backBtn];
    
    self.navTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 32, SCREEN_WIDTH - 170, 24)];
    [self.navView addSubview:self.navTitleLable];
    
    self.collectionNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 105, 32, 48, 24)];
    self.collectionNumberLable.textColor = [UIColor lightGrayColor];
    self.collectionNumberLable.textAlignment = NSTextAlignmentRight;
    [self.navView addSubview:self.collectionNumberLable];
    
    self.collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 32, 24, 24)];
    [self.collectionBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.collectionBtn];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.detailsTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-22, 0, 0, 0)];
}

#pragma mark - 接口数据
// 发型详情内容接口
- (void) getDetailsWithData:(NSString *)opusinfoId {
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", BaseURL, @"opusinfo/getOpusinfoById"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"opusinfoId,%@", opusinfoId],
                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:strUrl parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
//        [SVProgressHUD dismiss];
        if (resultObject != nil) {
            self.detailsDict = resultObject;
            self.navTitleLable.text = [self.detailsDict objectForKey:@"infoDescription"];
            SetUserDefault([self.detailsDict objectForKey:@"collectCount"], @"collectCount");
            self.collectionNumberLable.text = [NSString stringWithFormat:@"%@", [self.detailsDict objectForKey:@"collectCount"]];
            self.isSuccess = [NSString stringWithFormat:@"%@", [_detailsDict objectForKey:@"isCollect"]];
            if ([[_detailsDict objectForKey:@"isCollect"] intValue] == 1) {

                [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
                [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateNormal];
            }
            if ([[_detailsDict objectForKey:@"isCollect"] intValue] == 2) {
                
                [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
                [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"未收藏"] forState:UIControlStateNormal];
            }
            
            [self.detailsTableView reloadData];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"%@", errorMessage);
    }];
}

// 收藏 发型接口
-(void) getCollecOpusInfoWithData:(NSString *)idStr type:(NSString *)type {
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", BaseURL, @"collec/collecOpusInfo"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],
                       [NSString stringWithFormat:@"opusInfoId,%@", idStr],
                       [NSString stringWithFormat:@"type,%@", type],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:strUrl parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"%@", resultObject);
        [SVProgressHUD dismiss];
        
        if (resultObject != nil) {
            if (self.dataModel.homeID != nil) {
                [self getDetailsWithData:self.dataModel.homeID];
            }else {
                [self getDetailsWithData:self.hairstyleModel.hairstyleID];
            }
        }else {
            
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
    if ([[self.detailsDict objectForKey:@"stylistInfos"] count] > 0) {
        return 3;
    }else {
        return 2;
    }
    
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
    if ([[self.detailsDict objectForKey:@"stylistInfos"] count] > 0) {
        return section == 0 ? 1 : section == 1 ? [[self.detailsDict objectForKey:@"photos"] count] : 1;
    }else {
        return section == 0 ? 1 :[[self.detailsDict objectForKey:@"photos"] count];
    }
    
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
    if ([[self.detailsDict objectForKey:@"linkType"] intValue] == 2) {
        if ([[self.detailsDict objectForKey:@"stylistInfos"] count] > 0) {
            return indexPath.section == 0 ? [self detailsSectionZeroTableViewCell:tableView cellForRowAtIndexPath:indexPath] : indexPath.section == 1 ? [self homeTableViewCell:tableView cellForRowAtIndexPath:indexPath] : [self publicDesignerpCell:tableView cellForRowAtIndexPath:indexPath];
        }else {
            return indexPath.section == 0 ? [self detailsSectionZeroTableViewCell:tableView cellForRowAtIndexPath:indexPath] : [self homeTableViewCell:tableView cellForRowAtIndexPath:indexPath];
        }
    }else {
        return indexPath.section == 0 ? [self detailsSectionZeroTableViewCell:tableView cellForRowAtIndexPath:indexPath] : [self homeTableViewCell:tableView cellForRowAtIndexPath:indexPath];
    }

}

/**
 *  发型详情最上面的view
 *
 *  @param tableView tableView
 *  @param indexPath indexPath
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *) detailsSectionZeroTableViewCell: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsViewControllerCell *cell = [DetailsViewControllerCell detailsCellWithTableView:tableView forCellReuseIdentifier:cellIDZero];
    cell.detailsDict = self.detailsDict;
    cell.delegate = self;
    return cell;
}

/**
 *  详情图片
 *
 *  @param tableView tableView
 *
 *  @return HomeTableViewCell
 */
- (UITableViewCell *) homeTableViewCell: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [HomeTableViewCell homeCellWithTableView:tableView forCellReuseIdentifier:cellID];
    if ([[self.detailsDict objectForKey:@"photos"] count] > indexPath.row) {
        cell.photoUrl  = [[self.detailsDict objectForKey:@"photos"][indexPath.row] objectForKey:@"photoUrl"];
    }
    cell.btnHidden = YES;
    return cell;
}

/**
 *  首页发型详情公共设计师
 *
 *  @param tableView tableView
 *
 *  @return PublicDesignerTableViewCell
 */
- (UITableViewCell *) publicDesignerpCell: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PublicDesignerTableViewCell *cell = [PublicDesignerTableViewCell publicDesignerpCellWithTableView:tableView forCellReuseIdentifier:cellIDPublicDesigner];
    cell.arratData = [self.detailsDict objectForKey:@"stylistInfos"];
    cell.delegate  = self;
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
    if ([[self.detailsDict objectForKey:@"linkType"] intValue] == 2) {
        if ([[self.detailsDict objectForKey:@"stylistInfos"] count] > 0) {

            long a = [[self.detailsDict objectForKey:@"stylistInfos"] count];
            NSLog(@"%lu", a);

            if (a%2 == 0) {
                return indexPath.section == 0 ? SCREEN_WIDTH + 75 : indexPath.section == 1 ? SCREEN_WIDTH - 30 : a / 2 * ((SCREEN_WIDTH - 40) / 2 + 35) + 110 + (a * 15);
            }else {
                return indexPath.section == 0 ? SCREEN_WIDTH + 75 : indexPath.section == 1 ? SCREEN_WIDTH - 30 : a / 2 * ((SCREEN_WIDTH - 40) / 2 + 46) + 110 + ((SCREEN_WIDTH - 40) / 2 + 31) + (a * 15);
            }
        }else {
           return indexPath.section == 0 ? SCREEN_WIDTH + 75 : indexPath.section == 1 ? SCREEN_WIDTH - 30 : 0;
        }
        
    }else {
        return indexPath.section == 0 ? SCREEN_WIDTH + 155 : indexPath.section == 1 ? SCREEN_WIDTH - 30 : 0;
    }
}

#pragma mark - DetailsViewControllerCellDelegate   代理 
/**
 *  点击返回按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void) detailsReturnViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCell {
    [self didButton:nil];
}

/**
 *  点击收藏按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void) detailsCollectionViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCell {
    [self collectBtnClick:nil];
}

/**
 *  点击分享按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void)detailsShareViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCel {
    NSLog(@"分享");
    
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToSina,
                                                  UMShareToWechatSession,  // 微信
                                                  UMShareToWechatTimeline, // 朋友圈
                                                  ]
                                       delegate:nil];
}

/**
 *  点击预约按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void)detailsAppointmentBtnViewControllerCell:(DetailsViewControllerCell *)detailsViewControllerCell didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击预约按钮触发事件");
    if (!([[self.detailsDict objectForKey:@"stylistInfos"] count] > 0)) return;
        
    MakeAppointmentViewController *viewController = [[MakeAppointmentViewController alloc] init];
    viewController.stylistinfoId = [[self.detailsDict objectForKey:@"stylistInfos"][0] objectForKey:@"id"];
    viewController.noChoice      = @"1";///** 是否是追加订单  1 否  2 是*/ //   1.不是追加订单    2.追加订单
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void) didButton:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  点击公共发型预约按钮触发事件
 *
 *  @param detailsViewControllerCell DetailsViewControllerCell
 */
- (void) publicDesignerTableViewCell:(PublicDesignerTableViewCell *)publicDesignerTableViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击公共发型预约按钮触发事件");
    MakeAppointmentViewController *viewController = [[MakeAppointmentViewController alloc] init];
    //    viewController.noChoice///** 是否是追加订单  1 否  2 是*/ //   1.不是追加订单    2.追加订单
    viewController.stylistinfoId = [[self.detailsDict objectForKey:@"stylistInfos"][indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void) collectBtnClick:(UIButton *)btn {
    //collec/collecOpusInfo
    NSString *type = @"";
    if ([[self.detailsDict objectForKey:@"isCollect"] intValue] == 1) {
        type = @"2";
    }else {
        type = @"1";
    }
    [self getCollecOpusInfoWithData:[self.detailsDict objectForKey:@"id"] type:type];
}

#pragma mark - UIScrollView delegate  是否显示自定义导航
/**
 *  是否显示自定义导航
 *
 *  @param scrollView UIScrollView
 */
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.navView.alpha = _detailsTableView.contentOffset.y / 10;
}

#pragma mark   -  所有控件懒加载
- (UITableView *) detailsTableView {
    if (!_detailsTableView) {
        _detailsTableView = [[UITableView alloc] initForAutoLayout];
        _detailsTableView.delegate          = self;
        _detailsTableView.dataSource        = self;
        _detailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_detailsTableView registerClass:[DetailsViewControllerCell   class] forCellReuseIdentifier:cellIDZero];
        [_detailsTableView registerClass:[HomeTableViewCell           class] forCellReuseIdentifier:cellID];
        [_detailsTableView registerClass:[PublicDesignerTableViewCell class] forCellReuseIdentifier:cellIDPublicDesigner];
    }
    return _detailsTableView;
}

- (void) setDataModel:(HomeBannerModels *)dataModel {
    _dataModel = dataModel;
    [self getDetailsWithData:_dataModel.homeID];
}

- (void) setHairstyleModel:(HairstyleViewControllerModel *)hairstyleModel {
    _hairstyleModel = hairstyleModel;
    [self getDetailsWithData:_hairstyleModel.hairstyleID];
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
