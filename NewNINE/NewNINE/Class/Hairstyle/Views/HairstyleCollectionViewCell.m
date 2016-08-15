//
//  HairstyleCollectionViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/2.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  发型-----------> 发型控制器cell

#import "HairstyleCollectionViewCell.h"

#import "HairstyleViewControllerModel.h"

@interface HairstyleCollectionViewCell ()

/** 发型师图片*/
@property (nonatomic, strong) UIImageView   *imageHairstyleCell;
/** 发型师背景*/
@property (nonatomic, strong) UIView        *titleView;
/** 发型师介绍*/
@property (nonatomic, strong) UILabel       *lable;

@end

@implementation HairstyleCollectionViewCell


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
    [self.contentView addSubview:self.titleView];
    [self.titleView addSubview:self.imageHairstyleCell];
    [self.titleView addSubview:self.lable];
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
    [self.titleView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.imageHairstyleCell autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 46, 0)];
    
    [self.lable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 12, 6, 12) excludingEdge:ALEdgeTop];
    [self.lable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageHairstyleCell withOffset:0];
}

- (UIImageView *) imageHairstyleCell{
    if (!_imageHairstyleCell) {
        _imageHairstyleCell = [[UIImageView alloc] initForAutoLayout];
        _imageHairstyleCell.userInteractionEnabled = YES;

    }
    return _imageHairstyleCell;
}

- (UIView *) titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] initForAutoLayout];
        _titleView.backgroundColor = [UIColor whiteColor];

    }
    return _titleView;
}


- (UILabel *) lable{
    if (!_lable) {
        _lable = [[UILabel alloc] initForAutoLayout];
        _lable.font = SWP_SYSTEM_FONT_SIZE(14);
        _lable.numberOfLines = 2;
    }
    return _lable;
}

- (void) setDataModel:(HairstyleViewControllerModel *)dataModel {
    _dataModel = dataModel;
    
    _lable.text = dataModel.hairstyleInfoDescription;

    [self.imageHairstyleCell  sd_setImageWithURL:[NSURL URLWithString:_dataModel.hairstyleHairPhotoUrl]
                           placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  }];
}

@end
