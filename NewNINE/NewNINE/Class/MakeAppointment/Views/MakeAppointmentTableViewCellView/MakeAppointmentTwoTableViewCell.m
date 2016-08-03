//
//  MakeAppointmentTwoTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/21.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MakeAppointmentTwoTableViewCell.h"

@interface MakeAppointmentTwoTableViewCell ()


#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/** 左侧分类标题*/
@property (nonatomic, strong) UILabel       * titleLable;
/** 右侧选择内容*/
@property (nonatomic, strong) UILabel       * nameLable;
/** 立减控件*/
@property (nonatomic, strong) UIButton      * minusButton;
/** 点击箭头*/
@property (nonatomic, strong) UIImageView   * arrowImageView;

/** cell背景*/
@property (nonatomic, strong) UIButton      * backBttton;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation MakeAppointmentTwoTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MakeAppointmentTwoTableViewCell
 */
+ (instancetype) makeAppointmentTwoCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    MakeAppointmentTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    cell.backgroundColor    = [UIColor whiteColor];
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return MakeAppointmentTwoTableViewCell
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
    [self.contentView addSubview:self.backBttton];
    [self.backBttton addSubview:self.titleLable];
    [self.backBttton addSubview:self.nameLable];
    [self.backBttton addSubview:self.minusButton];
    [self.backBttton addSubview:self.arrowImageView];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.backBttton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 15, 12, 0) excludingEdge:ALEdgeRight];
    [self.titleLable autoSetDimension:ALDimensionWidth toSize:35];
    
    [self.arrowImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(15, 0, 15, 15) excludingEdge:ALEdgeLeft];
    [self.arrowImageView autoSetDimension:ALDimensionWidth toSize:15];
    
    [self.minusButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 60, 12, 0) excludingEdge:ALEdgeRight];
    [self.minusButton autoSetDimension:ALDimensionWidth toSize:110];
    
    [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 0, 12, 30) excludingEdge:ALEdgeLeft];
    [self.nameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.minusButton withOffset:5];
}


- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.font      = SWP_SYSTEM_FONT_SIZE(16);
        _titleLable.textColor = Color(64, 64, 64, 1);
    }
    return _titleLable;
}

- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initForAutoLayout];
        _nameLable.font             = SWP_SYSTEM_FONT_SIZE(15);
        _nameLable.text             = @"请选择";
        _nameLable.textAlignment    = NSTextAlignmentRight;
        _nameLable.textColor        = Color(154, 154, 154, 1);
        _nameLable.adjustsFontSizeToFitWidth = YES;//UIlable自动 改变字体(字体收缩)
    }
    return _nameLable;
}

- (UIButton *) minusButton {
    if (!_minusButton) {
        _minusButton = [[UIButton alloc] initForAutoLayout];
        [_minusButton setImage:[UIImage imageNamed:@"立减icon"] forState:UIControlStateNormal];
        [_minusButton setTitle:@"￥9000" forState:UIControlStateNormal];
        _minusButton.titleLabel.font = SWP_SYSTEM_FONT_SIZE(13);
        [_minusButton setTitleColor:Color(154, 154, 154, 1) forState:UIControlStateNormal];
        _minusButton.imageEdgeInsets = UIEdgeInsetsMake(0, -_minusButton.titleLabel.frame.size.width - _minusButton.frame.size.width + _minusButton.imageView.frame.size.width, 0, 0);
        [_minusButton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
        
        _minusButton.hidden = YES;
    }
    return _minusButton;
}

- (UIImageView *) arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initForAutoLayout];
        _arrowImageView.image = [UIImage imageNamed:@"进入箭头"];
    }
    return _arrowImageView;
}

- (UIButton *)backBttton {
    if (!_backBttton) {
        _backBttton = [[UIButton alloc] initForAutoLayout];
        [_backBttton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBttton;
}


- (void)didView:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(MakeAppointmentTwoTableViewCell:didSelectRowAtIndexPath:)]) {
        [self.delegate MakeAppointmentTwoTableViewCell:self didSelectRowAtIndexPath:self.indexPath];
    }
}

- (void) setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = _title;
}

- (void)setProductType:(NSString *)productType {
    _productType = productType;
    self.nameLable.text = _productType;
}


- (void) setDict:(NSDictionary *)dict {
    _dict = dict;
    if ([[dict objectForKey:@"cutvalues"] intValue] > 0) {
        self.minusButton.hidden = NO;
        [self.minusButton setTitle:[NSString stringWithFormat:@"立减%@元", [dict objectForKey:@"cutvalues"]] forState:UIControlStateNormal];
    }else {
        self.minusButton.hidden = YES;
    }
}

@end
