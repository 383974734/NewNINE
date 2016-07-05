//
//  AlertViewView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/20.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "AlertViewView.h"
#import "UIViewController+LewPopupViewController.h"     // 弹出视图框架
#import "LewPopupViewAnimationFade.h"                   // 弹出视图框架
#import "LewPopupViewAnimationSlide.h"                  // 弹出视图框架
#import "LewPopupViewAnimationSpring.h"                 // 弹出视图框架
#import "LewPopupViewAnimationDrop.h"                   // 弹出视图框架


@interface AlertViewView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *lableTitle;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *xxLable;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UITextView *textView;


@end

@implementation AlertViewView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.backView];
    [self.backView addSubview:self.imageView];
    [self.backView addSubview:self.lableTitle];
    
    [self.backView addSubview:self.textView];
    [self.backView addSubview:self.nameLable];
    [self.backView addSubview:self.xxLable];
    [self.backView addSubview:self.leftButton];
    [self.backView addSubview:self.rightButton];
    
    
}

- (void)settingAutoLayout {

}

- (void)settingData {
    
}

+ (instancetype) popupView {
    return [[AlertViewView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
}

- (UIView *) backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];//initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 140, SCREEN_HEIGHT / 2 - 155, 280, 310)];
        _backView.layer.cornerRadius    = 8;
        _backView.layer.masksToBounds   = YES;
        _backView.backgroundColor       = [UIColor whiteColor];
    }
    return _backView;
}

- (UIImageView *) imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(104, 34, 70, 70)];
        _imageView.image = [UIImage imageNamed:@"弹出icon"];
    }
    return _imageView;
}

- (UILabel *)lableTitle {
    if (!_lableTitle) {
        _lableTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 280, 30)];
        _lableTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _lableTitle;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 260, 30)];
        _nameLable.textAlignment = NSTextAlignmentCenter;
        _nameLable.textColor = [UIColor lightGrayColor];
    }
    return _nameLable;
}

- (UILabel *)xxLable {
    if (!_xxLable) {
        _xxLable = [[UILabel alloc] init];
        _xxLable.backgroundColor = Color(238, 238, 238, 1);
    }
    return _xxLable;
}

- (UIButton *) leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.tag = 0;
        [_leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *) rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.tag = 1;
        [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UITextView *) textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 140, 260, 85)];
        _textView.hidden = YES;
        _textView.delegate = self;
        _textView.layer.borderWidth = 0.1;
        _textView.layer.cornerRadius = 5;
    }
    return _textView;
}

-(void)textViewDidChange:(UITextView *)textView {
    self.nameLable.hidden    = YES;
}

- (void)didButton:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(alertViewView:buttonWithTag:textViewStr:indexPath:)]) {
        [self.delegate alertViewView:self buttonWithTag:btn.tag textViewStr:self.textView.text indexPath:self.index];
    }
}

- (void) setAlertView:(NSString *)title textfileWithHidden:(BOOL)hidden nameLable:(NSString *)nameLable leftButton:(NSString *)leftButton rightButton:(NSString *)rightButton {
    if (hidden) {
        self.textView.hidden    = YES;
        self.backView.frame     = CGRectMake(SCREEN_WIDTH / 2 - 140, SCREEN_HEIGHT / 2 - 140, 280, 280);
        self.xxLable.frame      = CGRectMake(0, 215, 280, 0.5);
        self.leftButton.frame   = CGRectMake(0, 215, 140, 64);
        self.rightButton.frame  = CGRectMake(140, 215, 140, 64);
    }else {
        self.textView.hidden    = NO;
        self.backView.frame     = CGRectMake(SCREEN_WIDTH / 2 - 140, SCREEN_HEIGHT / 2 - 155, 280, 310);
        self.xxLable.frame      = CGRectMake(0, 246, 280, 0.5);
        self.leftButton.frame   = CGRectMake(0, 246, 140, 64);
        self.rightButton.frame  = CGRectMake(140, 246, 140, 64);
        self.nameLable.textAlignment = NSTextAlignmentLeft;
    }
    self.lableTitle.text = title;
    self.nameLable.text  = nameLable;
    [self.leftButton setTitle:leftButton forState:UIControlStateNormal];
    [self.rightButton setTitle:rightButton forState:UIControlStateNormal];
}

@end
