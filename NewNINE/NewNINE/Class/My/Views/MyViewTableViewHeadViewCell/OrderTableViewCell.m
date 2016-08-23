//
//  OrderTableViewCell.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderView.h"
#import "OrderViewModel.h"


@interface OrderTableViewCell ()

// ---------------------- UI 控件 ----------------------

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *footerView;

/** 设计师图片*/
@property (nonatomic, strong) UIImageView *userImageView;
/** 设计师名字*/
@property (nonatomic, strong) UILabel *userName;
/** 设计师职称*/
@property (nonatomic, strong) UILabel *stylistId;
/** 状态*/
@property (nonatomic, strong) UILabel *status;
/** 订单金额文字*/
@property (nonatomic, strong) UILabel *orderMoneyTitle;
///** 订单金额上面的线*/
@property (nonatomic, strong) UILabel *xianView;
/** 状态按钮*/
@property (nonatomic, strong) UIButton *statusButton;
/** 追加订单按钮*/
@property (nonatomic, strong) UIButton *additionalOrderButton;

/** 显示订单分类*/
@property (nonatomic, strong) OrderView *orderView;

#pragma mark - Data Propertys
// ---------------------- 数据模型 ----------------------

@end

@implementation OrderTableViewCell

/**
 *  快速  初始化 一个自定义cell
 *
 *  @param tableView
 *  @param cellID
 *
 *  @return OrderTableViewCell
 */
+ (instancetype) orderCellWithTableView:(UITableView *)tableView forCellReuseIdentifier:(NSString *)cellID {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
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
 *  @return OrderTableViewCell
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
    [self.backView addSubview:self.footerView];
    [self.backView addSubview:self.userImageView];
    [self.backView addSubview:self.userName];
    [self.backView addSubview:self.stylistId];
    [self.backView addSubview:self.status];
    [self.backView addSubview:self.orderView];
    
    [self.footerView addSubview:self.orderMoneyTitle];
    [self.footerView addSubview:self.xianView];
    [self.footerView addSubview:self.statusButton];
    [self.footerView addSubview:self.additionalOrderButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.footerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, -2, 0, -2) excludingEdge:ALEdgeTop];
    [self.footerView autoSetDimension:ALDimensionHeight toSize:70];
    
    [self.xianView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(2, 15, 0, 0) excludingEdge:ALEdgeBottom];
    [self.xianView autoSetDimension:ALDimensionHeight toSize:0.5];
    
    
    [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.userImageView autoSetDimension:ALDimensionWidth toSize:40];
    [self.userImageView autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.status autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:11];
    [self.status autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.status autoSetDimension:ALDimensionHeight toSize:18];
    [self.status autoSetDimension:ALDimensionWidth toSize:65];

    [self.orderMoneyTitle autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(10, 15, 0, 15) excludingEdge:ALEdgeBottom];
    [self.orderMoneyTitle autoSetDimension:ALDimensionHeight toSize:20];
    
    [self.statusButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.statusButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.statusButton autoSetDimension:ALDimensionHeight toSize:30];
    [self.statusButton autoSetDimension:ALDimensionWidth toSize:65];
    
    
    [self.additionalOrderButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [self.additionalOrderButton autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.statusButton withOffset:-10];
    [self.additionalOrderButton autoSetDimension:ALDimensionWidth toSize:65];
    [self.additionalOrderButton autoSetDimension:ALDimensionHeight toSize:30];
    
}

- (UIView *) backView {
    if (!_backView) {
        _backView = [[UIView alloc] initForAutoLayout];
    }
    return _backView;
}

- (UIView *) footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initForAutoLayout];
    }
    return _footerView;
}

- (UIImageView *) userImageView {
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc] initForAutoLayout];
//        _headImageVIew.contentMode          = UIViewContentModeScaleAspectFit;
        _userImageView.layer.cornerRadius   = 20;
        _userImageView.layer.masksToBounds  = YES;
    }
    return _userImageView;
}

- (UILabel *) userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.font = SWP_SYSTEM_FONT_SIZE(15);
    }
    return _userName;
}

- (UILabel *) stylistId {
    if (!_stylistId) {
        _stylistId = [[UILabel alloc] init];
        _stylistId.font = SWP_SYSTEM_FONT_SIZE(13);
        _stylistId.textColor = Color(154, 154, 154, 1);
    }
    return _stylistId;
}

