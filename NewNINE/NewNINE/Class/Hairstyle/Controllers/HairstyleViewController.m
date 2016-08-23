//
//  HairstyleViewController.m
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  发型-----------> 发型控制器

#import "HairstyleViewController.h"
// ---------------------- 框架工具类   ----------------------
// ---------------------- 框架工具类   ----------------------

// ---------------------- controller ----------------------
#import "HomeDetailsViewController.h"
#import "MakeAppointmentViewController.h"
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "HairstyleCollectionViewCell.h"
#import "ClassificationView.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "HairstyleViewControllerModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"HairstyleCollectionViewCell";

@interface HairstyleViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ClassificationViewDelegate>

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** title名字*/
@property (nonatomic, strong) UILabel       *titleLable;
/** 导航下面的分类父视图*/
@property (nonatomic, strong) UIView        *classificationView;
/** 分类选择的变换图片（箭头）视图*/
@property (nonatomic, strong) UIImageView   *changeImageView;
/** 关注按钮*/
@property (nonatomic, strong) UIButton      *followButton;
/** 时间按钮*/
@property (nonatomic, strong) UIButton      *timeButton;
/** 分类按钮*/
@property (nonatomic, strong) UIButton      *classificationButton;

/** 发型展示列表*/
@property (nonatomic, strong) UICollectionView       *collectionViewHairstyle;
/** 发型展示view*/
@property (nonatomic, strong) ClassificationView     *classification;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
/** 关注按钮*/
@property (nonatomic, copy) NSString      *followStr;
/** 时间按钮*/
@property (nonatomic, copy) NSString      *timeStr;
/** 分类按钮*/
@property (nonatomic, copy) NSString      *classificationStr;
/** 关注状态按钮*/
@property (nonatomic, copy) NSString      *fucosDataStr;
/** 时间状态按钮*/
@property (nonatomic, copy) NSString      *timeDataStr;

/** 发型展示数据*/
@property (nonatomic, strong) NSMutableArray     *hairstyleArray;
/** 分类展示数据*/
@property (nonatomic, strong) NSMutableArray     *classificationArray;
@end

@implementation HairstyleViewController

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
    SetUserDefault(@"3", @"selectedIndex");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelOrderCallBack:) name:@"cancelOrderCallBack" object:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
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
    self.followStr          = @"1";
    self.timeStr            = @"1";
    self.classificationStr  = @"1";
    self.fucosDataStr       = @"";
    self.timeDataStr        = @"";
    index = 1 ;
    [self getOpusClassWithData];
    [self getOpusinfosWithData:[NSString stringWithFormat:@"%d", index] collect:self.fucosDataStr created:self.timeDataStr clasId:@""];
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
    
//    [self settingNavigationBarTitle:@"发型作品" textColor:nil titleFontSize:NAVIGATION_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.titleLable];
    [self.view addSubview:self.classificationView];
    [self.view addSubview:self.collectionViewHairstyle];
    [self.view addSubview:self.classification];
    [self setButton];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(22, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.titleLable autoSetDimension:ALDimensionHeight toSize:44];
    
    [self.classificationView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLable withOffset:1];
    [self.classificationView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.classificationView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.classificationView autoSetDimension:ALDimensionHeight toSize:36];
    
    [self.classification autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(105, 0, 0, 0) ];
    
}

#pragma mark - 接口数据
// 发型数据接口
- (void) getOpusinfosWithData:(NSString *)page collect:(NSString *)collect created:(NSString *)created clasId:(NSString *)clasId{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"opusinfo/getOpusinfos"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"page,%@", page],
                       [NSString stringWithFormat:@"collect,%@", collect],
                       [NSString stringWithFormat:@"created,%@", created],
                       [NSString stringWithFormat:@"clasId,%@", clasId],
                       ];
//    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            if ([page isEqualToString:@"0"]) {
                [self.hairstyleArray removeAllObjects];
            }
            self.hairstyleArray = [self hairstyleDispose:resultObject];
            
        }else {
            NSLog(@"opusinfo/getOpusinfos%@没有数据", url);
        }
        [self.collectionViewHairstyle reloadData];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"opusinfo/getOpusinfos数据错误%@", error);
    }];
}

- (NSMutableArray *) hairstyleDispose:(NSArray *)param {
    NSMutableArray *array = [MainCommonMethod chekPageWithDataSource:self.hairstyleArray page:index firstPage:1];
    for (NSDictionary * dict in param) {
        HairstyleViewControllerModel *model = [HairstyleViewControllerModel hairstyleWithDict:dict];
        [array addObject:model];
    }
    return array;
}

// 发型分类数据接口
- (void) getOpusClassWithData{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"opusinfo/getOpusClass"];
    NSArray *array = @[];
//    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            self.classificationArray        = resultObject;//[self hairstyleOpusClassDispose:resultObject];
            NSDictionary *allDic = @{
                                     @"clasName": @"全部",
                                     @"status": @"123",
                                     @"id": @"123",
                                     };
            if (self.classificationArray.count > 0)
            {
                [self.classificationArray insertObject:allDic atIndex:0];
                
            }
            self.classification.dataArray   = self.classificationArray;
            
        }else {
            NSLog(@"opusinfo/getOpusClass%@没有数据", url);
        }
        [self.collectionViewHairstyle reloadData];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"opusinfo/getOpusClass数据错误%@", error);
    }];
}

