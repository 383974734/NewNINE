//
//  ScreenViewController.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 筛选控制器

#import "ScreenViewController.h"

// ---------------------- 框架工具类 ----------------------
// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "StylistLevlsModel.h"
// ---------------------- model      ----------------------

@interface ScreenViewController ()

#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 导航视图*/
@property (nonatomic, strong) UIView *navView;
/** 内容视图*/
@property (nonatomic, strong) UIView *contentView;

/** 返回按钮*/
@property (nonatomic, strong) UIButton *returnButton;

/** 导航文字*/
@property (nonatomic, strong) UILabel *titleLable;

/** 确定按钮*/
@property (nonatomic, strong) UIButton *determineButton;

/** 职位文字*/
@property (nonatomic, strong) UILabel *positionLable;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@property (nonatomic, copy) NSString *stylistLevlsStr;

@property (nonatomic, strong) NSMutableArray *stylistLevlsbtns;

@end

@implementation ScreenViewController

#pragma mark - Lifecycle Methods
/**
 *  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
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
//    [self getStudiosWithData];
    self.stylistLevlsbtns = [NSMutableArray array];
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
    [self.view addSubview:self.navView];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.determineButton];
    
    [self.navView addSubview:self.returnButton];
    [self.navView addSubview:self.titleLable];
    
    [self.contentView addSubview:self.positionLable];
    
    [self addUIButton];
}


/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.navView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(22, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.navView autoSetDimension:ALDimensionHeight toSize:42];
    
    [self.contentView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(65, 0, 100, 0)];
//    [self.contentView autoSetDimension:ALDimensionHeight toSize:120];
    
    [self.determineButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:25];
    [self.determineButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:25];
    [self.determineButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.contentView withOffset:25];
    [self.determineButton autoSetDimension:ALDimensionHeight toSize:45];
    
    [self.returnButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [self.returnButton autoSetDimension:ALDimensionWidth toSize:60];
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.positionLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [self.positionLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.positionLable autoSetDimension:ALDimensionWidth toSize:40];
    [self.positionLable autoSetDimension:ALDimensionHeight toSize:30];
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
    if (button.tag == 1002) {
        NSMutableArray *stylistLevlsStrArray=[[NSMutableArray alloc] init];
        
        for (UIButton *btn in self.stylistLevlsbtns) {
            if (btn.selected) {
                [stylistLevlsStrArray addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
            }
        }
        self.stylistLevlsStr = [stylistLevlsStrArray componentsJoinedByString:@","];
        
        if (self.screenViewID) {
            self.screenViewID(self.stylistLevlsStr);
        }
        
//        SetUserDefault(self.stylistLevlsStr, @"stylistLevlsStr");//设计师职位ID
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 美发师 门店
- (void) getStudiosWithData{
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"stylistinfo/getStudios"];
    NSArray *array = @[];
    [SVProgressHUD showWithStatus:DATA_GET_DATA];
    [MainRequestTool mainGET:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            
        }else {
            NSLog(@"stylistinfo/getStudios%@没有数据", url);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"stylistinfo/getStudios数据错误%@", error);
    }];
}

#pragma mark   -  所有控件懒加载
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initForAutoLayout];
        _navView.backgroundColor = [UIColor whiteColor];
    }
    return _navView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initForAutoLayout];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIButton *) returnButton {
    if (!_returnButton) {
        _returnButton = [[UIButton alloc] initForAutoLayout];
        _returnButton.tag = 1001;
        _returnButton.titleLabel.font = SWP_SYSTEM_FONT_SIZE(15);
        [_returnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_returnButton setTitle:@"取消" forState:UIControlStateNormal];
        [_returnButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnButton;
}

- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.text = @"筛选";
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = SWP_SYSTEM_FONT_SIZE(16);
    }
    return _titleLable;
}

- (UIButton *) determineButton {
    if (!_determineButton) {
        _determineButton = [[UIButton alloc] initForAutoLayout];
        _determineButton.tag = 1002;
        _determineButton.backgroundColor = [UIColor redColor];
//        [_determineButton.layer setMasksToBounds:YES];
        [_determineButton.layer setCornerRadius:5.0];
        _determineButton.titleLabel.font = SWP_SYSTEM_FONT_SIZE(16);
        [_determineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_determineButton setTitle:@"确定" forState:UIControlStateNormal];
        [_determineButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _determineButton;
}

- (UILabel *) positionLable {
    if (!_positionLable) {
        _positionLable = [[UILabel alloc] initForAutoLayout];
        _positionLable.text = @"职位";
        _positionLable.font = SWP_SYSTEM_FONT_SIZE(16);
    }
    return _positionLable;
}


- (void)addUIButton{
    int x = 10;
    int y = 45;
    if (self.arrayData.count > 0) {
        for (int i = 0; i < self.arrayData.count; i ++) {
            StylistLevlsModel *model = [[StylistLevlsModel alloc] init];
            model = [self.arrayData objectAtIndex:i];
            NSString *levlNames = model.stylistLevlsLevlNames;
            
//            CGSize size = [levlNames sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 50)lineBreakMode:UILineBreakModeCharacterWrap];
            CGSize size = CGSizeMake(320,20);
            
            NSDictionary *dict = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13]};
            
            CGSize nameSize = [levlNames boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
            
            int buttonWidth = nameSize.width + 20 ;
            
            if (x + buttonWidth + 10 >SCREEN_WIDTH) {
                y+= 36 ;
                x = 10 ;
            }
            
            UIButton *levButton          = [[UIButton alloc] initWithFrame:CGRectMake(x, y, buttonWidth, 26)];
            levButton.layer.borderWidth  = 0.5;
            levButton.layer.borderColor  = Color(154, 154, 154, 1).CGColor;
            levButton.titleLabel.font    = [UIFont boldSystemFontOfSize:13];
            levButton.tag                = model.stylistLevlsID.integerValue;
            
            [levButton.layer setCornerRadius:2.0];
            [levButton setTitle:levlNames forState:UIControlStateNormal];
            [levButton setTitleColor:Color(154, 154, 154, 1) forState:UIControlStateNormal];
            [levButton addTarget:self action:@selector(stylistLevlsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            x += buttonWidth ;
            x += 10 ;
            
            UIImageView *image  = [[UIImageView alloc] initWithFrame:CGRectMake(buttonWidth - 12, 26 - 11, 12, 11)];
            image.image         = [UIImage imageNamed:@"筛选角标"];
            image.hidden        = YES;
            image.tag           = 88;
            [levButton addSubview:image];
            
//            NSArray *_arr = [GetUserDefault(@"stylistLevlsStr") componentsSeparatedByString:NSLocalizedString(@",", nil)];
            NSArray *_arr = [self.stylistLevlsStrID componentsSeparatedByString:NSLocalizedString(@",", nil)];
            for (NSString * idStr in _arr) {
                if ([idStr intValue]== (int)levButton.tag) {
                    levButton.selected = YES;
                }
            }
            
            if (levButton.selected) {
                image.hidden                 = NO;
                levButton.layer.borderColor  = [UIColor redColor].CGColor;
                [levButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }else {
                image.hidden                 = YES;
                levButton.layer.borderColor  = Color(154, 154, 154, 1).CGColor;
                [levButton setTitleColor:Color(154, 154, 154, 1) forState:UIControlStateNormal];
            }
            [self.stylistLevlsbtns addObject:levButton];
            NSLog(@"%@", self.stylistLevlsbtns);
            [self.contentView addSubview:levButton];
            
        }
    }
}

- (void) setArrayData:(NSMutableArray *)arrayData {
    _arrayData = arrayData;
    
}

- (void)stylistLevlsBtnClick:(UIButton *)btn {
    NSLog(@"%@", btn.subviews);
    btn.selected = !btn.selected ;
    if (btn.selected ) {
        //--------  添加筛选角标
        for (UIView  * view in btn.subviews) {
            if (view.tag == 88) {
                view.hidden = NO;
            }
        }
        //--------  添加筛选角标
        btn.layer.borderColor = [UIColor redColor].CGColor;
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else
    {
        //--------  添加筛选角标
        for (UIView  * view in btn.subviews) {
            if (view.tag == 88) {
                view.hidden = YES;
            }
        }
        //--------  添加筛选角标
        btn.layer.borderColor = Color(154, 154, 154, 1).CGColor;
        [btn setTitleColor:Color(154, 154, 154, 1) forState:UIControlStateNormal];
    }

}

@end
