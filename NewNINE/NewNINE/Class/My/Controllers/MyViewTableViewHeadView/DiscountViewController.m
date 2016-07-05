//
//  DiscountViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器 --优惠劵

#import "DiscountViewController.h"

// ---------------------- 框架工具类 ----------------------
#include <HTHorizontalSelectionList/HTHorizontalSelectionList.h>  // 分类显示
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "DiscountTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "DiscountViewModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"discountdTableViewCellID";

@interface DiscountViewController ()<UITableViewDelegate, UITableViewDataSource, HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 优惠劵 展示控件*/
@property (nonatomic, strong) UITableView   *discountdTableView;
/**  没有数据时  显示的图片控件*/
@property (nonatomic, strong) UIImageView   *nilImageView;
/**  没有数据时  显示的文字控件*/
@property (nonatomic, strong) UILabel       *nilLabel;

/** 显示分类的View */
@property (strong, nonatomic) HTHorizontalSelectionList *hTHorizontalSelectionList;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 优惠劵 数据*/
@property (nonatomic, strong)NSMutableArray *discountdArray;

@property (nonatomic, copy) NSString *status;

@end

@implementation DiscountViewController

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
    self.discountdArray  = [NSMutableArray array];
    
    [self getMyCouponRecordWithData:[NSString stringWithFormat:@"%d", index] status:@"1"];
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

    [self setNavWithLeftBarButton:NO title:@"优惠劵"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.hTHorizontalSelectionList];
    [self.view addSubview:self.discountdTableView];
    
    [self.view addSubview:self.nilImageView];
    [self.view addSubview:self.nilLabel];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.discountdTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(110, 0, 0, 0)];

    [self.nilImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(SCREEN_HEIGHT  / 2 - 100, SCREEN_WIDTH / 2 - 40, 0, SCREEN_WIDTH / 2 - 40) excludingEdge:ALEdgeBottom];
    [self.nilImageView autoSetDimension:ALDimensionHeight toSize:80];
    
    [self.nilLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nilImageView withOffset:15];
    [self.nilLabel autoSetDimension:ALDimensionHeight toSize:40];
    [self.nilLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.nilLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
}

#pragma mark - 接口数据
// 优惠劵数据接口
- (void) getMyCouponRecordWithData:(NSString *)page status:(NSString *)status {
    self.status = status;
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getMyCoupon"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@"  , GetUserDefault(userUid)],
                       [NSString stringWithFormat:@"page,%@"    , page],
                       [NSString stringWithFormat:@"status,%@"  , status],// 1、未使用 2、已使用3、已到期
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([page isEqualToString:@"1"]) {
                [self.discountdArray removeAllObjects];
            }
            self.discountdArray = [self myCouponDispose:resultObject];
            if (self.discountdArray.count > 0) {
                self.discountdTableView.hidden = NO;
                self.nilImageView.hidden       = YES;
                self.nilLabel.hidden           = YES;
                [self.discountdTableView reloadData];
            }else {
                self.discountdTableView.hidden = YES;
                self.nilImageView.hidden       = NO;
                self.nilLabel.hidden           = NO;
            }
            
        }else {
            NSLog(@"userinfo/getMyCoupon%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"userinfo/getMyCoupon数据错误%@", error);
    }];
}

- (NSMutableArray *) myCouponDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.discountdArray page:index firstPage:1];
    for (NSDictionary * dict in param) {
        DiscountViewModel *model = [DiscountViewModel discountWithDict:dict];
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
    
    return self.discountdArray.count;
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
    
    DiscountViewModel *model = self.discountdArray[indexPath.row];
    DiscountTableViewCell *cell = [DiscountTableViewCell discountCellWithTableView:tableView forCellReuseIdentifier:cellID];
    cell.status = self.status;
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
    return 147;
}

#pragma mark HTHorizontalSelectionList dataSource
/**
 *  HTHorizontalSelectionList  数据源方法（设置分类显示的数据个数）
 *
 *  @param selectionList
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return 3;
}

/**
 *  HTHorizontalSelectionList  数据源方法（设置分类显示的数据内容）
 *
 *  @param selectionList
 *  @param index
 *
 *  @return NSString
 */
- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    NSArray *array = @[@"未使用", @"已使用", @"已到期"];
    NSString *str = array[index];
    return str;
}

#pragma mark HTHorizontalSelectionList delegate
/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    [self getMyCouponRecordWithData:@"1" status:[NSString stringWithFormat:@"%ld", index + 1]];
    
}

#pragma mark - 下拉刷新 -- 上拉加载
/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) headerRereshingData {
    index = 1;
    [self getMyCouponRecordWithData:[NSString stringWithFormat:@"%d", index] status:self.status];
    [self.discountdTableView.mj_header endRefreshing];
}

/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) footerRereshingData {
    index++;
    [self getMyCouponRecordWithData:[NSString stringWithFormat:@"%d", index] status:self.status];
    [self.discountdTableView.mj_footer endRefreshing];
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
- (UITableView *) discountdTableView {
    if (!_discountdTableView) {
        _discountdTableView                  = [[UITableView alloc] initForAutoLayout];
        _discountdTableView.delegate         = self;
        _discountdTableView.dataSource       = self;
        //        _integralTableView.separatorStyle   = NO;//cell线隐藏
        [_discountdTableView registerClass:[DiscountTableViewCell class] forCellReuseIdentifier:cellID];
        [self settingTableViewRefreshing:_discountdTableView target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
    }
    return _discountdTableView;
}


#pragma mark 所有控件的懒加载
- (HTHorizontalSelectionList *) hTHorizontalSelectionList {
    
    if (!_hTHorizontalSelectionList) {
        _hTHorizontalSelectionList            = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, 45)];
        
        _hTHorizontalSelectionList.delegate   = self;
        _hTHorizontalSelectionList.dataSource = self;
        _hTHorizontalSelectionList.centerAlignButtons = YES;
        [_hTHorizontalSelectionList setTitleFont:SWP_SYSTEM_FONT_SIZE(18) forState:UIControlStateNormal];
        [_hTHorizontalSelectionList setTitleFont:SWP_SYSTEM_FONT_SIZE(16) forState:UIControlStateSelected];
        _hTHorizontalSelectionList.selectionIndicatorColor = [UIColor redColor];
        [_hTHorizontalSelectionList setTitleFont:[UIFont systemFontOfSize:14] forState:UIControlStateNormal];
    }
    return _hTHorizontalSelectionList;
}

- (UIImageView *) nilImageView {
    if (!_nilImageView) {
        _nilImageView = [[UIImageView alloc] initForAutoLayout];
        _nilImageView.image = [UIImage imageNamed:@"优惠券缺省"];
        _nilImageView.hidden = YES;
    }
    return _nilImageView;
}

- (UILabel *) nilLabel {
    if (!_nilLabel) {
        _nilLabel = [[UILabel alloc] initForAutoLayout];
        _nilLabel.text = @"暂无优惠劵记录";
        _nilLabel.textColor = Color(154, 154, 154, 1);
        _nilLabel.textAlignment = NSTextAlignmentCenter;
        _nilLabel.hidden = YES;
    }
    return  _nilLabel;
}

@end
