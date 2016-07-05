//
//  ModalViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/4.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ModalViewController.h"

// ---------------------- 框架工具类   ----------------------
// ---------------------- 框架工具类   ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
#import "ModalTableViewCell.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

static NSString *cellID = @"ModalTableViewCellID";

@interface ModalViewController ()<UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>


#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 选项背景视图*/
@property (nonatomic, strong) UIView *backView;
/** 选项类别视图*/
@property (nonatomic, strong) UILabel *titleLable;
/** 取消按钮*/
@property (nonatomic, strong) UIButton *cancelButton;
/** 确定按钮*/
@property (nonatomic, strong) UIButton *determineButton;
/** 长发，中发，短发*/
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

/** 选项视图*/
@property (nonatomic, strong) UITableView *modalTableView;
/** 长发，中发，短发 高变化值*/
@property (nonatomic, strong) NSLayoutConstraint *segmentedControlFrame;
/** 选项 高变化值*/
@property (nonatomic, strong) NSLayoutConstraint *modalTableViewFrame;
#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------


@end

@implementation ModalViewController


#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 创建 单个手指单次点击 手势对象
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    singleTapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
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
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.modalTableView];
    [self.backView addSubview:self.titleLable];
    [self.backView addSubview:self.cancelButton];
    [self.backView addSubview:self.determineButton];
    [self.backView addSubview:self.segmentedControl];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(15, 15, 0, 15) excludingEdge:ALEdgeBottom];
    [self.titleLable autoSetDimension:ALDimensionHeight toSize:25];
    
    [self.segmentedControl autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLable withOffset:10];
    [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    self.segmentedControlFrame = [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.modalTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.segmentedControl withOffset:10];
    [self.modalTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:-1];
    [self.modalTableView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:-1];
    self.modalTableViewFrame = [self.modalTableView autoSetDimension:ALDimensionHeight toSize:130];
    
    [self.determineButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.modalTableView withOffset:10];
    [self.determineButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.determineButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.determineButton autoSetDimension:ALDimensionWidth toSize:70];
    [self.determineButton autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.cancelButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.cancelButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.determineButton withOffset:-10];
    [self.cancelButton autoSetDimension:ALDimensionWidth toSize:70];
    [self.cancelButton autoSetDimension:ALDimensionHeight toSize:30];
    
}
-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer
{
    // 处理单次点击事件
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView* touchedView = [touch view];
    if(touchedView.tag == 1001) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    // 处理单次点击事件
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 实现oneSegmentedControl的监听事件
- (void)segmentedControlAction:(UISegmentedControl *) sender {
    // 获取当前的选中项的索引值
    NSUInteger index = sender.selectedSegmentIndex;
    // 判断索引值
    switch (index) {
        case 0:
            NSLog(@"第一项被选中");
            break;
        case 1:
            NSLog(@"第二项被选中");
            break;
        case 2:
            NSLog(@"第三项被选中");
            break;
        default:
            break;
    }
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

    return 3;
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
    ModalTableViewCell *cell = [ModalTableViewCell modalTableViewCellWithTableView:tableView forCellReuseIdentifier:cellID];
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
    return 45 ;
}



#pragma mark   -  所有控件懒加载

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initForAutoLayout];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.tag             = 1001;
    }
    return _backView;
}

- (UITableView *)modalTableView {
    if (!_modalTableView) {
        _modalTableView                   = [[UITableView alloc] initForAutoLayout];
        _modalTableView.delegate          = self;
        _modalTableView.dataSource        = self;
        _modalTableView.tag               = 1001;
        _modalTableView.layer.borderWidth = 0.5;
        _modalTableView.scrollEnabled     = NO;
        _modalTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_modalTableView registerClass:[ModalTableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _modalTableView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.text = @"烫染";
    }
    return _titleLable;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initForAutoLayout];
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.layer.borderColor = [UIColor redColor].CGColor;
        [_cancelButton.layer setCornerRadius:3];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)determineButton {
    if (!_determineButton) {
        _determineButton = [[UIButton alloc] initForAutoLayout];
        _determineButton.layer.borderWidth = 1;
        _determineButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [_determineButton.layer setCornerRadius:3];
        [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
        [_determineButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_determineButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineButton;
}

- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl                       = [[UISegmentedControl alloc] initWithItems:@[@"长发", @"中发", @"短发"]];
        _segmentedControl.tintColor             = [UIColor redColor]; // 选中的颜色
        _segmentedControl.selectedSegmentIndex  = 1;
        _segmentedControl.backgroundColor       = [UIColor whiteColor];
        _segmentedControl.layer.borderColor     = [UIColor redColor].CGColor;
        _segmentedControl.momentary             = NO; // 设置点击后是否恢复原样, 默认是NO， 不恢复
        [_segmentedControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

@end
