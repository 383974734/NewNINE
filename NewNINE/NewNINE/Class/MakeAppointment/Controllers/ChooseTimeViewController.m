//
//  ChooseTimeViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 选择时间控制器

#import "ChooseTimeViewController.h"

// ---------------------- 框架工具类 ----------------------
#include <HTHorizontalSelectionList/HTHorizontalSelectionList.h>  // 分类显示
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "ChooseTimeCollectionViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "ChooseTimeModel.h"
// ---------------------- model      ----------------------

static NSString *cellID = @"collectionViewChooseTimeCell";

@interface ChooseTimeViewController ()<HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate,UICollectionViewDelegate, UICollectionViewDataSource, ChooseTimeModelDelegate>


#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 显示分类的View */
@property (strong, nonatomic) HTHorizontalSelectionList *hTHorizontalSelectionList;
/** 显示时间的View */
@property (strong, nonatomic) UICollectionView *collectionViewChooseTime;
/** 箭头图片 */
@property (nonatomic, strong) UIImageView      *imageView;
/** 箭头图片背景 */
@property (nonatomic, strong) UIView           *backView;
/** 预约背景 */
@property (nonatomic, strong) UIView           *timeAppointment;
/** 预约时间文字 */
@property (nonatomic, strong) UILabel          *lableAppointment;
/** 确定按钮 */
@property (nonatomic, strong) UIButton         *determine;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
@property (nonatomic, strong) NSArray *hTHorizontalArray;

@property (nonatomic, strong) NSArray *arrayAppointsTimes;

@property (nonatomic, strong) NSMutableArray *statusTime;

@end

@implementation ChooseTimeViewController

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
    self.statusTime = [NSMutableArray array];
    [self getAppointDatesWithData:self.stylistinfoId];
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

    [self setNavWithLeftBarButton:NO title:@"选择时间"];
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.hTHorizontalSelectionList];
    [self.view addSubview:self.backView];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.collectionViewChooseTime];
    
    [self.view addSubview:self.timeAppointment];
    [self.timeAppointment addSubview:self.lableAppointment];
    [self.timeAppointment addSubview:self.determine];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.timeAppointment autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.timeAppointment autoSetDimension:ALDimensionHeight toSize:50];
    
    [self.determine autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 10, 15) excludingEdge:ALEdgeLeft];
    [self.determine autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.lableAppointment autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(5, 15, 5, 0) excludingEdge:ALEdgeRight];
    [self.lableAppointment autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.determine withOffset:10];
}


#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    
}

#pragma mark - 接口数据
// 时间分类数据接口
- (void) getAppointDatesWithData:(NSString *)stylistinfoId {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/getAppointDates"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"stylistinfoId,%@", stylistinfoId],
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.hTHorizontalArray = [self appointDatesaDispose:resultObject];
            [self.hTHorizontalSelectionList reloadData];
            
            ChooseTimeModel *model = self.hTHorizontalArray[0];
            
            [self getAppointsTimesWithData:stylistinfoId currentDate:model.chooseAppointDate];
        }else {
            NSLog(@"book/getAppointDates%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/getAppointDates数据错误%@", error);
    }];
}

- (NSMutableArray *) appointDatesaDispose:(NSArray *)param {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary * dict in param) {
        ChooseTimeModel *model = [ChooseTimeModel chooseTimeWithDict:dict];
        [array addObject:model];
    }
    return array;
}

// 时间分类数据接口
- (void) getAppointsTimesWithData:(NSString *)stylistinfoId currentDate:(NSString *)currentDate {
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"book/getAppointsTimes"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"stylistinfoId,%@", stylistinfoId],//设计师ID
                       [NSString stringWithFormat:@"currentDate,%@"  , currentDate],  //日期 2015-12-27
//                     [NSString stringWithFormat:@"userCouponId,%@" , stylistinfoId],//优惠券ID
                       ];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            self.arrayAppointsTimes = [self appointTimesDispose:resultObject];
            [self.statusTime removeAllObjects];
            for (int i = 0; i < self.arrayAppointsTimes.count; i++) {
                [self.statusTime addObject:@"11"];
            }
            [self.collectionViewChooseTime reloadData];
        }else {
            NSLog(@"book/getAppointsTimes%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"book/getAppointsTimes数据错误%@", error);
    }];
}

- (NSMutableArray *) appointTimesDispose:(NSArray *)param {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary * dict in param) {
        ChooseTimeModel *model = [ChooseTimeModel appointsTimesWithDict:dict];
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
    return self.arrayAppointsTimes.count;
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChooseTimeModel *model             = self.arrayAppointsTimes[indexPath.row];
    ChooseTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.timeModel = model;
    if (self.arrayAppointsTimes.count == self.statusTime.count) {
        cell.status    = self.statusTime[indexPath.row];
    }
    cell.delegate  = self;
    cell.indexPath = indexPath;
    return cell;
    
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
    
}

