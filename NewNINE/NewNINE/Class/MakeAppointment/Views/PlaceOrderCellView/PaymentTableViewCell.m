//
//  PaymentTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 支付view

#import "PaymentTableViewCell.h"


@interface PaymentTableViewCell ()

/** 标题 */
@property (nonatomic, strong) UILabel *titleLable;
/** 内容 */
@property (nonatomic, strong) UILabel *nameLable;


@property (nonatomic, strong) UIButton *seleImage;

@property (nonatomic, strong) UIButton *seleButton;




/** 积分抵扣金额 */
@property (nonatomic, copy) NSString *deductibleStr;

@end


@implementation PaymentTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return PaymentTableViewCell
 */
+ (instancetype) paymentCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return PaymentTableViewCell
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
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.nameLable];
    
    [self.contentView addSubview:self.seleImage];
    [self.contentView addSubview:self.seleButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 15, 0, 0) excludingEdge:ALEdgeRight];
    [self.titleLable autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH - 140];
    
    
    [self.seleImage autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 10, 15) excludingEdge:ALEdgeLeft];
    [self.seleImage autoSetDimension:ALDimensionWidth toSize:25];
    
    [self.seleButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}


- (void)didButton:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        [_seleImage setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    }else {
        [_seleImage setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(paymentTableViewCell:deductibleStr:selectedBool:)]) {
        [self.delegate paymentTableViewCell:self deductibleStr:self.deductibleStr selectedBool:btn.selected];
    }
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.adjustsFontSizeToFitWidth = YES;
        _titleLable.textColor = Color(64, 64, 64, 1);
    }
    return _titleLable;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initForAutoLayout];
        _nameLable.textAlignment = NSTextAlignmentRight;
        _nameLable.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLable;
}


- (void) setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    if (_titleStr.length > 5) {
        [self titleWithName:_titleStr];
        return;
    }
    if ([_titleStr isEqualToString:@"无可用积分"]) {
        self.seleImage.hidden = YES;
    }
    self.titleLable.text = _titleStr;
    
}


- (void) setNameStr:(NSString *)nameStr {
    _nameStr = nameStr;
    self.nameLable.text = _nameStr;
}

- (UIButton *)seleImage {
    if (!_seleImage) {
        _seleImage = [[UIButton alloc] initForAutoLayout];
        [_seleImage setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        _seleImage.hidden = YES;
    }
    return _seleImage;
}

- (UIButton *)seleButton {
    if (!_seleButton) {
        _seleButton = [[UIButton alloc] initForAutoLayout];
        [_seleButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seleButton;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    if ([_titleString isEqualToString:@"订单详情"]) {
        if (indexPath.row == 0) {
            self.nameLable.textColor = [UIColor lightGrayColor];
            if ([self.titleStr isEqualToString:@"订单金额"]) {
                self.nameLable.textColor = [UIColor redColor];
            }
            
        }else {
            self.nameLable.textColor = [UIColor redColor];
        }
        
        [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH - 120, 0, 15)];
    }else {
        if (indexPath.row == 0) {
            [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH - 120, 0, 0)];
        }else {
            [self.nameLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, SCREEN_WIDTH - 120, 0, 15)];
        }
        self.nameLable.textColor = [UIColor redColor];
        if (indexPath.row == 1) {
            self.seleImage.hidden = NO;
            self.nameLable.hidden = YES;
            if ([_titleStr isEqualToString:@"无可用积分"]) {
                self.seleImage.hidden = YES;
            }
        }
    }
}

//文字颜色
- (void) titleWithName:(NSString *)str {
    NSString *str1 = [str componentsSeparatedByString:@"￥"][0];
    NSString *str2 = [str componentsSeparatedByString:@"￥"][1];
    self.deductibleStr = str2;
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:str];
    [hintString addAttribute:NSForegroundColorAttributeName value:Color(64, 64, 64, 1) range:NSMakeRange(0, str1.length)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str1.length, str2.length + 1)];
    self.titleLable.attributedText = hintString;
}


- (void) setTitleString:(NSString *)titleString {
    _titleString = titleString;
    
}

@end
