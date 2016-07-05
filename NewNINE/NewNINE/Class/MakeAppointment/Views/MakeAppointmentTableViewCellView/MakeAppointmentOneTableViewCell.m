//
//  MakeAppointmentOneTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/21.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MakeAppointmentOneTableViewCell.h"


@interface MakeAppointmentOneTableViewCell ()


#pragma mark - UI   Propertys
// ---------------------- UI 控件 ----------------------
/***/
@property (nonatomic, strong) UIView   *backView;
/** 头像view*/
@property (nonatomic, strong) UIButton *headPortraitButton;
/** 洗剪吹view*/
@property (nonatomic, strong) UIButton *arrowButton;
/** 洗吹view*/
@property (nonatomic, strong) UIButton *blowHeadButton;
/** 时间view*/
@property (nonatomic, strong) UIButton *timeButton;
/** 门店view*/
@property (nonatomic, strong) UIView   *storeView;

/** 头像*/
@property (nonatomic, strong) UIImageView *headImageView;
/** 头像箭头*/
@property (nonatomic, strong) UIImageView *headArrowImageView;
/** 洗剪吹选择图*/
@property (nonatomic, strong) UIImageView *blowArrowImageView;
/** 洗吹选择图*/
@property (nonatomic, strong) UIImageView *arrowImageView;
/** 预约时间图*/
@property (nonatomic, strong) UIImageView *timeArrowImageView;
/** 名字*/
@property (nonatomic, strong) UILabel *nameLable;
/** 美发师职称*/
@property (nonatomic, strong) UILabel *headLable;
/** 洗剪吹文字*/
@property (nonatomic, strong) UILabel *arrowTitleLable;
/** 洗剪吹立减文字*/
@property (nonatomic, strong) UILabel *arrowCutvalues;
/** 洗剪吹价钱*/
@property (nonatomic, strong) UILabel *arrowMoneyLable;
/** 洗吹文字*/
@property (nonatomic, strong) UILabel *blowTitleLable;
/** 洗吹立减文字*/
@property (nonatomic, strong) UILabel *blowCutvalues;
/** 洗吹价钱*/
@property (nonatomic, strong) UILabel *blowMoneyLable;
/** 预约时间文字*/
@property (nonatomic, strong) UILabel *timeTitleLable;
/** 预约时间*/
@property (nonatomic, strong) UILabel *timeLable;
/** 预约门店文字*/
@property (nonatomic, strong) UILabel *storeTitleLable;
/** 门店名字*/
@property (nonatomic, strong) UILabel *storeLable;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation MakeAppointmentOneTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return MakeAppointmentOneTableViewCell
 */
+ (instancetype) makeAppointmentOneCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    MakeAppointmentOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
 *  @return MakeAppointmentOneTableViewCell
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
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.headPortraitButton];
    [self.backView addSubview:self.arrowButton];
    [self.backView addSubview:self.blowHeadButton];
    [self.backView addSubview:self.timeButton];
    [self.backView addSubview:self.storeView];
    
    [self.headPortraitButton addSubview:self.headImageView];
    [self.headPortraitButton addSubview:self.nameLable];
    [self.headPortraitButton addSubview:self.headLable];
    [self.headPortraitButton addSubview:self.headArrowImageView];
    
    [self.arrowButton addSubview:self.arrowImageView];
    [self.arrowButton addSubview:self.arrowCutvalues];
    [self.arrowButton addSubview:self.arrowTitleLable];
    [self.arrowButton addSubview:self.arrowMoneyLable];
    
    [self.blowHeadButton addSubview:self.blowArrowImageView];
    [self.blowHeadButton addSubview:self.blowTitleLable];
    [self.blowHeadButton addSubview:self.blowMoneyLable];
    [self.blowHeadButton addSubview:self.blowCutvalues];
    
    [self.timeButton addSubview:self.timeArrowImageView];
    [self.timeButton addSubview:self.timeTitleLable];
    [self.timeButton addSubview:self.timeLable];

    [self.storeView addSubview:self.storeTitleLable];
    [self.storeView addSubview:self.storeLable];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];

    
}
- (UIView *) backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 250)];
        _backView.backgroundColor = Color(248, 248, 248, 1);
    }
    return _backView;
}

