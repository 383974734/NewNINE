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
@property (nonatomic, strong) UIButton *blowArrowImageView;
/** 洗吹选择图*/
@property (nonatomic, strong) UIButton *arrowImageView;
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
/** 洗剪吹原价钱*/
@property (nonatomic, strong) UILabel *arrowOriginalPriceLable;
/** 洗吹文字*/
@property (nonatomic, strong) UILabel *blowTitleLable;
/** 洗吹立减文字*/
@property (nonatomic, strong) UILabel *blowCutvalues;
/** 洗吹价钱*/
@property (nonatomic, strong) UILabel *blowMoneyLable;
/** 洗吹原价钱*/
@property (nonatomic, strong) UILabel *blowOriginalPriceLable;
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

/** 洗剪吹价位*/
@property (nonatomic, copy) NSString *arrowMoneyStr;
/** 洗吹价位*/
@property (nonatomic, copy) NSString *blowMoneyStr;

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
        
        self.arrowMoneyStr = @"0";
        self.blowMoneyStr  = @"0";
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
    [self.arrowButton addSubview:self.arrowOriginalPriceLable];
    
    [self.blowHeadButton addSubview:self.blowArrowImageView];
    [self.blowHeadButton addSubview:self.blowTitleLable];
    [self.blowHeadButton addSubview:self.blowMoneyLable];
    [self.blowHeadButton addSubview:self.blowCutvalues];
    [self.blowHeadButton addSubview:self.blowOriginalPriceLable];
    
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
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 40, 40)];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 20;
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

- (UIButton *)blowArrowImageView {
    if (!_blowArrowImageView) {
        _blowArrowImageView = [[UIButton alloc] initWithFrame:CGRectMake(17, 15, 20, 20)];
        [_blowArrowImageView setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }
    return _blowArrowImageView;
}

- (UIButton *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIButton alloc] initWithFrame:CGRectMake(17, 15, 20, 20)];
        [_arrowImageView setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        
    }
    return _arrowImageView;
}

- (UIImageView *)timeArrowImageView {
    if (!_timeArrowImageView) {
        _timeArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 17, 15, 15)];
        _timeArrowImageView.image = [UIImage imageNamed:@"进入箭头"];
    }
    return _timeArrowImageView;
}

- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH - 220, 49)];
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
        _arrowTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 70, 49)];
        _arrowTitleLable.text = @"剪发";
        _arrowTitleLable.adjustsFontSizeToFitWidth = YES;
    }
    return _arrowTitleLable;
}

- (UILabel *)arrowCutvalues {
    if (!_arrowCutvalues) {
        _arrowCutvalues                   = [[UILabel alloc] init];
        _arrowCutvalues.textColor         = [UIColor redColor];
        _arrowCutvalues.layer.borderWidth = 1;
        _arrowCutvalues.layer.borderColor = [UIColor redColor].CGColor;
        _arrowCutvalues.font              = SWP_SYSTEM_FONT_SIZE(12);
        _arrowCutvalues.hidden            = YES;
    }
    return _arrowCutvalues;
}

- (UILabel *)arrowMoneyLable {
    if (!_arrowMoneyLable) {
        _arrowMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 50, 49)];
        _arrowMoneyLable.textAlignment = NSTextAlignmentRight;
        _arrowMoneyLable.text          = @"￥0";
        _arrowMoneyLable.adjustsFontSizeToFitWidth = YES;
    }
    return _arrowMoneyLable;
}

- (UILabel *)arrowOriginalPriceLable {
    if (!_arrowOriginalPriceLable) {
        _arrowOriginalPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 127, 0, 45, 49)];
        _arrowOriginalPriceLable.textAlignment  = NSTextAlignmentRight;
        _arrowOriginalPriceLable.textColor      = [UIColor lightGrayColor];
        _arrowOriginalPriceLable.adjustsFontSizeToFitWidth = YES;
    }
    return _arrowOriginalPriceLable;
}

- (UILabel *)blowTitleLable {
    if (!_blowTitleLable) {
        _blowTitleLable      = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 70, 49)];
        _blowTitleLable.text = @"洗吹造型";
        _blowTitleLable.adjustsFontSizeToFitWidth = YES;
        
    }
    return _blowTitleLable;
}

- (UILabel *)blowCutvalues {
    if (!_blowCutvalues) {
        _blowCutvalues                   = [[UILabel alloc] init];
        _blowCutvalues.textColor         = [UIColor redColor];
        _blowCutvalues.layer.borderWidth = 1;
        _blowCutvalues.layer.borderColor = [UIColor redColor].CGColor;
        _blowCutvalues.font              = SWP_SYSTEM_FONT_SIZE(12);
        _blowCutvalues.hidden            = YES;
        
    }
    return _blowCutvalues;
}

