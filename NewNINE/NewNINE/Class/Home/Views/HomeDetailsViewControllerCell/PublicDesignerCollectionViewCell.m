//
//  PublicDesignerCollectionViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/1.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页-----------> 首页发型详情公共设计师显示列表控制器cell


#import "PublicDesignerCollectionViewCell.h"

@interface PublicDesignerCollectionViewCell ()
/** 设计师图片*/
@property (nonatomic, strong) UIImageView   *imageViewPD;
/** 设计师介绍背景*/
@property (nonatomic, strong) UIView        *viewBackground;
/** 预约按钮*/
@property (nonatomic, strong) UIButton      *appointmentButton;

/** 设计师名字*/
@property (nonatomic, strong) UILabel       *nameLable;
/** 级别*/
@property (nonatomic, strong) UILabel       *levelLable;
/** 美单*/
@property (nonatomic, strong) UILabel       *singleLable;
/** 洗剪吹文字*/
@property (nonatomic, strong) UILabel       *titleLable;
/** 价钱*/
@property (nonatomic, strong) UILabel       *priceLable;

@end

@implementation PublicDesignerCollectionViewCell


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
    [self.contentView addSubview:self.imageViewPD];
    [self.imageViewPD addSubview:self.viewBackground];
    [self.contentView addSubview:self.appointmentButton];
    [self.viewBackground addSubview:self.nameLable];
    [self.viewBackground addSubview:self.levelLable];
    [self.viewBackground addSubview:self.singleLable];
    [self.viewBackground addSubview:self.titleLable];
    [self.viewBackground addSubview:self.priceLable];
    
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
    [self.imageViewPD autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 46, 0)];
    
    [self.viewBackground autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.viewBackground autoSetDimension:ALDimensionHeight toSize:44];
    
    [self.appointmentButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.appointmentButton autoSetDimension:ALDimensionHeight toSize:46];
}

- (UIImageView *) imageViewPD {
    if (!_imageViewPD) {
        _imageViewPD = [[UIImageView alloc] initForAutoLayout];
        _imageViewPD.userInteractionEnabled = YES;
    }
    return _imageViewPD;
}

- (UIView *) viewBackground {
    if (!_viewBackground) {
        _viewBackground = [[UIView alloc] initForAutoLayout];
        _viewBackground.backgroundColor = [UIColor blackColor];
        _viewBackground.alpha = 0.5;
    }
    return _viewBackground;
}

- (UIButton *) appointmentButton {
    if (!_appointmentButton) {
        _appointmentButton = [[UIButton alloc] initForAutoLayout];
        _appointmentButton.backgroundColor = [UIColor whiteColor];
        [_appointmentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_appointmentButton setTitle:@"预约" forState:UIControlStateNormal];
        [_appointmentButton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _appointmentButton;
}

- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.textColor = [UIColor whiteColor];
        _nameLable.font      = SWP_SYSTEM_FONT_SIZE(13);
        _nameLable.lineBreakMode = UILineBreakModeWordWrap;
    }
    return _nameLable;
}

- (UILabel *) levelLable {
    if (!_levelLable) {
        _levelLable = [[UILabel alloc] init];
        _levelLable.layer.borderWidth   = 1;
        _levelLable.layer.cornerRadius  = 2;
        _levelLable.font                = SWP_SYSTEM_FONT_SIZE(10);
        _levelLable.layer.borderColor   = Color(234, 41, 41, 1).CGColor;
        _levelLable.textColor           = Color(234, 41, 41, 1);
        _levelLable.textAlignment       = NSTextAlignmentCenter;
    }
    return _levelLable;
}

- (UILabel *) singleLable {
    if (!_singleLable) {
        _singleLable = [[UILabel alloc] init];
        _singleLable.textColor  = [UIColor whiteColor];
        _singleLable.font       = SWP_SYSTEM_FONT_SIZE(11);
    }
    return _singleLable;
}

- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font      = SWP_SYSTEM_FONT_SIZE(11);
        _titleLable.text      = @"洗剪吹";
    }
    return _titleLable;
}

- (UILabel *) priceLable {
    if (!_priceLable) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.textColor = [UIColor redColor];
        _priceLable.font      = SWP_SYSTEM_FONT_SIZE(11);
    }
    return _priceLable;
}

- (void) didView:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(publicDesignerCollectionViewCell:didSelectItemAtIndexPath:)]) {
        [self.delegate publicDesignerCollectionViewCell:self didSelectItemAtIndexPath:self.indexPath];
    }
}

- (void) setDictData:(NSDictionary *)dictData {
    _dictData = dictData;
    
    [self.imageViewPD sd_setImageWithURL:[NSURL URLWithString:[_dictData objectForKey:@"iconPhotoUrl"]] placeholderImage:[UIImage imageNamed:@"发型缺省图"]];
    
    self.nameLable.text = [_dictData objectForKey:@"name"];
    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
    CGSize size = CGSizeMake(320,20);
    CGSize nameSize = [self.nameLable.text sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.nameLable.frame = CGRectMake(5, 5, nameSize.width + 10, 20);
    
    self.levelLable.text = [_dictData objectForKey:@"leveName"];
    UIFont *levelFnt = [UIFont fontWithName:[_dictData objectForKey:@"leveName"] size:10];
    CGSize levelSize = [self.levelLable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:levelFnt, NSFontAttributeName, nil]];
    self.levelLable.frame = CGRectMake(7 + nameSize.width, 7, levelSize.width, 16);

    UIFont *tempFnt = [UIFont fontWithName:@"Arial" size:13];
    CGSize tempSize = CGSizeMake(320,14);

    self.singleLable.text = [NSString stringWithFormat:@"%@美单", [_dictData objectForKey:@"bought"]];
    CGSize atempSize = [self.singleLable.text sizeWithFont:tempFnt constrainedToSize:tempSize lineBreakMode:UILineBreakModeWordWrap];
    self.singleLable.frame = CGRectMake(5, 26, atempSize.width + 5, 14);

    
    self.titleLable.frame = CGRectMake(self.singleLable.frame.origin.x + atempSize.width + 5, 26, 40, 14);
    
    self.priceLable.text = [NSString stringWithFormat:@"￥%@", [_dictData objectForKey:@"priceMast"]];
    atempSize = [self.priceLable.text sizeWithFont:tempFnt constrainedToSize:tempSize lineBreakMode:UILineBreakModeWordWrap];
    self.priceLable.frame = CGRectMake(self.titleLable.frame.origin.x + 32, 26, atempSize.width + 5, 14);
   
    
}



@end
