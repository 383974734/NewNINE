//
//  IntegralViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器 --积分

#import "IntegralViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "IntegralTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "IntegralViewModel.h"
// ---------------------- model      ----------------------



static NSString *cellID = @"integralTableViewCellID";
@interface IntegralViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 积分 展示控件*/
@property (nonatomic, strong) UITableView       *integralTableView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 积分 数据*/
@property (nonatomic, strong)NSMutableArray *integralArray;

@end

@implementation IntegralViewController

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
    index = 1;
    self.integralArray  = [NSMutableArray array];

    [self getMyIntegralRecordWithData:[NSString stringWithFormat:@"%d", index]];

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
    
//    [self settingNavigationBarTitle:@"模板" textColor:nil titleFontSize:NAVIGATION_TITLE_FONT_SIZE];
    [self setNavWithLeftBarButton:NO title:@"我的积分"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.integralTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.integralTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0)];
}

#pragma mark - 接口数据
// 积分数据接口
- (void) getMyIntegralRecordWithData:(NSString *)page{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getMyIntegralRecord"];
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
                [self.integralArray removeAllObjects];
            }
            self.integralArray = [self myIntegralDispose:resultObject];
            [self.integralTableView reloadData];
        }else {
            NSLog(@"userinfo/getMyIntegralRecord%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/getMyIntegralRecord数据错误%@", error);
    }];
}

- (NSMutableArray *) myIntegralDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.integralArray page:index firstPage:1];
    for (NSDictionary * dict in param) {
        IntegralViewModel *model = [IntegralViewModel integralWithDict:dict];
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

    return self.integralArray.count;
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
    IntegralViewModel *model = self.integralArray[indexPath.row];
    IntegralTableViewCell *cell = [IntegralTableViewCell integralCellWithTableView:tableView forCellReuseIdentifier:cellID];
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
    return 55 ;
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
    index = 1 ;
    [self getMyIntegralRecordWithData:[NSString stringWithFormat:@"%d", index]];
    [self.integralTableView.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingData {
    index++;
    [self getMyIntegralRecordWithData:[NSString stringWithFormat:@"%d", index]];
    [self.integralTableView.mj_footer endRefreshing];
}

#pragma mark   -  所有控件懒加载
- (UITableView *) integralTableView {
    if (!_integralTableView) {
        _integralTableView                  = [[UITableView alloc] initForAutoLayout];
        _integralTableView.delegate         = self;
        _integralTableView.dataSource       = self;
//        _integralTableView.separatorStyle   = NO;//cell线隐藏
        _integralTableView.backgroundColor  = SWPColor(248, 248, 248, 1);
        [_integralTableView registerClass:[IntegralTableViewCell class] forCellReuseIdentifier:cellID];
        [self settingTableViewRefreshing:_integralTableView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
    }
    return _integralTableView;
}




@end
