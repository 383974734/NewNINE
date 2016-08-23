//
//  IntegralPurchaseTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/23.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "IntegralPurchaseTableViewCell.h"

@interface IntegralPurchaseTableViewCell ()

/** 标题钱数*/
@property (nonatomic, strong) UILabel       * titleLable;
/** 金额钱数rmb*/
@property (nonatomic, strong) UILabel       * moneyLable;
/** 购买按钮*/
@property (nonatomic, strong) UIButton      * purchaseButton;
/** 背景图片*/
@property (nonatomic, strong) UIImageView   * backImageView;
/** 赠送积分金额*/
@property (nonatomic, strong) UILabel       * giveLable;

@property (nonatomic, copy)   NSString      *integralID;

@end

@implementation IntegralPurchaseTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return IntegralPurchaseTableViewCell
 */
+ (instancetype) integralPurchaseTableViewCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    IntegralPurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle     = UITableViewCellEditingStyleNone;
    return cell;
}

/**
 *  重写 cell 初始化方法 自定义cell
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return IntegralPurchaseTableViewCell
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
    [self.contentView   addSubview:self.backImageView];
    [self.backImageView addSubview:self.titleLable];
    [self.backImageView addSubview:self.giveLable];
    [self.backImageView addSubview:self.moneyLable];
    [self.backImageView addSubview:self.purchaseButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
}

- (void)didButton:(UIButton *)btn {
    NSLog(@"点击购买按钮");

}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, SCREEN_WIDTH - 110, 37)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor blackColor];

    }
    return _titleLable;
}


- (UILabel *)moneyLable {
    if (!_moneyLable) {
        _moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 50, SCREEN_WIDTH / 2 - 50, 40)];
        _moneyLable.textAlignment = NSTextAlignmentCenter;
        _moneyLable.textColor = [UIColor lightGrayColor];
    }
    return _moneyLable;
}

- (UIButton *)purchaseButton {
    if (!_purchaseButton) {
        _purchaseButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 205, 97, SCREEN_WIDTH / 2 - 39, 39)];
        [_purchaseButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _purchaseButton;
}

- (UIImageView *) backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 150)];
        _backImageView.image = [UIImage imageNamed:@"yellow"];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (UILabel *)giveLable {
    if (!_giveLable) {
        _giveLable = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 6, 50, 12)];
        _giveLable.textAlignment = NSTextAlignmentRight;
        _giveLable.textColor = [UIColor blueColor];
        _giveLable.adjustsFontSizeToFitWidth = YES;
        _giveLable.text = @"+赠10000积分";
    }
    return _giveLable;
}


- (void)setIntegralArray:(NSDictionary *)integralArray {
    _integralArray = integralArray;
    
    self.moneyLable.text = [NSString stringWithFormat:@"%@RMB", [integralArray objectForKey:@"fund"]];
    self.integralID      = [NSString stringWithFormat:@"%@", [integralArray objectForKey:@"di"]];
    if ([integralArray objectForKey:@"giftCount"] != nil    ) {
        self.giveLable.text  = [NSString stringWithFormat:@"+赠%@积分", [integralArray objectForKey:@"giftCount"]];
    }else {
        self.giveLable.text  = [NSString stringWithFormat:@"+赠%@积分", @"0"];
    }
    
    [self titleWithName:[integralArray objectForKey:@"integral"]];
}

- (void) setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    NSLog(@"%ld", indexPath.section % 3);
    switch (indexPath.section % 3) {
        case 1:
            self.backImageView.image = [UIImage imageNamed:@"green"];
            self.giveLable.textColor = Color(10, 152, 3, 1);
            break;
        case 2:
            self.backImageView.image = [UIImage imageNamed:@"violetv"];
            self.giveLable.textColor = [UIColor purpleColor];
            break;
        case 3:
            self.backImageView.image = [UIImage imageNamed:@"yellow"];
            self.giveLable.textColor = [UIColor orangeColor];
            break;
            
        default:
            break;
    }
    if (indexPath.section == 0) {
        self.backImageView.image = [UIImage imageNamed:@"yellow"];
        self.giveLable.textColor = [UIColor orangeColor];
    }
    
}

//文字颜色
- (void) titleWithName:(NSString *)str{
    NSString *string = [NSString stringWithFormat:@"%@ 积分",str];
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:NSMakeRange(0, string.length - 2)];
    self.titleLable.attributedText = hintString;
    
}

@end
