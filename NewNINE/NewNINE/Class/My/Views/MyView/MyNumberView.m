//
//  MyNumberView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器 ---收藏 --积分 --优惠卷

#import "MyNumberView.h"

@interface MyNumberView ()

@property (nonatomic, strong) UIButton      *backgroundButton;

/** 图标*/
@property (nonatomic, strong) UIImageView   *myImageView;
/** 左线*/
@property (nonatomic, strong) UIImageView   *lImageView;
/** 右线*/
@property (nonatomic, strong) UIImageView   *rImageView;
/** 名称*/
@property (nonatomic, strong) UILabel       *myNameLable;
/** 数量*/
@property (nonatomic, strong) UILabel       *myNumberLable;

@end

@implementation MyNumberView



- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.backgroundButton];
    [self.backgroundButton addSubview:self.myImageView];
    [self.backgroundButton addSubview:self.lImageView];
    [self.backgroundButton addSubview:self.rImageView];
    [self.backgroundButton addSubview:self.myNameLable];
    [self.backgroundButton addSubview:self.myNumberLable];

}

- (void)settingAutoLayout {
    [self.backgroundButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.lImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [self.lImageView autoSetDimension:ALDimensionWidth toSize:2];
    
    [self.rImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeLeft];
    [self.rImageView autoSetDimension:ALDimensionWidth toSize:2];
    
    [self.myNumberLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.myNumberLable autoSetDimension:ALDimensionHeight toSize:21];
}

- (void)settingData {
    
}

- (UIButton *) backgroundButton {
    if (!_backgroundButton) {
        _backgroundButton = [[UIButton alloc] initForAutoLayout];
        [_backgroundButton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundButton;
}

- (UIImageView *) myImageView{
    if (!_myImageView) {
        _myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 6  - 25, 3, 15, 15)];
    }
    return _myImageView;
}

- (UIImageView *) rImageView{
    if (!_rImageView) {
        _rImageView = [[UIImageView alloc] initForAutoLayout];
        _rImageView.image = [UIImage imageNamed:@"虚线"];
    }
    return _rImageView;
}

- (UIImageView *) lImageView{
    if (!_lImageView) {
        _lImageView = [[UIImageView alloc] initForAutoLayout];
        _lImageView.image = [UIImage imageNamed:@"虚线"];
    }
    return _lImageView;
}

- (UILabel *) myNameLable{
    if (!_myNameLable) {
        _myNameLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 6 - 8, 0, SCREEN_WIDTH / 6, 18)];
        _myNameLable.textColor = [UIColor whiteColor];
        _myNameLable.font = SWP_SYSTEM_FONT_SIZE(13);
    }
    return _myNameLable;
}

- (UILabel *) myNumberLable{
    if (!_myNumberLable) {
        _myNumberLable = [[UILabel alloc] initForAutoLayout];
        _myNumberLable.textAlignment = NSTextAlignmentCenter;
        _myNumberLable.textColor = [UIColor whiteColor];
    }
    return _myNumberLable;
}


- (void) setImageView:(NSString *)image nameText:(NSString *)name numberText:(NSString *)number imageLandRWithHidden:(BOOL)hidden tag:(NSInteger)tag{
    self.myImageView.image    = [UIImage imageNamed:image];
    self.myNameLable.text     = name;
    self.myNumberLable.text   = number;
    self.lImageView.hidden    = hidden;
    self.rImageView.hidden    = hidden;
    self.backgroundButton.tag = tag;
}


- (void) setWithNumber:(NSString *)number {
    self.myNumberLable.text   = number;
}

- (void)didView:(UIButton *)btn {
    NSLog(@"我的控制器 ---收藏 --积分 --优惠卷");
    if ([self.delegate respondsToSelector:@selector(myNumberView:buttonWithTag:name:)]) {
        [self.delegate myNumberView:self buttonWithTag:self.backgroundButton.tag name:@"1"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