- (UILabel *) status {
    if (!_status) {
        _status = [[UILabel alloc] initForAutoLayout];
        _status.font = SWP_SYSTEM_FONT_SIZE(15);
//        _status.text = @"预约成功";
        _status.textAlignment = NSTextAlignmentRight;
        _status.textColor = Color(154, 154, 154, 1);
    }
    return _status;
}

- (UILabel *) orderMoneyTitle {
    if (!_orderMoneyTitle) {
        _orderMoneyTitle = [[UILabel alloc] initForAutoLayout];
        _orderMoneyTitle.text = @"订单金额";
        _orderMoneyTitle.font = SWP_SYSTEM_FONT_SIZE(15);
    }
    return _orderMoneyTitle;
}

- (UILabel *) xianView {
    if (!_xianView) {
        _xianView = [[UILabel alloc] initForAutoLayout];
        _xianView.backgroundColor = [UIColor lightGrayColor];
        _xianView.alpha = 0.5;
    }
    return _xianView;
}
- (UIButton *) statusButton {
    if (!_statusButton) {
        _statusButton = [[UIButton alloc] initForAutoLayout];
        _statusButton.layer.borderWidth = 1;
        _statusButton.tag               = 0;
        _statusButton.layer.borderColor = [UIColor redColor].CGColor;
        _statusButton.titleLabel.font   = SWP_SYSTEM_FONT_SIZE(14);
        _statusButton.hidden            = NO;
        [_statusButton.layer setCornerRadius:2];
        [_statusButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_statusButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statusButton;
}


- (UIButton *) additionalOrderButton {
    if (!_additionalOrderButton) {
        _additionalOrderButton = [[UIButton alloc] initForAutoLayout];
        _additionalOrderButton.layer.borderWidth = 1;
        _additionalOrderButton.tag               = 1;
        _additionalOrderButton.layer.borderColor = [UIColor redColor].CGColor;
        _additionalOrderButton.titleLabel.font   = SWP_SYSTEM_FONT_SIZE(14);
        _additionalOrderButton.hidden            = YES;
        [_additionalOrderButton.layer setCornerRadius:2];
        [_additionalOrderButton setTitle:@"追加订单" forState:UIControlStateNormal];
        [_additionalOrderButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_additionalOrderButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _additionalOrderButton;
}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    if (button.tag == 0) {//tag == 0 (状态按钮：退款，查看评价 -->最右面的按钮)  tag == 1  （追加订单按钮）
        if ([self.delegate respondsToSelector:@selector(orderTableViewCell:buttonWithTitle:indexPath:)]) {
            [self.delegate orderTableViewCell:self buttonWithTitle:self.statusButton.titleLabel.text indexPath:self.index];
        }
    }else {
        NSLog(@"追加订单按钮点击事件");
        
        if (self.IsAdditionalOrderButton) {
            self.IsAdditionalOrderButton(self.index);
        }
    }
}


- (OrderView *) orderView {
    if (!_orderView) {
        _orderView = [[OrderView alloc] init];
    }
    return _orderView;
}

//status  = 7  ？  退款  ： 非退款
- (void) setDataModel:(OrderViewModel *)dataModel {
    _dataModel = dataModel;
    [self.userImageView  sd_setImageWithURL:[NSURL URLWithString:_dataModel.orderIconPhotoUrl]
                            placeholderImage:[UIImage imageNamed:@"发型缺省图"]
                                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   }];
    
    self.userName.text = _dataModel.orderName;
    CGSize userNameSize = [self uiWithConstrained:self.userName.text];
    self.userName.frame = CGRectMake(65, 15, userNameSize.width + 10, 21);

    self.stylistId.text = _dataModel.orderLeveName;
    CGSize stylistIdSize = [self uiWithConstrained:self.stylistId.text];
    self.stylistId.frame = CGRectMake(userNameSize.width + 75, 17, stylistIdSize.width, 18);
    
    self.orderMoneyTitle.text = [NSString stringWithFormat:@"订单金额￥%@",_dataModel.orderRealMoney];
    [self titleWithName:self.orderMoneyTitle.text];
    if (_dataModel.orderIsDepfund.intValue == 2) {
        self.orderMoneyTitle.text = [NSString stringWithFormat:@"订单金额￥%@(已付订金￥50)",_dataModel.orderRealMoney];
        [self titleWithNameStatusDetails:self.orderMoneyTitle.text];
    }
    
    [self uiWithUIButtonTitle:_dataModel.orderStatus.intValue isComment:[NSString stringWithFormat:@"%@", _dataModel.orderIsComment] OrderViewModel:dataModel];
    
    
    self.orderView.dataModel = _dataModel;
    if (_dataModel.orderStatus.intValue == 7) {
        self.orderView.frame = CGRectMake(0, 50, SCREEN_WIDTH, 80);
    }else {
        self.orderView.frame = CGRectMake(0, 50, SCREEN_WIDTH, _dataModel.OrderBookProducts.count * 22 + 80);
    }
}
//状态  1未支付、2支付处理中、 3支付成功、 4预约成功、 5已消费、 6订单完成、 7退款过程中、 8？
- (void) uiWithUIButtonTitle:(NSInteger)title isComment:(NSString *)isComment OrderViewModel:(OrderViewModel *)OrderViewModel {
    switch (title) {
        case 1:
            self.status.text                  = @"未支付";
            self.additionalOrderButton.hidden = YES;
            self.statusButton.hidden          = NO;
            [self.statusButton setTitle:@"去支付" forState:UIControlStateNormal];
            break;
        case 2:

            break;
        case 3:
            self.status.text                  = @"已支付";
            self.additionalOrderButton.hidden = NO;
            self.statusButton.hidden          = NO;
            [self.statusButton setTitle:@"退款" forState:UIControlStateNormal];
            break;
        case 4:
            self.status.text                  = @"预约成功";
            self.additionalOrderButton.hidden = NO;
            self.statusButton.hidden          = NO;
            [self.statusButton setTitle:@"退款" forState:UIControlStateNormal];

            break;
        case 5:
            self.status.text                  = @"已消费";
            self.additionalOrderButton.hidden = NO;
            self.statusButton.hidden          = NO;
            [self.statusButton setTitle:@"确认完成" forState:UIControlStateNormal];

            break;
        case 6:
            self.status.text = @"订单完成";
            self.statusButton.hidden          = NO;
            self.additionalOrderButton.hidden = YES;
            if (isComment.intValue == 0) {
                [self.statusButton setTitle:@"去评价" forState:UIControlStateNormal];
            }else {
                [self.statusButton setTitle:@"查看评价" forState:UIControlStateNormal];
            }
            break;
        case 7:
            if (_dataModel.orderPayRefundStatus.intValue == 1) {
                self.status.text                  = @"退款审核";
                self.statusButton.hidden          = NO;
                self.additionalOrderButton.hidden = YES;
            }
            if (_dataModel.orderPayRefundStatus.intValue == 2) {
                self.status.text                  = @"退款成功";
                self.statusButton.hidden          = YES;
                self.additionalOrderButton.hidden = YES;
            }
            if (_dataModel.orderPayRefundStatus.intValue == 3 || _dataModel.orderPayRefundStatus.intValue == 4) {
                self.status.text                  = @"退款执行";
                self.additionalOrderButton.hidden = YES;
                self.statusButton.hidden          = YES;
            }
            [self.statusButton setTitle:@"取消退款" forState:UIControlStateNormal];
            break;
        case 8:
            self.status.text                  = @"订单关闭";
            self.additionalOrderButton.hidden = YES;
            self.statusButton.hidden          = NO;
            [self.statusButton setTitle:@"重新预约" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (CGSize)uiWithConstrained:(NSString *)title {
    UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
    CGSize size = CGSizeMake(320,20);

    NSDictionary *dict = @{NSFontAttributeName : nameFnt};
    
    CGSize nameSize = [title boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    return nameSize;
}
//支付价格 -（订单状态）  //订单金额￥%@(已付订金￥50)
- (void) titleWithNameStatusDetails:(NSString *)str{
    
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:str];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor]     range:NSMakeRange(0, 4)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]       range:NSMakeRange(4, str.length - 13)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(str.length - 9, 9)];
    self.orderMoneyTitle.attributedText = hintString;
}

//文字颜色
- (void) titleWithName:(NSString *)str {
    NSString *str1 = [str componentsSeparatedByString:@"￥"][0];
    NSString *str2 = [str componentsSeparatedByString:@"￥"][1];
    NSMutableAttributedString *hintString = [[NSMutableAttributedString alloc] initWithString:str];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, str1.length)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(str1.length, str2.length + 1)];
    self.orderMoneyTitle.attributedText = hintString;
}

@end

//
//UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
//CGSize size = CGSizeMake(320,20);
//CGSize nameSize = [self.nameLable.text sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//self.nameLable.frame = CGRectMake(80, 12, nameSize.width + 10, 20);