- (UILabel *)blowMoneyLable {
    if (!_blowMoneyLable) {
        _blowMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 50, 49)];
        _blowMoneyLable.textAlignment = NSTextAlignmentRight;
        _blowMoneyLable.text          = @"￥0";
        _blowMoneyLable.adjustsFontSizeToFitWidth = YES;
        
    }
    return _blowMoneyLable;
}

- (UILabel *)blowOriginalPriceLable {
    if (!_blowOriginalPriceLable) {
        _blowOriginalPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 127, 0, 45, 49)];
        _blowOriginalPriceLable.textAlignment = NSTextAlignmentRight;
        _blowOriginalPriceLable.textColor     = [UIColor lightGrayColor];
        _blowOriginalPriceLable.adjustsFontSizeToFitWidth = YES;
    }
    return _blowOriginalPriceLable;
}

- (UILabel *)timeTitleLable {
    if (!_timeTitleLable) {
        _timeTitleLable      = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 49)];
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
        _storeTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 49)];
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
    if (![self.nameLable.text isEqualToString:@"设计师"]) {
        // button 的 默认状态下的图片
        NSData *dataButton = UIImagePNGRepresentation([self.arrowImageView imageForState:UIControlStateNormal]);
        if (btn.tag == 2) {
            dataButton = UIImagePNGRepresentation([self.blowArrowImageView imageForState:UIControlStateNormal]);
        }
        
        // 固定图片
        NSData *dataImage  = UIImagePNGRepresentation([UIImage imageNamed:@"未选中"]);
        if ([dataButton isEqual:dataImage])
        {
            if (btn.tag == 1) {
                
                [self.arrowImageView setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
                self.arrowTitleLable.textColor = [UIColor redColor];
                self.arrowMoneyLable.textColor = [UIColor redColor];
                
                
                self.arrowMoneyStr = [NSString stringWithFormat:@"%d", [[[self.dict objectForKey:@"bookProducts"][0] objectForKey:@"price"] intValue] - [[[self.dict objectForKey:@"bookProducts"][0] objectForKey:@"cutvalues"] intValue]];
                
            }
            
            if (btn.tag == 2) {
                [self.blowArrowImageView setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
                self.blowTitleLable.textColor  = [UIColor redColor];
                self.blowMoneyLable.textColor  = [UIColor redColor];
                
                self.blowMoneyStr = [NSString stringWithFormat:@"%d", [[[self.dict objectForKey:@"bookProducts"][1] objectForKey:@"price"] intValue] - [[[self.dict objectForKey:@"bookProducts"][1] objectForKey:@"cutvalues"] intValue]];
            }
        }
        else
        {
            //不相同
            if (btn.tag == 1) {
                [self.arrowImageView setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
                self.arrowTitleLable.textColor = [UIColor blackColor];
                self.arrowMoneyLable.textColor = [UIColor blackColor];
                self.arrowMoneyStr = @"0";
            }
            
            if (btn.tag == 2) {
                [self.blowArrowImageView setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
                self.blowTitleLable.textColor  = [UIColor blackColor];
                self.blowMoneyLable.textColor  = [UIColor blackColor];
                self.blowMoneyStr = @"0";
            }
        }
    }
    
    
   

    if ([self.delegate respondsToSelector:@selector(makeAppointmentOneTableViewCell:buttonWithTag:selectCategory1:selectCategory2:)]) {
        [self.delegate makeAppointmentOneTableViewCell:self buttonWithTag:btn.tag selectCategory1:self.arrowMoneyStr selectCategory2:self.blowMoneyStr];
    }
}

- (void) setDict:(NSDictionary *)dict {
    _dict = dict;
    
    self.arrowTitleLable.text = [[[_dict objectForKey:@"bookProducts"][0] objectForKey:@"productName"] length] > 0 ? [NSString stringWithFormat:@"%@", [[_dict objectForKey:@"bookProducts"][0] objectForKey:@"productName"]] : @"剪发";
    
    self.blowTitleLable.text = [[[_dict objectForKey:@"bookProducts"][1] objectForKey:@"productName"] length] > 0 ? [NSString stringWithFormat:@"%@", [[_dict objectForKey:@"bookProducts"][1] objectForKey:@"productName"]]: @"洗吹造型";

    
    [self.headImageView  sd_setImageWithURL:[NSURL URLWithString:[_dict objectForKey:@"iconPhotoUrl"]]
                                 placeholderImage:[UIImage imageNamed:@"logo144"]
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                        }];
    
    
    if (![self.nameLable.text isEqualToString:[_dict objectForKey:@"name"]]) {
        self.arrowMoneyStr = @"0";
        self.blowMoneyStr  = @"0";
        [self.arrowImageView     setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [self.blowArrowImageView setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];

        self.arrowTitleLable.textColor = [UIColor blackColor];
        self.arrowMoneyLable.textColor = [UIColor blackColor];
        self.blowTitleLable.textColor  = [UIColor blackColor];
        self.blowMoneyLable.textColor  = [UIColor blackColor];
    }
    
    self.nameLable.text = [_dict objectForKey:@"name"];
    self.headLable.text = [_dict objectForKey:@"leveName"];
    
    NSArray *array = [_dict objectForKey:@"bookProducts"];
    if (!(array.count > 1)) return;

    self.arrowMoneyLable.text = [NSString stringWithFormat:@"￥%@", [[_dict objectForKey:@"bookProducts"][0] objectForKey:@"price"]];
    self.blowMoneyLable.text = [NSString stringWithFormat:@"￥%@", [[_dict objectForKey:@"bookProducts"][1] objectForKey:@"price"]];
    
    self.storeLable.text = [[_dict objectForKey:@"studio"] objectForKey:@"names"];
    
    self.arrowOriginalPriceLable.attributedText = [self uiWithAttribute:[NSString stringWithFormat:@"￥%@", [[_dict objectForKey:@"bookProducts"][0] objectForKey:@"originalPrice"]]];
    self.blowOriginalPriceLable.attributedText  = [self uiWithAttribute:[NSString stringWithFormat:@"￥%@", [[_dict objectForKey:@"bookProducts"][1] objectForKey:@"originalPrice"]]];
    
    
    self.arrowOriginalPriceLable.hidden = YES;
    self.blowOriginalPriceLable.hidden  = YES;
    if ([[[_dict objectForKey:@"bookProducts"][0] objectForKey:@"price"] intValue] < [[[_dict objectForKey:@"bookProducts"][0] objectForKey:@"originalPrice"] intValue]) {
        self.arrowOriginalPriceLable.hidden = NO;
    }
    if ([[[_dict objectForKey:@"bookProducts"][1] objectForKey:@"price"] intValue] < [[[_dict objectForKey:@"bookProducts"][1] objectForKey:@"originalPrice"] intValue]) {
        self.blowOriginalPriceLable.hidden = NO;
    }
    
    if ([[[_dict objectForKey:@"bookProducts"][0] objectForKey:@"cutvalues"] intValue] > 0) {
        
        self.arrowCutvalues.hidden = NO;
        self.arrowCutvalues.text = [NSString stringWithFormat:@" 立减%@元", [[_dict objectForKey:@"bookProducts"][0] objectForKey:@"cutvalues"]];
        CGSize nameSize = [self uiWithConstrained:self.arrowCutvalues.text];
        self.arrowCutvalues.frame = CGRectMake(122, 15, nameSize.width, 20);
    }else {
        self.arrowCutvalues.hidden = YES;
    }
    
    if ([[[_dict objectForKey:@"bookProducts"][1] objectForKey:@"cutvalues"] intValue] > 0) {

        self.blowCutvalues.hidden  = NO;
        self.blowCutvalues.text  = [NSString stringWithFormat:@" 立减%@元", [[_dict objectForKey:@"bookProducts"][1] objectForKey:@"cutvalues"]];
        CGSize nameSize = [self uiWithConstrained:self.blowCutvalues.text];
        self.blowCutvalues.frame = CGRectMake(122, 15, nameSize.width, 20);
    }else {
        self.blowCutvalues.hidden  = YES;
    }
    
}


- (void) setTimeMake:(NSString *)timeMake {
    _timeMake = timeMake;
    if (_timeMake.length > 1) {
        self.timeLable.text = _timeMake;
    }else {
        self.timeLable.text = @"请选择";

    }
    
}


- (NSMutableAttributedString *)uiWithAttribute:(NSString *)str {
    NSString *testString1 = [NSString stringWithFormat:@"%@", str];
    NSMutableAttributedString * testAttriString1 = [[NSMutableAttributedString alloc] initWithString:testString1];
    // 实现文本内容颜色和下划线,删除线的颜色不一样
    // NSStrokeColorAttributeName 单独设置没有效果
    // 必须与NSStrokeWidthAttributeName一起设置
    [testAttriString1 addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, testAttriString1.length)];
    [testAttriString1 addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, testAttriString1.length)];
    [testAttriString1 addAttribute:NSStrokeColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, testAttriString1.length)];
    return testAttriString1;
}


- (CGSize)uiWithConstrained:(NSString *)title {
    UIFont *nameFnt     = [UIFont fontWithName:@"Arial" size:13];
    CGSize size         = CGSizeMake(320,20);
//    CGSize nameSize   = [title sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    NSDictionary *dict  = @{NSFontAttributeName : nameFnt};
    
    CGSize nameSize     = [title boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    return nameSize;
}



@end
