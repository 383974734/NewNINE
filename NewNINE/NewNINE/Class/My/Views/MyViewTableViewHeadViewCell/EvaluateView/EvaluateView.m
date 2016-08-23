//
//  EvaluateView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/22.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "EvaluateView.h"

@interface EvaluateView ()<UITextViewDelegate>{
    NSInteger tagInteger;//用来记录选择满意度
}
/** 设计师头像*/
@property (nonatomic, strong) UIImageView   *designerImageView;
/** 设计师名称*/
@property (nonatomic, strong) UILabel       *designerNameLable;
/** 描述我对他（她）的评价*/
@property (nonatomic, strong) UILabel       *lable;
/** 描述我对他（她）的评价*/
@property (nonatomic, strong) UIView        *backBtnView;
/** 非常满意*/
@property (nonatomic, strong) UIButton      *verySatisfiedBtn;
/** 满意*/
@property (nonatomic, strong) UIButton      *satisfiedBtn;
/** 一般*/
@property (nonatomic, strong) UIButton      *commonlyBtn;
/** 评价*/
@property (nonatomic, strong) UITextView    *evaluateTextView;
/** 评价占位符*/
@property (nonatomic, strong) UILabel       *evaluateTextViewPlaceholder;

@end

@implementation EvaluateView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        tagInteger = 1;
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.designerImageView];
    [self addSubview:self.designerNameLable];
    [self addSubview:self.lable];
    [self addSubview:self.backBtnView];
    [self addSubview:self.evaluateTextView];
    [self addSubview:self.evaluateTextViewPlaceholder];
    
    [self.backBtnView addSubview:self.verySatisfiedBtn];
    [self.backBtnView addSubview:self.satisfiedBtn];
    [self.backBtnView addSubview:self.commonlyBtn];
    
}

