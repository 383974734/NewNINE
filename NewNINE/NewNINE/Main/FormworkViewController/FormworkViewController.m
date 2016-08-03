//
//  FormworkViewController.m
//  TourBottle
//
//  Created by songweiping on 15/5/21.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#import "FormworkViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface FormworkViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation FormworkViewController

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
    
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    
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





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView

//#pragma mark UITableView DataSource
///**
// *  tableView 数据源方法 返回tabvelView 分组个数
// *
// *  @param tableView
// *
// *  @return NSInteger
// */
//- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}
//
///**
// *  tableView 数据源方法  返回tableView 每个分组中cell的个数
// *
// *  @param tableView
// *  @param section
// *
// *  @return NSInteger
// */
//- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return 3;
//}
//
///**
// *  tableView 数据源方法 返回每个cell显示的样式和数据
// *
// *  @param  tableView
// *  @param  indexPath
// *
// *  @return OrderTableViewCell
// */
//- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
///**
// *  tableView 代理方法 点击每个cell (进入详情)
// *
// *  @param tableView
// *  @param indexPath
// */
//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
///**
// *  tableView 代理方法 返回对应索引返回的row的高度
// *
// *  @param tableView
// *  @param indexPath
// *
// *  @return CGFloat
// */
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 120 ;
//}




#pragma mark - TableViewCell

///**
// *  快速  初始化 一个自定义cell
// *
// *  @param tableView
// *  @param cellID
// *
// *  @return HomeTableViewCell
// */
//+ (instancetype) homeCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
//    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    cell.selectionStyle     = UITableViewCellEditingStyleNone;
//    return cell;
//}
//
///**
// *  重写 cell 初始化方法 自定义cell
// *
// *  @param style
// *  @param reuseIdentifier
// *
// *  @return PopAlertTableViewCell
// */
//- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self addUI];
//    }
//    return self;
//}
//
//
///**
// *  添加cell上的控件
// */
//- (void) addUI {
//    
//}
//
///**
// * 系统方法 设置控件位置
// */
//- (void) layoutSubviews {
//    [super layoutSubviews];
//}



//                [SVProgressHUD showWithStatus:@"请选择设计师"];// 加载圈
//                [SVProgressHUD showSuccessWithStatus:@"请选择设计师"];// 对号
//                [SVProgressHUD setStatus:@"请选择设计师"];// 不显示
//                [SVProgressHUD showInfoWithStatus:@"请选择设计师"];// 感叹号
//                [SVProgressHUD showErrorWithStatus:@"请选择设计师"];//叉

@end
