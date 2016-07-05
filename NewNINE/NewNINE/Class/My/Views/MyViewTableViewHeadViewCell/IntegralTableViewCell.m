//
//  IntegralTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "IntegralTableViewCell.h"

// ---------------------- view       ----------------------
#import "IntegralViewModel.h"
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------

@interface IntegralTableViewCell ()
// ---------------------- UI 控件 ----------------------
/** 名字*/
@property (nonatomic, strong) UILabel *nameLable;
/** 时间*/
@property (nonatomic, strong) UILabel *timeLable;
/** 积分*/
@property (nonatomic, strong) UILabel *integralLable;
/** 金额*/
@property (nonatomic, strong) UILabel *moneyLable;
#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------



@end

@implementation IntegralTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return CollectionTableViewCell
 */
+ (instancetype) integralCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    IntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    //    cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;//箭头
//    [cell setSeparatorInset:UIEdgeInsetsZero];
    cell.backgroundColor = [UIColor whiteColor];
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
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.timeLable];
    [self.contentView addSubview:self.integralLable];
    [self.contentView addSubview:self.moneyLable];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 15, 27, 0) excludingEdge:ALEdgeRight];
    [self.nameLable autoSetDimension:ALDimensionWidth toSize:35];
    
    [self.timeLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(13, 0, 28, 15) excludingEdge:ALEdgeLeft];
    [self.timeLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nameLable withOffset:5];
    
    [self.integralLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(30, 15, 10, 0) excludingEdge:ALEdgeRight];
    [self.integralLable autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH / 2];
    
    [self.moneyLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(27, 0, 15, 11) excludingEdge:ALEdgeLeft];
    [self.moneyLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.integralLable withOffset:5];
    
}



- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable           = [[UILabel alloc] initForAutoLayout];
        _nameLable.font      = SWP_SYSTEM_FONT_SIZE(15);
        _nameLable.textColor = Color(64, 64, 64, 1);
    }
    return _nameLable;
}

- (UILabel *) timeLable {
    if (!_timeLable) {
        _timeLable               = [[UILabel alloc] initForAutoLayout];
        _timeLable.font          = SWP_SYSTEM_FONT_SIZE(12);
        _timeLable.textColor     = Color(154, 154, 154, 1);
        _timeLable.textAlignment = NSTextAlignmentRight;
    }
    return _timeLable;
}

- (UILabel *) integralLable {
    if (!_integralLable) {
        _integralLable           = [[UILabel alloc] initForAutoLayout];
        _integralLable.font      = SWP_SYSTEM_FONT_SIZE(12);
        _integralLable.textColor = Color(154, 154, 154, 1);
//        _integralLable.text      = @"积分余额:";
    }
    return _integralLable;
}

- (UILabel *) moneyLable {
    if (!_moneyLable) {
        _moneyLable                 = [[UILabel alloc] initForAutoLayout];
        _moneyLable.font            = SWP_SYSTEM_FONT_SIZE(14);
        _moneyLable.textColor       = Color(234, 41, 41, 1);
        _moneyLable.textAlignment   = NSTextAlignmentRight;
    }
    return _moneyLable;
}

- (void)setDataModel:(IntegralViewModel *)dataModel {
    _dataModel = dataModel;
    
    self.timeLable.text          = [NSString stringWithFormat:@"%@", _dataModel.integralCreatedDate];
    self.integralLable.text      = [NSString stringWithFormat:@"积分余额:%@", _dataModel.integralBalance];
    NSString *str = [NSString stringWithFormat:@"%@", _dataModel.integralType];
    if (str.integerValue == 2) {
        self.nameLable.text  = @"支出";
        self.moneyLable.text = [NSString stringWithFormat:@"-%@", _dataModel.integralIntegral];
    }else {
        self.nameLable.text  = @"收入";
       self.moneyLable.text = [NSString stringWithFormat:@"+%@", _dataModel.integralIntegral];
    }
}

@end
