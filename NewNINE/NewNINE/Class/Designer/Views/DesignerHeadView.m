//
//  DesignerHeadView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 设计师控制器 导航

#import "DesignerHeadView.h"

@interface DesignerHeadView ()

/** title名字*/
@property (nonatomic, strong) UILabel       *titleLable;
/** 导航下面的分类父视图*/
@property (nonatomic, strong) UIView        *classificationView;
/** 分类选择的变换图片（箭头）视图*/
@property (nonatomic, strong) UIImageView   *changeImageView;
/** 区域按钮*/
@property (nonatomic, strong) UIButton      *followButton;
/** 排序按钮*/
@property (nonatomic, strong) UIButton      *timeButton;
/** 筛选按钮*/
@property (nonatomic, strong) UIButton      *classificationButton;
/** 城市按钮*/
@property (nonatomic, strong) UIButton      *cityButton;
/** 搜索按钮*/
@property (nonatomic, strong) UIButton      *searchButton;
@end

@implementation DesignerHeadView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.titleLable];
    [self addSubview:self.classificationView];
    [self addSubview:self.searchButton];
    [self setButton];
    
}

- (void)settingAutoLayout {
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(22, 0, 0, 0) excludingEdge:ALEdgeBottom];
    [self.titleLable autoSetDimension:ALDimensionHeight toSize:44];
}

- (void)settingData {
    
}

- (void) setButton {
    self.cityButton = [self setButtonWithUI:CGRectMake(0, 25, SCREEN_WIDTH / 3, 40) name:@"哈尔滨" image:@"screen－arrow－down" tag:3 titleColor:Color(154, 154, 154, 1)];
    self.followButton = [self setButtonWithUI:CGRectMake(0 , 67, SCREEN_WIDTH / 3, 36) name:@"全部区域" image:@"screen－arrow－down" tag:0 titleColor:Color(154, 154, 154, 1)];
    self.timeButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3  , 67, SCREEN_WIDTH / 3, 36) name:@"智能排序" image:@"screen－arrow－down" tag:1 titleColor:Color(154, 154, 154, 1)];
    self.classificationButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3 * 2 , 67, SCREEN_WIDTH / 3, 36) name:@"筛选" image:@"Shape" tag:2 titleColor:Color(154, 154, 154, 1)];
    
    [self addSubview:self.cityButton];
    [self addSubview:self.followButton];
    [self addSubview:self.timeButton];
    [self addSubview:self.classificationButton];
}

#pragma mark   -  所有控件懒加载
- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.backgroundColor = [UIColor whiteColor];
        _titleLable.text = @"设计师";
        _titleLable.font = SWP_SYSTEM_FONT_SIZE(16);
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}

- (UIView *) classificationView {
    if (!_classificationView) {
        _classificationView = [[UIView alloc] initForAutoLayout];
        _classificationView.backgroundColor = [UIColor whiteColor];
        _classificationView.userInteractionEnabled = YES;
    }
    return _classificationView;
}

- (UIButton *) searchButton {
    if (!_searchButton) {
        _searchButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 34, 24, 24)];
        [_searchButton setImage:[UIImage imageNamed:@"dsearch"] forState:UIControlStateNormal];
        _searchButton.tag = 4;
        [_searchButton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (void) didView:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(designerHeadView:buttonWithTag:)]) {
        [self.delegate designerHeadView:self buttonWithTag:btn];
    }
}

- (UIButton *) setButtonWithUI:(CGRect)frame name:(NSString *)name image:(NSString *)image tag:(NSInteger )tag titleColor:(UIColor *)color{
    UIButton *buttonView = [[UIButton alloc] initWithFrame:frame];
    buttonView.tag = tag;
    [buttonView addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *nameLable = [[UILabel alloc] init];
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
        _changeImageView.frame = CGRectMake(SCREEN_WIDTH / 3 - 15, 14, 10, 8);
    }else {
        _changeImageView.frame = CGRectMake(SCREEN_WIDTH / 6 + (size.width / 2), 14, 10, 8);
    }
    [buttonView addSubview:nameLable];
    [buttonView addSubview:_changeImageView];
    buttonView.backgroundColor = [UIColor whiteColor];
    return buttonView;
}


- (void) setStrCity:(NSString *)strCity {
    _strCity = strCity;
    if (_strCity.length > 0) {
        [self.cityButton removeFromSuperview];
        self.cityButton = [self setButtonWithUI:CGRectMake(0, 25, SCREEN_WIDTH / 3, 40) name:_strCity image:@"screen－arrow－down" tag:3 titleColor:Color(154, 154, 154, 1)];
        [self addSubview:self.cityButton];
    }
}

- (void) setFollowStr:(NSString *)followStr {
    _followStr = followStr;
    if ([_followStr isEqualToString:@"全部区域"]) {
        self.followButton = [self setButtonWithUI:CGRectMake(0 , 67, SCREEN_WIDTH / 3, 36) name:_followStr image:@"screen－arrow－down" tag:0 titleColor:Color(154, 154, 154, 1)];
    }else {
        self.followButton = [self setButtonWithUI:CGRectMake(0 , 67, SCREEN_WIDTH / 3, 36) name:_followStr image:@"screen－arrow－up" tag:0 titleColor:[UIColor redColor]];
    }
    [self addSubview:self.followButton];
}

- (void) setTimeStr:(NSString *)timeStr {
    _timeStr = timeStr;
    if ([_timeStr isEqualToString:@"智能排序"]) {
        self.timeButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3  , 67, SCREEN_WIDTH / 3, 36) name:_timeStr image:@"screen－arrow－down" tag:1 titleColor:Color(154, 154, 154, 1)];
    }else {
        self.timeButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3  , 67, SCREEN_WIDTH / 3, 36) name:_timeStr image:@"screen－arrow－up" tag:1 titleColor:[UIColor redColor]];
    }
    [self addSubview:self.timeButton];
}

- (void) setClassificationStr:(NSString *)classificationStr {
    _classificationStr = classificationStr;
    if (_classificationStr.length > 0 ) {
        self.classificationButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3 * 2 , 67, SCREEN_WIDTH / 3, 36)  name:@"筛选" image:@"筛选-select" tag:2 titleColor:[UIColor redColor]];
    }else {
        self.classificationButton = [self setButtonWithUI:CGRectMake(SCREEN_WIDTH / 3 * 2 , 67, SCREEN_WIDTH / 3, 36)  name:@"筛选" image:@"Shape" tag:2 titleColor:Color(154, 154, 154, 1)];
    }
    
    [self addSubview:self.classificationButton];
}

@end
