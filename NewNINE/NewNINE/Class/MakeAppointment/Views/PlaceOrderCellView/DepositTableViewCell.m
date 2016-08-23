//
//  DepositTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 定金view

#import "DepositTableViewCell.h"

@interface DepositTableViewCell ()

@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UIButton *seleImage;

@property (nonatomic, strong) UIButton *seleButton;

@end


@implementation DepositTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return DepositTableViewCell
 */
+ (instancetype) depositCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    DepositTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return DepositTableViewCell
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
    [self addSubview:self.titleLable];
    [self addSubview:self.seleImage];
    [self addSubview:self.seleButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    
    [self.titleLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 35)];
    
    [self.seleImage autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 0, 10, 10) excludingEdge:ALEdgeLeft];
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
    
    if ([self.delegate respondsToSelector:@selector(depositTableViewCell:selectedBool:)]) {
        [self.delegate depositTableViewCell:self selectedBool:btn.selected];
    }
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initForAutoLayout];
        _titleLable.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLable;
}

- (UIButton *)seleImage {
    if (!_seleImage) {
        _seleImage = [[UIButton alloc] initForAutoLayout];
        [_seleImage setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
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


- (void)setTotalString:(NSString *)totalString {
    _totalString = totalString;
    [self titleWithName:@"50" str2:_totalString];
}

- (void) setOrderIsDepfund:(NSString *)orderIsDepfund {
    _orderIsDepfund = orderIsDepfund;
    if (_orderIsDepfund.intValue == 2) {
        [self.seleImage setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        self.seleButton.userInteractionEnabled = NO;
    }
}

//文字颜色
- (void) titleWithName:(NSString *)str1 str2:(NSString *)str2{
    NSString *string1 = [NSString stringWithFormat:@"(服务完成后需付尾款￥%@)", str2];
    NSString *string2 = [NSString stringWithFormat:@"仅支付定金:￥%@%@", str1, string1];
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:string2];
    
    [hintString addAttribute:NSForegroundColorAttributeName value:Color(64, 64, 64, 1) range:NSMakeRange(0, 6)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6, str1.length + 1)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(str1.length + 7, 10)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str1.length + 17, str2.length + 1)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(string2.length - 1, 1)];

    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str1.length + 7)];
    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(str1.length + 7, string1.length)];
    
    self.titleLable.attributedText = hintString;
}

@end