- (NSMutableArray *) hairstyleOpusClassDispose:(NSArray *)param {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary * dict in param) {
        HairstyleViewControllerModel *model = [HairstyleViewControllerModel hairstyleClasWithDict:dict];
        [array addObject:model];
    }
    return array;
}

#pragma mark - UICollectionView Delegate
//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"%lu",(unsigned long)self.hairstyleArray.count);
    return self.hairstyleArray.count;
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HairstyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
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

/**
 *  点击发型分类出点的下拉列表点击代理
 *
 *  @param classificationView ClassificationView
 *  @param classification     点击后相应的文字
 */
- (void)classificationView:(ClassificationView *)classificationView didSelectRowWithClassification:(NSString *)classification classificationID:(NSString *)classificationID{
    index = 1;
    [self.classificationButton removeFromSuperview];
    self.classification.hidden = !self.classification.hidden;
    if ([classification isEqualToString:@"全部"]) {
        self.classificationButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3 * 2 , 0, SCREEN_WIDTH / 3, 36) name:classification image:@"Slice" tag:2 titleColor:[UIColor redColor]];
        [self getOpusinfosWithData:[NSString stringWithFormat:@"%d", index] collect:self.fucosDataStr created:self.timeDataStr clasId:@""];
    }else {
        self.classificationButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3 * 2 , 0, SCREEN_WIDTH / 3, 36) name:classification image:@"arrow_down" tag:2 titleColor:[UIColor redColor]];
        [self getOpusinfosWithData:[NSString stringWithFormat:@"%d", index] collect:self.fucosDataStr created:self.timeDataStr clasId:classificationID];
    }
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [self.classificationView addSubview:self.classificationButton];
}

#pragma mark   -  所有控件懒加载
- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.backgroundColor = [UIColor whiteColor];
        _titleLable.text = @"发型";
        _titleLable.font = SWP_SYSTEM_FONT_SIZE(16);
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UIView *) classificationView {
    if (!_classificationView) {
        _classificationView = [[UIView alloc] initForAutoLayout];
        _classificationView.backgroundColor = [UIColor whiteColor];
    }
    return _classificationView;
}

- (UICollectionView *) collectionViewHairstyle {
    if (!_collectionViewHairstyle) {
        
        UICollectionViewFlowLayout *flowLayout      = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing               = 0;
        flowLayout.minimumInteritemSpacing          = 0;
        flowLayout.itemSize                         = CGSizeMake( (SCREEN_WIDTH - 40) / 2, (SCREEN_WIDTH - 40) / 2 + 46);
        flowLayout.minimumLineSpacing               = 15.0;
        flowLayout.minimumInteritemSpacing          = 5;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionViewHairstyle = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 110,  SCREEN_WIDTH - 30, SCREEN_HEIGHT - 120) collectionViewLayout:flowLayout];
        _collectionViewHairstyle.backgroundColor                = Color(248, 248, 248, 1);
        _collectionViewHairstyle.delegate                       = self;
        _collectionViewHairstyle.dataSource                     = self;
        _collectionViewHairstyle.pagingEnabled                  = NO;
        _collectionViewHairstyle.showsHorizontalScrollIndicator = NO;
        _collectionViewHairstyle.showsVerticalScrollIndicator   = NO;
        [self settingCollectionViewRefreshing:_collectionViewHairstyle target:self headerAction:@selector(headerRereshingData) footerAction:@selector(footerRereshingData)];
        [_collectionViewHairstyle registerClass:[HairstyleCollectionViewCell class] forCellWithReuseIdentifier:cellID];

    }
    return _collectionViewHairstyle;
}

- (ClassificationView *) classification {
    if (!_classification) {
        _classification             = [[ClassificationView alloc] initForAutoLayout];
        _classification.hidden      = YES;
        _classification.delegate    = self;
    }
    return _classification;
}

#pragma mark - 下拉刷新 -- 上拉加载
/**
 *  头部刷新方法(下拉刷新数据)
 */
- (void) headerRereshingData {
    index = 1;
    [self getOpusinfosWithData:[NSString stringWithFormat:@"%d", index] collect:self.fucosDataStr created:self.timeDataStr clasId:@""];
    [self.collectionViewHairstyle.mj_header endRefreshing];
}

/**
 *  头部刷新方法(上拉加载数据)
 */
- (void) footerRereshingData {
    index++;
    [self getOpusinfosWithData:[NSString stringWithFormat:@"%d", index] collect:self.fucosDataStr created:self.timeDataStr clasId:@""];
    [self.collectionViewHairstyle.mj_footer endRefreshing];
}