- (void)settingAutoLayout {
    [self.designerImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
    [self.designerImageView autoSetDimension:ALDimensionWidth toSize:56];
    [self.designerImageView autoSetDimension:ALDimensionHeight toSize:56];
    [self.designerImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:SCREEN_WIDTH / 2 - 28];
    
    [self.designerNameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.designerImageView withOffset:10];
    [self.designerNameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.designerNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.designerNameLable autoSetDimension:ALDimensionHeight toSize:24];
    
    [self.lable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.designerNameLable withOffset:10];
    [self.lable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.lable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    [self.lable autoSetDimension:ALDimensionHeight toSize:18];
    
    [self.backBtnView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.lable withOffset:20];
    [self.backBtnView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.backBtnView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    [self.backBtnView autoSetDimension:ALDimensionHeight toSize:28];
    
    [self.verySatisfiedBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
    [self.verySatisfiedBtn autoSetDimension:ALDimensionWidth toSize:(SCREEN_WIDTH - 80) / 3];
    
    [self.satisfiedBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.verySatisfiedBtn withOffset:0];
    [self.satisfiedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.satisfiedBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [self.satisfiedBtn autoSetDimension:ALDimensionWidth toSize:(SCREEN_WIDTH - 80) / 3];
    
    [self.commonlyBtn autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeLeft];
    [self.commonlyBtn autoSetDimension:ALDimensionWidth toSize:(SCREEN_WIDTH - 80) / 3];
    
    [self.evaluateTextView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backBtnView withOffset:20];
    [self.evaluateTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [self.evaluateTextView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [self.evaluateTextView autoSetDimension:ALDimensionHeight toSize:150];
    
    [self.evaluateTextViewPlaceholder autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.backBtnView withOffset:20];
    [self.evaluateTextViewPlaceholder autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.evaluateTextViewPlaceholder autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    [self.evaluateTextViewPlaceholder autoSetDimension:ALDimensionHeight toSize:30];
}
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.evaluateTextViewPlaceholder.hidden = YES;
    return YES;
}
//将要结束编辑
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return YES;
}
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView {

}
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.EvaluateViewContent) {
        self.EvaluateViewContent(textView.text, tagInteger);
    }
}
//内容将要发生改变编辑
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}
//内容发生改变编辑
- (void)textViewDidChange:(UITextView *)textView {

}
//焦点发生改变
- (void)textViewDidChangeSelection:(UITextView *)textView {

}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    return YES;
}


- (UIImageView *)designerImageView {
    if (!_designerImageView) {
        _designerImageView = [[UIImageView alloc] initForAutoLayout];
        _designerImageView.layer.cornerRadius   = 28;
        _designerImageView.layer.masksToBounds  = YES;
        
    }
    return _designerImageView;
}

- (UILabel *)designerNameLable {
    if (!_designerNameLable) {
        _designerNameLable = [[UILabel alloc] initForAutoLayout];
        _designerNameLable.textAlignment = NSTextAlignmentCenter;
    }
    return _designerNameLable;
}

- (UILabel *)lable {
    if (!_lable) {
        _lable = [[UILabel alloc] initForAutoLayout];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.text          = @"描述我对他（她）的评价";
        _lable.textColor     = [UIColor lightGrayColor];
    }
    return _lable;
}

- (UIView *)backBtnView {
    if (!_backBtnView) {
        _backBtnView = [[UIButton alloc] initForAutoLayout];
        _backBtnView.layer.borderWidth  = 0.2;
        _backBtnView.layer.borderColor  = [UIColor lightGrayColor].CGColor;
        _backBtnView.layer.cornerRadius = 15;
    }
    return _backBtnView;
}

- (UIButton *)verySatisfiedBtn {
    if (!_verySatisfiedBtn) {
        _verySatisfiedBtn = [[UIButton alloc] initForAutoLayout];
        _verySatisfiedBtn.backgroundColor    = [UIColor redColor];
        _verySatisfiedBtn.layer.cornerRadius = 15;
        _verySatisfiedBtn.titleLabel.font    = SWP_SYSTEM_FONT_SIZE(14);
        _verySatisfiedBtn.tag                = 1;
        
        [_verySatisfiedBtn setImage:[UIImage imageNamed:@"非常满意selected"] forState:UIControlStateNormal];
        [_verySatisfiedBtn setTitle:@"非常满意" forState:UIControlStateNormal];
        [_verySatisfiedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_verySatisfiedBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verySatisfiedBtn;
}

- (UIButton *)satisfiedBtn {
    if (!_satisfiedBtn) {
        _satisfiedBtn = [[UIButton alloc] initForAutoLayout];
        _satisfiedBtn.titleLabel.font    = SWP_SYSTEM_FONT_SIZE(14);
        _satisfiedBtn.tag                = 2;
        _satisfiedBtn.layer.cornerRadius = 15;
        
        [_satisfiedBtn setImage:[UIImage imageNamed:@"满意default"] forState:UIControlStateNormal];
        [_satisfiedBtn setTitle:@"满意" forState:UIControlStateNormal];
        [_satisfiedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_satisfiedBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _satisfiedBtn;
}

- (UIButton *)commonlyBtn {
    if (!_commonlyBtn) {
        _commonlyBtn = [[UIButton alloc] initForAutoLayout];
        _commonlyBtn.titleLabel.font    = SWP_SYSTEM_FONT_SIZE(14);
        _commonlyBtn.tag                = 3;
        _commonlyBtn.layer.cornerRadius = 15;
        
        [_commonlyBtn setImage:[UIImage imageNamed:@"一般default"] forState:UIControlStateNormal];
        [_commonlyBtn setTitle:@"一般" forState:UIControlStateNormal];
        [_commonlyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_commonlyBtn addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commonlyBtn;
}

- (UITextView *)evaluateTextView {
    if (!_evaluateTextView) {
        _evaluateTextView = [[UITextView alloc] initForAutoLayout];
        _evaluateTextView.delegate = self;
    }
    return _evaluateTextView;
}

-(UILabel *)evaluateTextViewPlaceholder {
    if (!_evaluateTextViewPlaceholder) {
        _evaluateTextViewPlaceholder = [[UILabel alloc] initForAutoLayout];
        _evaluateTextViewPlaceholder.text      = @"对这次消费满意么？为小伙伴分享一下吧！";
        _evaluateTextViewPlaceholder.textColor = [UIColor lightGrayColor];
        _evaluateTextViewPlaceholder.font      = SWP_SYSTEM_FONT_SIZE(13);
    }
    return _evaluateTextViewPlaceholder;
}

- (void)didButton:(UIButton *)btn {
    [self buttonWithState:btn.tag];
}

- (void) buttonWithState:(NSInteger)tag{
    if (tag == 1) {
        _verySatisfiedBtn.backgroundColor = [UIColor redColor];
        [_verySatisfiedBtn setImage:[UIImage imageNamed:@"非常满意selected"] forState:UIControlStateNormal];
        [_verySatisfiedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _satisfiedBtn.backgroundColor     = [UIColor clearColor];
        [_satisfiedBtn setImage:[UIImage imageNamed:@"满意default"] forState:UIControlStateNormal];
        [_satisfiedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _commonlyBtn.backgroundColor      = [UIColor clearColor];
        [_commonlyBtn setImage:[UIImage imageNamed:@"一般default"] forState:UIControlStateNormal];
        [_commonlyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

    }
    if (tag == 2) {
        _verySatisfiedBtn.backgroundColor = [UIColor clearColor];
        [_verySatisfiedBtn setImage:[UIImage imageNamed:@"非常满意default"] forState:UIControlStateNormal];
        [_verySatisfiedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _satisfiedBtn.backgroundColor     = [UIColor redColor];
        [_satisfiedBtn setImage:[UIImage imageNamed:@"满意selected"] forState:UIControlStateNormal];
        [_satisfiedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _commonlyBtn.backgroundColor      = [UIColor clearColor];
        [_commonlyBtn setImage:[UIImage imageNamed:@"一般default"] forState:UIControlStateNormal];
        [_commonlyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    if (tag == 3) {
        _verySatisfiedBtn.backgroundColor = [UIColor clearColor];
        [_verySatisfiedBtn setImage:[UIImage imageNamed:@"非常满意default"] forState:UIControlStateNormal];
        [_verySatisfiedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _satisfiedBtn.backgroundColor     = [UIColor clearColor];
        [_satisfiedBtn setImage:[UIImage imageNamed:@"满意default"] forState:UIControlStateNormal];
        [_satisfiedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _commonlyBtn.backgroundColor      = [UIColor redColor];
        [_commonlyBtn setImage:[UIImage imageNamed:@"一般selected"] forState:UIControlStateNormal];
        [_commonlyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    tagInteger = tag;
    if (self.EvaluateViewContent) {
        self.EvaluateViewContent(self.evaluateTextView.text, tagInteger);
    }
}

- (void) setNameStr:(NSString *)nameStr {
    _nameStr = nameStr;
    self.designerNameLable.text = _nameStr;
}

- (void) setIconPhotoUrl:(NSString *)iconPhotoUrl {
    _iconPhotoUrl = iconPhotoUrl;
    [self.designerImageView sd_setImageWithURL:[NSURL URLWithString:self.iconPhotoUrl] placeholderImage:[UIImage imageNamed:@"logo144"]];
}

@end
