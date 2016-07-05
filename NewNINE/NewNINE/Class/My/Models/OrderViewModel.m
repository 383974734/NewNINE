//
//  OrderViewModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "OrderViewModel.h"

@implementation OrderViewModel

/**
 *  快速 初始化一个 订单控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return OrderViewModel
 */
+ (instancetype) orderWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  订单控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return OrderViewModel
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.orderApplyDate       = dict[@"applyDate"];
        self.orderAppointTimes    = dict[@"appointTimes"];
        self.orderComboName       = dict[@"comboName"];
        self.orderComboValue      = dict[@"comboValue"];
        self.orderDepFund         = dict[@"depFund"];
        self.orderIconPhotoUrl    = dict[@"iconPhotoUrl"];
        self.orderIntegral        = dict[@"integral"];
        self.orderIntegralMoney   = dict[@"integralMoney"];
        self.orderIsComment       = dict[@"isComment"];
        self.orderIsCoupon        = dict[@"isCoupon"];
        self.orderIsDepfund       = dict[@"isDepfund"];
        self.orderLeveName        = dict[@"leveName"];
        self.orderName            = dict[@"name"];
        self.orderOrderId         = dict[@"orderId"];
        self.orderOrderMoney      = dict[@"orderMoney"];
        self.orderOrderNumb       = dict[@"orderNumb"];
        self.orderPayMoney        = dict[@"payMoney"];
        self.orderPayRefundStatus = dict[@"refundStatus"];
        self.orderRealMoney       = dict[@"realMoney"];
        self.orderStatus          = dict[@"status"];
        self.orderStylistId       = dict[@"stylistId"];
        self.orderUserCouponId    = dict[@"userCouponId"];
        self.orderUserName        = dict[@"userCouponName"];
        self.orderUserName        = dict[@"userName"];
        self.Orderstudio          = dict[@"studio"];
        self.OrderBookProducts    = dict[@"bookProducts"];
        
    }
    return self;
}




@end