- (void) setButton {
    self.followButton = [self setButtonWithUI:CGRectMake(0 , 0, SCREEN_WIDTH / 3, 36) name:@"关注" image:@"arrow_default" tag:0 titleColor:Color(154, 154, 154, 1)];
    self.timeButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3  , 0, SCREEN_WIDTH / 3, 36) name:@"时间" image:@"arrow_default" tag:1 titleColor:Color(154, 154, 154, 1)];
    self.classificationButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3 * 2 , 0, SCREEN_WIDTH / 3, 36) name:@"发型分类" image:@"tri_default" tag:2 titleColor:Color(154, 154, 154, 1)];
    
    [self.classificationView addSubview:self.followButton];
    [self.classificationView addSubview:self.timeButton];
    [self.classificationView addSubview:self.classificationButton];
}

- (void) didView:(UIButton *)btn{
    if (btn.tag == 0) {
        if ([self.followStr isEqualToString:@"1"]) {
            self.fucosDataStr       = @"DESC" ;
            [self.followButton removeFromSuperview];
            self.followStr          = @"2";
            self.followButton       = [self setButtonWithUI:CGRectMake(0 , 0, SCREEN_WIDTH / 3, 36) name:@"关注" image:@"arrow_down" tag:0 titleColor:[UIColor redColor]];
        }else {
            self.fucosDataStr       = @"ASC" ;
            [self.followButton removeFromSuperview];
            self.followStr          = @"1";
            self.followButton       = [self setButtonWithUI:CGRectMake(0 , 0, SCREEN_WIDTH / 3, 36) name:@"关注" image:@"arrow_up" tag:0 titleColor:[UIColor redColor]];
        }
        [self getOpusinfosWithData:[NSString stringWithFormat:@"%@", @"0"] collect:self.fucosDataStr created:self.timeDataStr clasId:@""];
    }
    if (btn.tag == 1) {
        
        if ([self.timeStr isEqualToString:@"1"]) {
            [self.timeButton removeFromSuperview];
            self.timeDataStr        = @"DESC" ;
            self.timeStr            = @"2";
            self.timeButton         = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3  , 0, SCREEN_WIDTH / 3, 36) name:@"时间" image:@"arrow_down" tag:1 titleColor:[UIColor redColor]];
        }else {
            [self.timeButton removeFromSuperview];
            self.timeDataStr        = @"ASC" ;
            self.timeStr            = @"1";
            self.timeButton         = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3  , 0, SCREEN_WIDTH / 3, 36) name:@"时间" image:@"arrow_up" tag:1 titleColor:[UIColor redColor]];
        }
        [self getOpusinfosWithData:[NSString stringWithFormat:@"%@", @"0"] collect:self.fucosDataStr created:self.timeDataStr clasId:@""];
    }
    if (btn.tag == 2) {
        self.classification.hidden = NO;//!self.classification.hidden;
        
        __weak typeof(self) selfViewController = self;
        self.classification.buttonTouchUpInside = ^(){
            selfViewController.classification.hidden = YES;
            [selfViewController.rdv_tabBarController setTabBarHidden:!selfViewController.classification.hidden animated:YES];
        };
        [self.rdv_tabBarController setTabBarHidden:!self.classification.hidden animated:YES];
    }
    
    [self.classificationView addSubview:self.followButton];
    [self.classificationView addSubview:self.timeButton];
}

- (UIButton *) setButtonWithUI:(CGRect)frame name:(NSString *)name image:(NSString *)image tag:(NSInteger )tag titleColor:(UIColor *)color{
    UIButton *buttonView = [[UIButton alloc] initWithFrame:frame];
    buttonView.tag = tag;
    [buttonView addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *nameLable = [[UILabel alloc] init];
    
    if ([name isEqualToString:@"全部"]) {
        color = [UIColor lightGrayColor];
        name = @"发型分类";
        if (tag == 2) {
            if (![name isEqualToString:@"时间"] || ![name isEqualToString:@"关注"]) {
                image = @"tri_default";
            }
        }
    }else {
        if (tag == 2) {
            if ([name isEqualToString:@"发型分类"]) {
                image = @"tri_default";
            }else {
                image = @"Slice";
            }
        }
    }//tri_default
    
    nameLable.textColor = color;
    nameLable.text = name;
    CGSize size = [nameLable sizeThatFits:CGSizeMake(nameLable.frame.size.width, MAXFLOAT)];
    if (size.width > (SCREEN_WIDTH / 3 - 15)) {
        nameLable.frame = CGRectMake((SCREEN_WIDTH / 3 - size.width - 14) / 2 , 0, SCREEN_WIDTH / 3 , 36);
    }else {
        nameLable.frame = CGRectMake((SCREEN_WIDTH / 3 - size.width - 14) / 2 , 0, size.width, 36);
    }
    
    _changeImageView = [[UIImageView alloc] init];
    _changeImageView.image = [UIImage imageNamed:image];
    if (size.width > (SCREEN_WIDTH / 3 - 15)) {
        _changeImageView.frame = CGRectMake(SCREEN_WIDTH / 3 - 15, 11, 14, 14);
    }else {
        _changeImageView.frame = CGRectMake(SCREEN_WIDTH / 6 + (size.width / 2), 11, 14, 14);
    }
    [buttonView addSubview:nameLable];
    [buttonView addSubview:_changeImageView];
    
    return buttonView;
}


@end
