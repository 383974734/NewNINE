//
//  OrderView.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/17.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "OrderView.h"

#import "OrderViewModel.h"


@interface OrderView ()
/** 订单号name*/
@property (nonatomic, strong) UILabel *orderName;
/** 日期name*/
@property (nonatomic, strong) UILabel *dateName;
/** 金额name*/
@property (nonatomic, strong) UILabel *moneyName;
/** 订单号*/
@property (nonatomic, strong) UILabel *orderNameTitle;
/** 日期*/
@property (nonatomic, strong) UILabel *dateNameTitle;
/** 金额*/
@property (nonatomic, strong) UILabel *moneyNameTitle;

@end

@implementation OrderView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self addUI];
        [self settingAutoLayout];
        [self settingData];
    }
    return self;
}

- (void)addUI {
    [self addSubview:self.orderName];
    [self addSubview:self.dateName];
    [self addSubview:self.moneyName];
    [self addSubview:self.orderNameTitle];
    [self addSubview:self.dateNameTitle];
    [self addSubview:self.moneyNameTitle];
}

- (void)settingAutoLayout {
    [self.orderName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.orderName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.orderName autoSetDimension:ALDimensionWidth toSize:80];
    [self.orderName autoSetDimension:ALDimensionHeight toSize:21];
    
    [self.orderNameTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:8];
    [self.orderNameTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.orderNameTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.orderName withOffset:5];
    [self.orderNameTitle autoSetDimension:ALDimensionHeight toSize:21];

    [self.dateName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.orderName withOffset:0];
    [self.dateName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.dateName autoSetDimension:ALDimensionWidth toSize:80];
    [self.dateName autoSetDimension:ALDimensionHeight toSize:21];
    
    [self.dateNameTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.orderNameTitle withOffset:0];
    [self.dateNameTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.dateNameTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.dateName withOffset:5];
    [self.dateNameTitle autoSetDimension:ALDimensionHeight toSize:21];
    
    [self.moneyName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateName withOffset:0];
    [self.moneyName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [self.moneyName autoSetDimension:ALDimensionWidth toSize:80];
    [self.moneyName autoSetDimension:ALDimensionHeight toSize:21];
    
    [self.moneyNameTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateNameTitle withOffset:0];
    [self.moneyNameTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [self.moneyNameTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.dateName withOffset:5];
    [self.moneyNameTitle autoSetDimension:ALDimensionHeight toSize:21];
}

- (void)settingData {
    
}


- (UILabel *) orderName {
    if (!_orderName) {
        _orderName = [[UILabel alloc] initForAutoLayout];
        _orderName.textColor = Color(154, 154, 154, 1);
        _orderName.font = SWP_SYSTEM_FONT_SIZE(15);
        _orderName.text = @"订单编号:";
    }
    return _orderName;
}
- (UILabel *) dateName {
    if (!_dateName) {
        _dateName = [[UILabel alloc] initForAutoLayout];
        _dateName.textColor = Color(154, 154, 154, 1);
        _dateName.font = SWP_SYSTEM_FONT_SIZE(15);
        _dateName.text = @"申请日期";
    }
    return _dateName;
}
- (UILabel *) moneyName {
    if (!_moneyName) {
        _moneyName = [[UILabel alloc] initForAutoLayout];
        _moneyName.textColor = Color(154, 154, 154, 1);
        _moneyName.font = SWP_SYSTEM_FONT_SIZE(15);
        _moneyName.text = @"退款金额";
    }
    return _moneyName;
}
- (UILabel *) orderNameTitle {
    if (!_orderNameTitle) {
        _orderNameTitle = [[UILabel alloc] initForAutoLayout];
        _orderNameTitle.textAlignment = NSTextAlignmentRight;
        _orderNameTitle.textColor = Color(154, 154, 154, 1);
        _orderNameTitle.font = SWP_SYSTEM_FONT_SIZE(15);
    }
    return _orderNameTitle;
}
- (UILabel *) dateNameTitle {
    if (!_dateNameTitle) {
        _dateNameTitle = [[UILabel alloc] initForAutoLayout];
        _dateNameTitle.textAlignment = NSTextAlignmentRight;
        _dateNameTitle.textColor = Color(154, 154, 154, 1);
        _dateNameTitle.font = SWP_SYSTEM_FONT_SIZE(15);
    }
    return _dateNameTitle;
}
- (UILabel *) moneyNameTitle {
    if (!_moneyNameTitle) {
        _moneyNameTitle = [[UILabel alloc] initForAutoLayout];
        _moneyNameTitle.textAlignment = NSTextAlignmentRight;
        _moneyNameTitle.textColor = Color(154, 154, 154, 1);
        _moneyNameTitle.font = SWP_SYSTEM_FONT_SIZE(15);
    }
    return _moneyNameTitle;
}


- (void) setDataModel:(OrderViewModel *)dataModel {
    _dataModel = dataModel;

     [[self viewWithTag:10011] removeFromSuperview ];
     [[self viewWithTag:10022] removeFromSuperview ];
    
    
    for (UIView *view in self.subviews) {
        if (view.tag >= 10000 && [view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    if (_dataModel.orderStatus.intValue == 7) {
        _orderName.text = @"订单编号:";
        _dateName.text  = @"申请日期";
        _moneyName.text = @"退款金额";
        _orderNameTitle.text = _dataModel.orderOrderNumb;
        _dateNameTitle.text  = _dataModel.orderApplyDate;
        _moneyNameTitle.text = [NSString stringWithFormat:@"￥%@", _dataModel.orderRealMoney];
    }else {
        _orderName.text = @"订单编号:";
        _dateName.text  = @"预约时间";
        _moneyName.text = @"服务地址";
        _orderNameTitle.text = _dataModel.orderOrderNumb;
        _dateNameTitle.text  = _dataModel.orderAppointTimes;
        _moneyNameTitle.text = [_dataModel.Orderstudio objectForKey:@"addr"];

        if (_dataModel.OrderBookProducts.count > 0) {
            
            for (int i = 0; _dataModel.OrderBookProducts.count > i; i++) {
                UILabel *name  = [[UILabel alloc] initWithFrame:CGRectMake(15, (i * 21) + 71, SCREEN_WIDTH - 120, 21)];
                name.textColor = Color(154, 154, 154, 1);
                name.tag       = 10010 + i;
                name.font      = SWP_SYSTEM_FONT_SIZE(15);
                name.text      = [_dataModel.OrderBookProducts[i] objectForKey:@"productName"];
                
                UILabel *nameTitle  = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, (i * 21) + 71, 105, 21)];
                nameTitle.textColor = Color(154, 154, 154, 1);
                nameTitle.tag       = 10020 + i;
                nameTitle.font      = SWP_SYSTEM_FONT_SIZE(15);
                nameTitle.text      = [NSString stringWithFormat:@"￥%@", [_dataModel.OrderBookProducts[i] objectForKey:@"price"]];
                nameTitle.textAlignment = NSTextAlignmentRight;
                [self addSubview:name];
                [self addSubview:nameTitle];
            }
        }
    }
}

@end
