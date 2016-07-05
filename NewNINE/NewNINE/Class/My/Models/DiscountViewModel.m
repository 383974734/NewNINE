//
//  DiscountViewModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "DiscountViewModel.h"

@implementation DiscountViewModel

/**
 *  快速 初始化一个 优惠劵控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DiscountViewModel.h
 */
+ (instancetype) discountWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  优惠劵控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return DiscountViewModel.h
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.discountCouponValues   = dict[@"couponValues"];
        self.discountDescription    = dict[@"description"];
        self.discountEndDate        = dict[@"endDate"];
        self.discountId             = dict[@"id"];
        self.discountName           = dict[@"name"];
        self.discountStatus         = dict[@"status"];
        self.discountStylistId      = dict[@"stylistId"];
        self.discountType           = dict[@"type"];
    }
    return self;
}


@end
