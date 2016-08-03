//
//  ChooseTimeCollectionViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/30.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ChooseTimeCollectionViewCell.h"

#import "ChooseTimeModel.h"

@interface ChooseTimeCollectionViewCell ()

/** 时间视图*/
@property (nonatomic, strong) UIButton *timeButton;
/** 时间视图文字*/
@property (nonatomic, strong) UILabel  *timeLable;

@end

@implementation ChooseTimeCollectionViewCell



/**
 *  重写初始化 方法 添加 控件
 *
 *  @param  frame
 *
 *  @return HomeCollectionViewCell
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

/**
 *  重写 layoutSubviews 方法 设置 控件位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [self settingUIAutoLayout];
}

/**
 *  添加 控件
 */
- (void) addUI {
    [self.contentView addSubview:self.timeButton];
    [self.timeButton  addSubview:self.timeLable];
}

/**
 *  设置数据
 */
- (void) settingData {
    
}

/**
 *  设置控件的自动布局
 */
- (void) settingUIAutoLayout {
    [self.timeButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(15, 15, 0, 0)];
    [self.timeLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}


- (UIButton *) timeButton {
    if (!_timeButton) {
        _timeButton = [[UIButton alloc] initForAutoLayout];
        _timeButton.layer.borderWidth = 1;
        _timeButton.backgroundColor   = [UIColor whiteColor];
        [_timeButton.layer setCornerRadius:((SCREEN_HEIGHT - 15) / 4 - 15) / 4];
        [_timeButton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}

- (UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable               = [[UILabel alloc] initForAutoLayout];
        _timeLable.numberOfLines = 2;
        _timeLable.font          = SWP_SYSTEM_FONT_SIZE(15);
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.text          = @"17:00\n可预约";
    }
    return _timeLable;
}


- (void)didView:(UIButton *)btn {

    if ([self.delegate respondsToSelector:@selector(chooseTimeCollectionViewCell:didSelectItemAtIndexPath:)]) {
        [self.delegate chooseTimeCollectionViewCell:self didSelectItemAtIndexPath:self.indexPath];
    }
}

- (void) setTimeModel:(ChooseTimeModel *)timeModel {
    _timeModel = timeModel;
    if (_timeModel.chooseAppointStatus.intValue == 1) {
        self.timeButton.userInteractionEnabled  = YES;
        self.timeButton.layer.borderColor       = [UIColor redColor].CGColor;
        self.timeLable.textColor                = [UIColor redColor];
        self.timeLable.text                     = [NSString stringWithFormat:@"%@\n可预约", _timeModel.chooseAppointTimes];
    }else {
        self.timeButton.userInteractionEnabled  = NO;
        self.timeButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;
        self.timeLable.textColor                = [UIColor lightGrayColor];
        self.timeLable.text                     = [NSString stringWithFormat:@"%@\n已预约", _timeModel.chooseAppointTimes];
    }
}

- (void) setStatus:(NSString *)status {
    _status = status;
    if (self.timeLable.textColor == [UIColor lightGrayColor]) {
        self.timeButton.layer.borderColor       = [UIColor lightGrayColor].CGColor;
        self.timeLable.textColor                = [UIColor lightGrayColor];
        self.timeButton.backgroundColor         = [UIColor whiteColor];
    }else {
        if (status.intValue == 22) {
            self.timeButton.backgroundColor = [UIColor redColor];
            self.timeLable.textColor = [UIColor whiteColor];
        }else {
            self.timeButton.backgroundColor = [UIColor whiteColor];
            self.timeLable.textColor = [UIColor redColor];
        }
    }
}


@end