- (void) chooseTimeCollectionViewCell:(ChooseTimeCollectionViewCell *)chooseTimeCollectionViewCell didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    for (int i = 0 ; i < self.statusTime.count; i ++) {
        [self.statusTime replaceObjectAtIndex:i withObject:@"11"];
    }
    
    [self.statusTime replaceObjectAtIndex:indexPath.row withObject:@"22"];
    [self.collectionViewChooseTime reloadData];
    ChooseTimeModel *model = self.arrayAppointsTimes[indexPath.row];
    [self titleWithName:[NSString stringWithFormat:@"预约时间:\n%@", model.chooseAppointTimes] lable:self.lableAppointment len:5 index:6];
}

//文字颜色
- (void) titleWithName:(NSString *)str lable:(UILabel *)lable len:(NSUInteger)len index:(NSUInteger)index{
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:str];
    [hintString addAttribute:NSForegroundColorAttributeName value:Color(64, 64, 64, 1) range:NSMakeRange(0, len)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[[hintString string] rangeOfString:[str substringFromIndex:index]]];
    lable.attributedText = hintString;
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
    return self.hTHorizontalArray.count;
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
    ChooseTimeModel *model = self.hTHorizontalArray[index];
//    NSDate *date = [self dateFromString:model.chooseAppointDate];
//    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
//    // NSDateComponent 可以获得日期的详细信息，即日期的组成
//    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:date];
//    
//    NSLog(@"年 = year = %ld",comps.year);
//    NSLog(@"月 = month = %ld",comps.month);
//    NSLog(@"日 = day = %ld",comps.day);
    return model.chooseAppointDate;
}

#pragma mark HTHorizontalSelectionList delegate
/**
 *  tableView 代理方法 点击每个cell (进入详情)
 *
 *  @param tableView
 *  @param indexPath
 */
- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    ChooseTimeModel *model = self.hTHorizontalArray[index];
    [self getAppointsTimesWithData:self.stylistinfoId currentDate:model.chooseAppointDate];

}

#pragma mark   -  所有控件懒加载

- (HTHorizontalSelectionList *) hTHorizontalSelectionList {
    
    if (!_hTHorizontalSelectionList) {
        _hTHorizontalSelectionList            = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH - 40, 50)];
        
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

- (UIImageView *) imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 85, 20, 20)];
        _imageView.image = [UIImage imageNamed:@"预约选择时间页面箭头"];
    }
    return _imageView;
}

- (UIView *) backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 72, 40, 43)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}


- (UICollectionView *) collectionViewChooseTime {
    if (!_collectionViewChooseTime) {
        
        UICollectionViewFlowLayout *flowLayout      = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing               = 0;
        flowLayout.minimumInteritemSpacing          = 0;
        flowLayout.itemSize                         = CGSizeMake( (SCREEN_WIDTH - 15) / 4, (SCREEN_WIDTH - 15) / 4);
        flowLayout.minimumLineSpacing               = 0; // gao
        flowLayout.minimumInteritemSpacing          = 0; // kuan
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionViewChooseTime = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 115,  SCREEN_WIDTH - 15, SCREEN_HEIGHT - 165) collectionViewLayout:flowLayout];
        _collectionViewChooseTime.backgroundColor                = Color(248, 248, 248, 1);
        _collectionViewChooseTime.delegate                       = self;
        _collectionViewChooseTime.dataSource                     = self;
        _collectionViewChooseTime.pagingEnabled                  = NO;
        _collectionViewChooseTime.showsHorizontalScrollIndicator = NO;
        _collectionViewChooseTime.showsVerticalScrollIndicator   = NO;
        [_collectionViewChooseTime registerClass:[ChooseTimeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
    }
    return _collectionViewChooseTime;
}

- (UIView *)timeAppointment {
    if (!_timeAppointment) {
        _timeAppointment = [[UIView alloc] initForAutoLayout];
        _timeAppointment.backgroundColor = [UIColor whiteColor];
    }
    return _timeAppointment;
}

- (UILabel *)lableAppointment {
    if (!_lableAppointment) {
        _lableAppointment = [[UILabel alloc] initForAutoLayout];
        _lableAppointment.numberOfLines = 0;
        _lableAppointment.font = SWP_SYSTEM_FONT_SIZE(14);
        _lableAppointment.text = @"预约时间:\n未预约";
        [self titleWithName:@"预约时间:\n未预约" lable:self.lableAppointment len:5 index:6];
        _lableAppointment.textAlignment =NSTextAlignmentLeft;
    }
    return _lableAppointment;
}

- (UIButton *)determine {
    if (!_determine) {
        _determine = [[UIButton alloc] initForAutoLayout];
        _determine.layer.borderColor     = [UIColor lightGrayColor].CGColor;
        _determine.layer.borderWidth     = 1;
        [_determine.layer setCornerRadius:3];
        [_determine setTitle:@"确定" forState:UIControlStateNormal];
        [_determine setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _determine;
}

@end
