//
//  OrderViewModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderViewModel : NSObject

/** 申请时间*/
@property (nonatomic, copy) NSString *orderApplyDate;
/** 指定时间*/
@property (nonatomic, copy) NSString *orderAppointTimes;
/** 组合的名字*/
@property (nonatomic, copy) NSString *orderComboName;
/** 组合价值*/
@property (nonatomic, copy) NSString *orderComboValue;
/** DEP基金*/
@property (nonatomic, copy) NSString *orderDepFund;
/** 图标图片的地址*/
@property (nonatomic, copy) NSString *orderIconPhotoUrl;
/** 积分*/
@property (nonatomic, copy) NSString *orderIntegral;
/** 积分的钱*/
@property (nonatomic, copy) NSString *orderIntegralMoney;
/** 正在评论*/
@property (nonatomic, copy) NSString *orderIsComment;
/** 优惠券*/
@property (nonatomic, copy) NSString *orderIsCoupon;
/** 基金*/
@property (nonatomic, copy) NSString *orderIsDepfund;
/** 标准名称*/
@property (nonatomic, copy) NSString *orderLeveName;
/** 名称*/
@property (nonatomic, copy) NSString *orderName;
/** 订单ID*/
@property (nonatomic, copy) NSString *orderOrderId;
/** 订单钱*/
@property (nonatomic, copy) NSString *orderOrderMoney;
/** 订单号*/
@property (nonatomic, copy) NSString *orderOrderNumb;
/** 预付钱*/
@property (nonatomic, copy) NSString *orderPayMoney;
/** 退款状态*/
@property (nonatomic, copy) NSString *orderPayRefundStatus;
/** 真正的钱*/
@property (nonatomic, copy) NSString *orderRealMoney;
/** 状态  1未支付、2支付处理中、 3支付成功、 4预约成功、 5已消费、 6订单完成、 7退款过程中、 8？*/
@property (nonatomic, copy) NSString *orderStatus;
/** 设计师的id*/
@property (nonatomic, copy) NSString *orderStylistId;
/** 用户优惠券ID*/
@property (nonatomic, copy) NSString *orderUserCouponId;
/** 使用优惠券的名字*/
@property (nonatomic, copy) NSString *orderUserCouponName;
/** 用户名称*/
@property (nonatomic, copy) NSString *orderUserName;
/** 产品  --> productType (//1-烫发  2-染发 3－护理 4、养发 5、洗剪吹 6、洗吹) */
@property (nonatomic, copy) NSArray *OrderBookProducts;
/** 工作室*/
@property (nonatomic, copy) NSDictionary *Orderstudio;





/**
 *  快速 初始化一个 订单控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return OrderViewModel
 */
+ (instancetype) orderWithDict:(NSDictionary *)dict;

@end
