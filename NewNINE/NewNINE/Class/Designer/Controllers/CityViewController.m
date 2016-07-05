//
//  CityViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 定位城市，当前城市控制器

#import "CityViewController.h"

// ---------------------- 框架工具类 ----------------------
#import "GBTagListView.h"
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface CityViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 导航视图*/
@property (nonatomic, strong) UIView *navView;
/** 返回按钮*/
@property (nonatomic, strong) UIButton *returnButton;

/** 导航文字*/
@property (nonatomic, strong) UILabel *titleLable;

/** 定位城市*/
@property (nonatomic, strong) UILabel *locationCity;

/** 热门城市*/
@property (nonatomic, strong) UILabel *hotCity;

/** 分割线*/
@property (nonatomic, strong) UIView *lineView;

/** 分割线*/
@property (nonatomic, strong) UIView *lineView1;
/** 定位button*/
@property (nonatomic, strong) GBTagListView *locationBtn;
/** 热门button*/
@property (nonatomic, strong) GBTagListView *hotBtn;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation CityViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
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
}

/**
 *  添加控件
 */
- (void) addUI {
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.returnButton];
    [self.navView addSubview:self.titleLable];
    
    [self.view addSubview:self.locationCity];
    [self.view addSubview:self.hotCity];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.lineView1];
    
    [self locationBtnView];
    [self hotBtnView];
}

- (void)locationBtnView {
    NSArray *array              = @[self.locationCityStr];
    self.locationBtn            = [[GBTagListView alloc]initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH - 20, 0)];
    self.locationBtn.canTouch   = YES;
    self.locationBtn.notClickButtonName = GetUserDefault(@"hotCity");//self.locationCityStr;//[self.locationCityStr componentsSeparatedByString:@"-"][1];
    self.locationBtn.signalTagColor     = [UIColor clearColor];
    [self.locationBtn setTagWithTagArray:array];
    [self.view addSubview:self.locationBtn];
    __weak __typeof(self)weakSelf = self;
    
    [self.locationBtn setDidselectItemBlock:^(NSArray *arr) {
        NSLog(@"%@",arr);
        SetUserDefault([arr objectAtIndex:0], @"hotCity");//热门城市选择
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    }];
}

- (void) hotBtnView {
    NSArray *strArray       = self.cityArray;
    self.hotBtn             = [[GBTagListView alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 0)];
    self.hotBtn.cityName    = GetUserDefault(@"hotCity");
    self.lineView1.frame    = CGRectMake(20, 240 + self.locationBtn.frame.size.height, SCREEN_WIDTH - 40, 1);
    self.hotBtn.canTouch    = YES;
    self.hotBtn.notClickButtonName = GetUserDefault(@"hotCity");//self.locationCityStr;//[self.locationCityStr componentsSeparatedByString:@"-"][1];
    self.hotBtn.signalTagColor     = [UIColor clearColor];
    [self.hotBtn setTagWithTagArray:strArray];
    [self.view addSubview:self.hotBtn];
    __weak __typeof(self)weakSelf  = self;
    [self.hotBtn setDidselectItemBlock:^(NSArray *arr) {
        NSLog(@"%@",arr);
        SetUserDefault([arr objectAtIndex:0], @"hotCity");//热门城市选择
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
    }];
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.navView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(22, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.navView autoSetDimension:ALDimensionHeight toSize:42];
    
    [self.returnButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [self.returnButton autoSetDimension:ALDimensionWidth toSize:60];
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
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
}

#pragma mark   -  所有控件懒加载

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initForAutoLayout];
    }
    return _navView;
}

- (UIButton *) returnButton {
    if (!_returnButton) {
        _returnButton = [[UIButton alloc] initForAutoLayout];
        _returnButton.tag = 1001;
        [_returnButton setImage:[UIImage imageNamed:@"closeOrder"] forState:UIControlStateNormal];
        [_returnButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}

- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = SWP_SYSTEM_FONT_SIZE(16);
        if (GetUserDefault(@"hotCity") != nil) {
            _titleLable.text = [NSString stringWithFormat:@"当前城市-%@", GetUserDefault(@"hotCity")];
        }else {
            _titleLable.text = [NSString stringWithFormat:@"当前城市-%@", @"哈尔滨"];
        }
    }
    return _titleLable;
}

-(UILabel *)locationCity {
    
    if (!_locationCity) {
        _locationCity = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 40)];
        _locationCity.font = [UIFont systemFontOfSize:16];
        _locationCity.text = @"定位城市";
    }
    return _locationCity;
}

-(UILabel *)hotCity{
    if (!_hotCity) {
        _hotCity = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 100, 40)];
        _hotCity.font = [UIFont systemFontOfSize:16];
        _hotCity.text = @"热门城市";
    }
    return _hotCity;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH - 40, 1)];
        _lineView.backgroundColor = Color(154, 154, 154, 1);
        _lineView.alpha = 0.5f;
        
    }
    
    return _lineView;
}

-(UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 400, SCREEN_WIDTH - 40, 1)];
        _lineView1.backgroundColor = Color(154, 154, 154, 1);
        _lineView1.alpha = 0.5f;
    }
    
    return _lineView1;
}

@end