- (UIButton *) headPortraitButton{
    if (!_headPortraitButton) {
        _headPortraitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        [self buttonWithUI:_headPortraitButton tag:0];
    }
    return _headPortraitButton;
}

- (UIButton *) arrowButton{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 49)];
        [self buttonWithUI:_arrowButton tag:1];
    }
    return _arrowButton;
}

- (UIButton *) blowHeadButton{
    if (!_blowHeadButton) {
        _blowHeadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 49)];
        [self buttonWithUI:_blowHeadButton tag:2];
    }
    return _blowHeadButton;
}

- (UIButton *) timeButton{
    if (!_timeButton) {
        _timeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 49)];
        [self buttonWithUI:_timeButton tag:3];
    }
    return _timeButton;
}

- (UIView *) storeView{
    if (!_storeView) {
        _storeView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 45)];
        _storeView.backgroundColor = [UIColor whiteColor];
    }
    return _storeView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 40, 40)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 18;
        _headImageView.image = [UIImage imageNamed:@"logo144"];
    }
    return _headImageView;
}

- (UIImageView *)headArrowImageView {
    if (!_headArrowImageView) {
        _headArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 15, 15, 15)];
        _headArrowImageView.image = [UIImage imageNamed:@"进入箭头"];
    }
    return _headArrowImageView;
}

- (UIImageView *)blowArrowImageView {
    if (!_blowArrowImageView) {
        _blowArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(27, 15, 20, 20)];
        _blowArrowImageView.image = [UIImage imageNamed:@"未选中"];
    }
    return _blowArrowImageView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(27, 15, 20, 20)];
        _arrowImageView.image = [UIImage imageNamed:@"未选中"];
        
    }
    return _arrowImageView;
}

- (UIImageView *)timeArrowImageView {
    if (!_timeArrowImageView) {
        _timeArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 15, 15, 15)];
        _timeArrowImageView.image = [UIImage imageNamed:@"进入箭头"];
    }
    return _timeArrowImageView;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH - 220, 49)];
        _nameLable.text = @"设计师";
    }
    return _nameLable;
}

- (UILabel *)headLable {
    if (!_headLable) {
        _headLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 0, 100, 49)];
        _headLable.textAlignment = NSTextAlignmentRight;
        _headLable.textColor = Color(154, 154, 154, 1);
        _headLable.text = @"请选择";
    }
    return _headLable;
}

- (UILabel *)arrowTitleLable {
    if (!_arrowTitleLable) {
        _arrowTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 60, 49)];
        _arrowTitleLable.text = @"洗剪吹";
    }
    return _arrowTitleLable;
}

- (UILabel *)arrowCutvalues {
    if (!_arrowCutvalues) {
        _arrowCutvalues                   = [[UILabel alloc] init];
        _arrowCutvalues.textColor         = [UIColor redColor];
        _arrowCutvalues.layer.borderWidth = 1;
        _arrowCutvalues.layer.borderColor = [UIColor redColor].CGColor;
        _arrowCutvalues.font              = SWP_SYSTEM_FONT_SIZE(13);
    }
    return _arrowCutvalues;
}

- (UILabel *)arrowMoneyLable {
    if (!_arrowMoneyLable) {
        _arrowMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 220, 0, SCREEN_WIDTH - 200, 49)];
        _arrowMoneyLable.textAlignment = NSTextAlignmentRight;
        _arrowMoneyLable.text          = @"￥0";
    }
    return _arrowMoneyLable;
}

- (UILabel *)blowTitleLable {
    if (!_blowTitleLable) {
        _blowTitleLable      = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 60, 49)];
        _blowTitleLable.text = @"洗吹";
        
    }
    return _blowTitleLable;
}

- (UILabel *)blowCutvalues {
    if (!_blowCutvalues) {
        _blowCutvalues                   = [[UILabel alloc] init];
        _blowCutvalues.textColor         = [UIColor redColor];
        _blowCutvalues.layer.borderWidth = 1;
        _blowCutvalues.layer.borderColor = [UIColor redColor].CGColor;
        _blowCutvalues.font              = SWP_SYSTEM_FONT_SIZE(13);
        
    }
    return _blowCutvalues;
}

