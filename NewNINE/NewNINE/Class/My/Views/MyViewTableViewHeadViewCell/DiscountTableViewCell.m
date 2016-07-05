//
//  DiscountTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "DiscountTableViewCell.h"

// ---------------------- view       ----------------------

// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
#import "DiscountViewModel.h"
// ---------------------- model      ----------------------


@interface DiscountTableViewCell ()
// ---------------------- UI 控件 ----------------------

@property (nonatomic, strong) UIImageView *backgroundImageView;
/** 票面价值*/
@property (nonatomic, strong) UILabel *couponValuesLable;
/** 描述*/
@property (nonatomic, strong) UILabel *descriptionLable;
/** 结束日期*/
@property (nonatomic, strong) UILabel *endDateLable;
/** 名称*/
@property (nonatomic, strong) UILabel *nameLable;

/** 预约*/
@property (nonatomic, strong) UIButton *appointmentButton;


#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------
@end

@implementation DiscountTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DiscountTableViewCell
 */
+ (instancetype) discountCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    DiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    //    cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;//箭头
    //    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.backgroundColor = SWPColor(248, 248, 248, 1);;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return CollectionTableViewCell
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
    [self.backgroundImageView addSubview:self.endDateLable];
    [self.backgroundImageView addSubview:self.couponValuesLable];
    [self.backgroundImageView addSubview:self.nameLable];
    [self.backgroundImageView addSubview:self.descriptionLable];
    [self.backgroundImageView addSubview:self.appointmentButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.backgroundImageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(20, 20, 0, 20)];
    
    [self.endDateLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 40, 0, 0) excludingEdge:ALEdgeTop];
    [self.endDateLable autoSetDimension:ALDimensionHeight toSize:20];
    
    [self.couponValuesLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 40) excludingEdge:ALEdgeLeft];
    [self.couponValuesLable autoSetDimension:ALDimensionWidth toSize:50];
    
    [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(30, 40, 0, 20) excludingEdge:ALEdgeBottom];
    [self.nameLable autoSetDimension:ALDimensionHeight toSize:15];
    
    [self.descriptionLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLable withOffset:0];
    [self.descriptionLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.endDateLable withOffset:0];
    [self.descriptionLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLable];
    [self.descriptionLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.couponValuesLable withOffset:0];

    [self.appointmentButton autoSetDimension:ALDimensionHeight toSize:20];
    [self.appointmentButton autoSetDimension:ALDimensionWidth toSize:90];
    [self.appointmentButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [self.appointmentButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    
}

- (UIImageView *) backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initForAutoLayout];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 15, 0, 15);
        UIImage *image = [UIImage imageNamed:@"灰色"];
        _backgroundImageView.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
    }
    return _backgroundImageView;
}

- (UILabel *) couponValuesLable {
    if (!_couponValuesLable) {
        _couponValuesLable = [[UILabel alloc] initForAutoLayout];
        _couponValuesLable.font = SWP_SYSTEM_FONT_SIZE(23);
        _couponValuesLable.textColor = Color(208, 208, 208, 1);
        _couponValuesLable.textAlignment = NSTextAlignmentRight;
    }
    return _couponValuesLable;
}

- (UILabel *) descriptionLable {
    if (!_descriptionLable) {
        _descriptionLable = [[UILabel alloc] initForAutoLayout];
        _descriptionLable.font = SWP_SYSTEM_FONT_SIZE(14);
        _descriptionLable.translatesAutoresizingMaskIntoConstraints = YES ;//lable多行置顶
        _descriptionLable.numberOfLines = 0;
        [_descriptionLable sizeToFit];
    }
    return _descriptionLable;
}

- (UILabel *) endDateLable {
    if (!_endDateLable) {
        _endDateLable = [[UILabel alloc] initForAutoLayout];
        _endDateLable.font = SWP_SYSTEM_FONT_SIZE(14);
        _endDateLable.textColor = [UIColor whiteColor];
    }
    return _endDateLable;
}

- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initForAutoLayout];
        _nameLable.font = SWP_SYSTEM_FONT_SIZE(16);
    }
    return _nameLable;
}


- (UIButton *) appointmentButton {
    if (!_appointmentButton) {
        _appointmentButton = [[UIButton alloc] initForAutoLayout];
        [_appointmentButton setImage:[UIImage imageNamed:@"预约"] forState:UIControlStateNormal];
        _appointmentButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        _appointmentButton.titleLabel.font = SWP_SYSTEM_FONT_SIZE(14);
        [_appointmentButton setTitle:@"立即预约" forState:UIControlStateNormal];
        _appointmentButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _appointmentButton;
}

- (void) setDataModel:(DiscountViewModel *)dataModel {
    _dataModel = dataModel;
    self.endDateLable.text = [NSString stringWithFormat:@"有效期至:%@",_dataModel.discountEndDate];
    self.couponValuesLable.text = _dataModel.discountCouponValues;
    self.nameLable.text = _dataModel.discountName;
    self.descriptionLable.text = _dataModel.discountDescription;
}

//// 1、未使用 2、已使用3、已到期
- (void) setStatus:(NSString *)status {
    _status = status;
    if (status.intValue == 1) {
        self.backgroundImageView.image = [UIImage imageNamed:@"黄色"];
        self.appointmentButton.hidden = NO;
        _couponValuesLable.textColor = [UIColor orangeColor];
    }else {
        self.backgroundImageView.image = [UIImage imageNamed:@"灰色"];
        self.appointmentButton.hidden = YES;
        _couponValuesLable.textColor = Color(208, 208, 208, 1);
    }
}


@end
