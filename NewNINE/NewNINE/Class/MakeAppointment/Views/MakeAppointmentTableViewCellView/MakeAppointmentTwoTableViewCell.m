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
/** cell点击*/
@property (nonatomic, strong) UIButton      * seleBttton;

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
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.minusButton];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.seleBttton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.minusButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 70, 12, 0) excludingEdge:ALEdgeRight];
    [self.minusButton autoSetDimension:ALDimensionWidth toSize:110];

}


- (UILabel *) titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 40, 21)];
        _titleLable.font      = SWP_SYSTEM_FONT_SIZE(16);
        _titleLable.textColor = Color(64, 64, 64, 1);
        _titleLable.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLable;
}

- (UILabel *) nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 1, 25)];
        _nameLable.backgroundColor  = [UIColor lightGrayColor];
        _nameLable.alpha            = 0.5;
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
        
        _minusButton.hidden = YES;
    }
    return _minusButton;
}

- (UIImageView *) arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 12, 21, 21)];
        _arrowImageView.image = [UIImage imageNamed:@"加号"];
    }
    return _arrowImageView;
}

- (UIButton *)seleBttton {
    if (!_seleBttton) {
        _seleBttton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_seleBttton addTarget:self action:@selector(didView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seleBttton;
}

- (void)didView:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(MakeAppointmentTwoTableViewCell:didSelectRowAtIndexPath:)]) {
        [self.delegate MakeAppointmentTwoTableViewCell:self didSelectRowAtIndexPath:self.indexPath];
    }
}

- (void) setTitle:(NSString *)title {
    _title = title;
    self.titleLable.text = _title;
    if (_title.length > 3) {
        self.nameLable.hidden     = YES;
        self.arrowImageView.image = [UIImage imageNamed:@"取消"];
        self.seleBttton.frame     = CGRectMake(SCREEN_WIDTH - 70, 0, 21, 45);
        self.titleLable.frame     = CGRectMake(60, 12, SCREEN_WIDTH - 140, 21);
        self.arrowImageView.frame = CGRectMake(SCREEN_WIDTH - 70, 12, 21, 21);
        [self titleWithName:_title];
    }else {
        self.nameLable.hidden     = NO;
        self.arrowImageView.image = [UIImage imageNamed:@"加号"];
        self.seleBttton.frame     = CGRectMake(0, 0, SCREEN_WIDTH, 45);
        self.titleLable.frame     = CGRectMake(20, 12, SCREEN_WIDTH - 100, 21);
        self.arrowImageView.frame = CGRectMake(SCREEN_WIDTH - 50, 12, 21, 21);
    }
}

- (void) setDict:(NSDictionary *)dict {
    _dict = dict;
    if ([[dict objectForKey:@"cutvalues"] intValue] > 0) {
        
        if (self.indexPath.row > 0) {
            self.minusButton.hidden = YES;
        }else {
            self.minusButton.hidden = NO;
        }
        [self.minusButton setTitle:[NSString stringWithFormat:@"立减%@元", [dict objectForKey:@"cutvalues"]] forState:UIControlStateNormal];
    }else {
        self.minusButton.hidden = YES;
    }
}

//文字颜色
- (void) titleWithName:(NSString *)str {
    NSString *str1 = [str componentsSeparatedByString:@"-"][0];
    NSString *str2 = [str componentsSeparatedByString:@"-"][1];
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:str];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str1.length)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(str1.length, str2.length + 1)];
    self.titleLable.attributedText = hintString;
}

@end
