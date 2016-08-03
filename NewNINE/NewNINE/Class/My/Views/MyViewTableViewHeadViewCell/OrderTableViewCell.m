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
/** 订单金额*/
@property (nonatomic, strong) UILabel *orderMoney;
/** 状态按钮*/
@property (nonatomic, strong) UIButton *statusButton;

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
    [self.footerView addSubview:self.orderMoney];
    [self.footerView addSubview:self.statusButton];
}

/**
 * 系统方法 设置控件位置
 */
- (void) layoutSubviews {
    [super layoutSubviews];
    
    [self.backView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
    
    [self.footerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
    [self.footerView autoSetDimension:ALDimensionHeight toSize:50];
    
    [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.userImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.userImageView autoSetDimension:ALDimensionWidth toSize:40];
    [self.userImageView autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.status autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:11];
    [self.status autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.status autoSetDimension:ALDimensionHeight toSize:18];
    [self.status autoSetDimension:ALDimensionWidth toSize:60];

    [self.orderMoneyTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:15];
    [self.orderMoneyTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.orderMoneyTitle autoSetDimension:ALDimensionHeight toSize:24];
    [self.orderMoneyTitle autoSetDimension:ALDimensionWidth toSize:70];
    
    [self.statusButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(12, 0, 12, 15) excludingEdge:ALEdgeLeft];
    [self.statusButton autoSetDimension:ALDimensionWidth toSize:84];
    
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
        _orderMoneyTitle.font = SWP_SYSTEM_FONT_SIZE(17);
    }
    return _orderMoneyTitle;
}

- (UILabel *) orderMoney {
    if (!_orderMoney) {
        _orderMoney = [[UILabel alloc] initWithFrame:CGRectMake(90, 11, 70, 24)];
        _orderMoney.textColor = [UIColor redColor];
    }
    return _orderMoney;
}
- (UIButton *) statusButton {
    if (!_statusButton) {
        _statusButton = [[UIButton alloc] initForAutoLayout];
        _statusButton.layer.borderWidth = 1;
        _statusButton.layer.borderColor = [UIColor redColor].CGColor;
        _statusButton.titleLabel.font   = SWP_SYSTEM_FONT_SIZE(14);
        [_statusButton.layer setCornerRadius:4];
        [_statusButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_statusButton addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statusButton;
}

#pragma mark - 所有控件的点击事件
/**
 *  UIButton 点击事件
 *
 *  @param button UIButton
 */
- (void) didButton:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(orderTableViewCell:buttonWithTitle:indexPath:)]) {
        [self.delegate orderTableViewCell:self buttonWithTitle:self.statusButton.titleLabel.text indexPath:self.index];
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
    
//    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:_dataModel.orderIconPhotoUrl] placeholderImage:[UIImage imageNamed:@"发型缺省图"]];
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
    
    self.orderMoney.text = [NSString stringWithFormat:@"￥%@",_dataModel.orderPayMoney];
    CGSize orderMoneySize = [self uiWithConstrained:self.orderMoney.text];
    self.orderMoney.frame = CGRectMake(90, 11, orderMoneySize.width + 10, 24);
    
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
            self.status.text = @"未支付";
            [self.statusButton setTitle:@"去支付" forState:UIControlStateNormal];
            break;
        case 2:

            break;
        case 3:
            self.status.text = @"已支付";
            [self.statusButton setTitle:@"退款" forState:UIControlStateNormal];

            break;
        case 4:
            self.status.text = @"预约成功";
            [self.statusButton setTitle:@"退款" forState:UIControlStateNormal];

            break;
        case 5:
            self.status.text = @"已消费";
            [self.statusButton setTitle:@"确认完成" forState:UIControlStateNormal];

            break;
        case 6:
            self.status.text = @"订单完成";
            if (isComment.intValue == 0) {
                [self.statusButton setTitle:@"去评价" forState:UIControlStateNormal];
            }else {
                [self.statusButton setTitle:@"查看评价" forState:UIControlStateNormal];
            }
            break;
        case 7:
            if (_dataModel.orderPayRefundStatus.intValue == 1) {
                self.status.text = @"退款审核";
            }
            if (_dataModel.orderPayRefundStatus.intValue == 2) {
                self.status.text = @"退款成功";
            }
            if (_dataModel.orderPayRefundStatus.intValue == 3 || _dataModel.orderPayRefundStatus.intValue == 4) {
                self.status.text = @"退款执行";
            }
            [self.statusButton setTitle:@"取消退款" forState:UIControlStateNormal];
            break;
        case 8:
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

@end

//
//UIFont *nameFnt = [UIFont fontWithName:@"Arial" size:15];
//CGSize size = CGSizeMake(320,20);
//CGSize nameSize = [self.nameLable.text sizeWithFont:nameFnt constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//self.nameLable.frame = CGRectMake(80, 12, nameSize.width + 10, 20);