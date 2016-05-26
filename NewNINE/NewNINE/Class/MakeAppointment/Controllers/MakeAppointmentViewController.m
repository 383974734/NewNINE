//
//  MakeAppointmentViewController.m
//  VeryBeautiful
//
//  Created by yinduo-zdy on 16/5/19.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 预约控制器

#import "MakeAppointmentViewController.h"

@interface MakeAppointmentViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation MakeAppointmentViewController

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
    
    [self settingNavigationBarTitle:@"预约美发" textColor:nil titleFontSize:NAVIGATION_TITLE_FONT_SIZE];
}

/**
 *  添加控件
 */
- (void) addUI {
    
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
}


#pragma mark   -  所有控件懒加载

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
