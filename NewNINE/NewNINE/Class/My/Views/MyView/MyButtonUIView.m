//
//  MyButtonUIView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器 ---未付款 --预约成功 --已完成 --退款  按钮

#import "MyButtonUIView.h"


@interface MyButtonUIView ()

@property (nonatomic, strong) UIButton      *button;
@property (nonatomic, strong) UIImageView   *buttonImageView;
@property (nonatomic, strong) UILabel       *buttonLabel;

@end

@implementation MyButtonUIView


- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.button];
    [self.button addSubview:self.buttonImageView];
    [self.button addSubview:self.buttonLabel];
}

- (void)settingAutoLayout {
    [self.button autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)settingData {
    
}
- (UIButton *) button {
    if (!_button) {
        _button = [[UIButton alloc] initForAutoLayout];
        [_button addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
    
}

- (UIImageView *) buttonImageView {
    if (!_buttonImageView) {
        _buttonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 8 - 12, 8, 24, 24)];
    }
    return _buttonImageView;
}

- (UILabel *) buttonLabel {
    if (!_buttonLabel) {
        _buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH / 4, 18)];
        _buttonLabel.textAlignment  = NSTextAlignmentCenter;
        _buttonLabel.font           = SWP_SYSTEM_FONT_SIZE(13);
        _buttonLabel.textColor      = Color(154, 154, 154, 1);
    }
    return _buttonLabel;
}

- (void)didView:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(myButtonUIView:buttonWithTag:name:)]) {
        [self.delegate myButtonUIView:self buttonWithTag:self.button.tag name:@"2"];
    }
}


- (void) setimageView:(NSString *)image lableText:(NSString *)text buttonWithTag:(NSInteger)tag{
    self.buttonImageView.image  = [UIImage imageNamed:image];
    self.buttonLabel.text       = text;
    self.button.tag             = tag;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
