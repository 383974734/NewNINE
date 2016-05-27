//
//  HomeTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  首页 ----> 热门发型视图

#import "HomeTableViewCell.h"
// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "HomeBannerModels.h"
// ---------------------- model      ----------------------

@interface HomeTableViewCell ()
/** 底层图片*/
@property (nonatomic, strong) UIImageView *backgroundImageView;
/** 预约背景图片图片*/
@property (nonatomic, strong) UIImageView *makeAppointmentImageView;
/** 内容文字*/
@property (nonatomic, strong) UILabel *contentLable;
/** 预约按钮*/
@property (nonatomic, strong) UIButton *makeAppointmentButton;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return HomeTableViewCell
 */
+ (instancetype) homeCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    cell.backgroundColor    = SWPColor(248, 248, 248, 1);
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return HomeTableViewCell
 */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}


/**
 *  添加cell上的控件
 */
- (void) addUI {
    [self.contentView addSubview:self.backgroundImageView];
    [self.backgroundImageView addSubview:self.makeAppointmentImageView];
    [self.makeAppointmentImageView addSubview:self.contentLable];
    [self.makeAppointmentImageView addSubview:self.makeAppointmentButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(15, 15, 0, 15)];
    
    [self.makeAppointmentImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.makeAppointmentImageView autoSetDimension:ALDimensionHeight toSize:57];
    
    [self.contentLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 70, 0, 0)];
    
    [self.makeAppointmentButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeRight];
    [self.makeAppointmentButton autoSetDimension:ALDimensionWidth toSize:70];
}


- (UIImageView *) backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initForAutoLayout];
        _backgroundImageView.userInteractionEnabled = YES;
    }
    return _backgroundImageView;
}

- (UIImageView *) makeAppointmentImageView {
    if (!_makeAppointmentImageView) {
        _makeAppointmentImageView = [[UIImageView alloc] initForAutoLayout];
        _makeAppointmentImageView.userInteractionEnabled = YES;
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 80, 0, 0);
        UIImage *image = [UIImage imageNamed:@"首页预约"];
        _makeAppointmentImageView.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    }
    return _makeAppointmentImageView;
}

- (UILabel *) contentLable {
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] initForAutoLayout];
        _contentLable.textColor = [UIColor whiteColor];
        _contentLable.font = SWP_SYSTEM_FONT_SIZE(14);
    }
    return _contentLable;
}

- (UIButton *) makeAppointmentButton {
    if (!_makeAppointmentButton) {
        _makeAppointmentButton = [[UIButton alloc] initForAutoLayout];
        [_makeAppointmentButton addTarget:self action:@selector(didButtonView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _makeAppointmentButton;
}

- (void) didButtonView:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(HomeTableViewCell:buttonIndex:)]) {
        [self.delegate HomeTableViewCell:self buttonIndex:self.indexPath];
    }
}

- (void) setCellModel:(HomeBannerModels *)cellModel {
    _cellModel = cellModel;
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:_cellModel.homeHairPhotoUrl] placeholderImage:[UIImage imageNamed:@"banner缺省图"]];
    self.contentLable.text = _cellModel.homeInfoDescription;

}

@end