- (UILabel *)blowMoneyLable {
    if (!_blowMoneyLable) {
        _blowMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 220, 0, SCREEN_WIDTH - 200, 49)];
        _blowMoneyLable.textAlignment = NSTextAlignmentRight;
        _blowMoneyLable.text          = @"￥0";
        
    }
    return _blowMoneyLable;
}

- (UILabel *)timeTitleLable {
    if (!_timeTitleLable) {
        _timeTitleLable      = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 49)];
        _timeTitleLable.text = @"预约时间";
    }
    return _timeTitleLable;
}

- (UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH - 110, 49)];
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.textColor = Color(154, 154, 154, 1);
        _timeLable.text = @"请选择";
    }
    return _timeLable;
}

- (UILabel *)storeTitleLable {
    if (!_storeTitleLable) {
        _storeTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 49)];
        _storeTitleLable.text = @"预约门店";
    }
    return _storeTitleLable;
}

- (UILabel *)storeLable {
    if (!_storeLable) {
        _storeLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH - 110, 49)];
        _storeLable.textAlignment = NSTextAlignmentRight;
        _storeLable.textColor = Color(154, 154, 154, 1);
    }
    return _storeLable;
}


- (void) buttonWithUI:(UIButton *)button tag:(NSInteger)tag{
    button.backgroundColor = [UIColor whiteColor];
    button.tag = tag;
    [button addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didButton:(UIButton *)btn {
    if (![self.headLable.text isEqualToString:@"请选择"]) {
        if (btn.tag == 1) {
            _arrowImageView.image      = [UIImage imageNamed:@"选中"];
            _arrowTitleLable.textColor = [UIColor redColor];
            _arrowMoneyLable.textColor = [UIColor redColor];
            _blowArrowImageView.image  = [UIImage imageNamed:@"未选中"];
            _blowTitleLable.textColor  = [UIColor blackColor];
            _blowMoneyLable.textColor  = [UIColor blackColor];
        }
        if (btn.tag == 2) {
            _arrowImageView.image      = [UIImage imageNamed:@"未选中"];
            _arrowTitleLable.textColor = [UIColor blackColor];
            _arrowMoneyLable.textColor = [UIColor blackColor];
            _blowArrowImageView.image  = [UIImage imageNamed:@"选中"];
            _blowTitleLable.textColor  = [UIColor redColor];
            _blowMoneyLable.textColor  = [UIColor redColor];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(makeAppointmentOneTableViewCell:buttonWithTag:)]) {
        [self.delegate makeAppointmentOneTableViewCell:self buttonWithTag:btn.tag];
    }
}

- (void) setDict:(NSDictionary *)dict {
    _dict = dict;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[_dict objectForKey:@"iconPhotoUrl"]] placeholderImage:[UIImage imageNamed:@"logo144"]];
    self.nameLable.text = [_dict objectForKey:@"name"];
    self.headLable.text = [_dict objectForKey:@"leveName"];
    self.arrowMoneyLable.text = [NSString stringWithFormat:@"￥%@", [[_dict objectForKey:@"bookProducts"][0] objectForKey:@"originalPrice"]];
    self.blowMoneyLable.text = [NSString stringWithFormat:@"￥%@", [[_dict objectForKey:@"bookProducts"][1] objectForKey:@"originalPrice"]];
    self.storeLable.text = [[_dict objectForKey:@"studio"] objectForKey:@"names"];
    
    if ([[[_dict objectForKey:@"bookProducts"][0] objectForKey:@"cutvalues"] intValue] > 0) {
        self.arrowCutvalues.text = [NSString stringWithFormat:@" 立减%@元", [[_dict objectForKey:@"bookProducts"][0] objectForKey:@"cutvalues"]];
        CGSize nameSize = [self uiWithConstrained:self.arrowCutvalues.text];
        self.arrowCutvalues.frame = CGRectMake(130, 15, nameSize.width, 20);
        self.blowCutvalues.text  = [NSString stringWithFormat:@" 立减%@元", [[_dict objectForKey:@"bookProducts"][1] objectForKey:@"cutvalues"]];
        nameSize = [self uiWithConstrained:self.blowCutvalues.text];
        self.blowCutvalues.frame = CGRectMake(130, 15, nameSize.width, 20);
    }
    
}


- (CGSize)uiWithConstrained:(NSString *)title {
    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
    CGSize size = CGSizeMake(320,20);
    CGSize nameSize = [title sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    return nameSize;
}

@end
