//
//  MyEvaluationViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的评价控制器

#import "MyEvaluationViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "MyEvaluationTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "MyEvaluationModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"myEvaluationTableViewCell";

@interface MyEvaluationViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
@property (nonatomic, strong) UITableView  *myEvaluationTableView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 我的评价数据*/
@property (nonatomic, strong) NSMutableArray *myEvaluationArray;

@end

@implementation MyEvaluationViewController

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
    index = 1 ;
    [self getUserCommentByUserIdWithData];
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
    
    [self setNavWithLeftBarButton:NO title:@"我的评价"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.myEvaluationTableView];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.myEvaluationTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(74, 0, 0, 0)];
}

#pragma mark - 接口数据
//我的评价接口
- (void) getUserCommentByUserIdWithData{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getUserCommentByUserId"];
    NSArray *array = nil;
    if (self.orderId.length > 0) {
        NSArray *arrayID = @[
                           [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],//账号
                           [NSString stringWithFormat:@"page,%@", [NSString stringWithFormat:@"%d", index]],//orderId
                           [NSString stringWithFormat:@"orderId,%@", self.orderId],
                           ];
        array = arrayID;
    }else {
        NSArray *arrayid = @[
                           [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],//账号
                           [NSString stringWithFormat:@"page,%@", [NSString stringWithFormat:@"%d", index]],//orderId
                           [NSString stringWithFormat:@"orderId,%@", @""],
                           ];
        array = arrayid;
    }
    
    //    [SVProgressHUD showWithStatus:HEADER_RERESHING_DATA_TITLE];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        //        [SVProgressHUD showInfoWithStatus:@"登录成功"];
        //        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.myEvaluationArray = [self userCommentByUserIdDispose:resultObject];
            [self.myEvaluationTableView reloadData];
        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/getUserCommentByUserId数据错误%@", error);
    }];
}


- (NSMutableArray *) userCommentByUserIdDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.myEvaluationArray page:index firstPage:1];
    for (NSDictionary * dict in param) {
        MyEvaluationModel *model = [MyEvaluationModel myEvaluationWithDict:dict];
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
    return self.myEvaluationArray.count;
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
    MyEvaluationModel *model = self.myEvaluationArray[indexPath.row];
    MyEvaluationTableViewCell *cell = [MyEvaluationTableViewCell myEvaluationCellWithTableView:tableView forCellReuseIdentifier:cellID];
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

    MyEvaluationModel *model = self.myEvaluationArray[indexPath.row];
    NSDictionary *dict = model.myUserComment;
    UIFont *font = [UIFont fontWithName:@"Arial" size:15];
    CGSize size = CGSizeMake(320,2000);
//    CGSize labelsize = [[dict objectForKey:@"content"] sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    
    NSDictionary *dictTemp = @{NSFontAttributeName : font};
    
    CGSize nameSize = [[dict objectForKey:@"content"] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dictTemp context:nil].size;
    
    
    NSArray *array = [dict objectForKey:@"photos"];
    if (array.count > 0) {
        return 120 + nameSize.height + 80;
    }else {
        return 120 + nameSize.height;
    }
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
    [self getUserCommentByUserIdWithData];
    [self.myEvaluationTableView.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingData {
    index++;
    [self getUserCommentByUserIdWithData];
    [self.myEvaluationTableView.mj_footer endRefreshing];
}


#pragma mark   -  所有控件懒加载
- (UITableView *) myEvaluationTableView {
    if (!_myEvaluationTableView) {
        _myEvaluationTableView              = [[UITableView alloc] initForAutoLayout];
        _myEvaluationTableView.delegate     = self;
        _myEvaluationTableView.dataSource   = self;
        [_myEvaluationTableView registerClass:[MyEvaluationTableViewCell class] forCellReuseIdentifier:cellID];
        [self settingTableViewRefreshing:_myEvaluationTableView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
        _myEvaluationTableView.separatorStyle = NO;//cell线隐藏
//        _myEvaluationTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        
//        _myEvaluationTableView.estimatedRowHeight = 200;
//        _myEvaluationTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _myEvaluationTableView;
}



@end
