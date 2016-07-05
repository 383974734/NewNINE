//
//  DiscountViewModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountViewModel : NSObject

/** 票面价值*/
@property (nonatomic, copy) NSString *discountCouponValues;
/** 描述*/
@property (nonatomic, copy) NSString *discountDescription;
/** 结束日期*/
@property (nonatomic, copy) NSString *discountEndDate;
/** id*/
@property (nonatomic, copy) NSString *discountId;
/** 名称*/
@property (nonatomic, copy) NSString *discountName;
/** 地位*/
@property (nonatomic, copy) NSString *discountStatus;
/** 设计师的id*/
@property (nonatomic, copy) NSString *discountStylistId;
/** 类型*/
@property (nonatomic, copy) NSString *discountType;

/**
 *  快速 初始化一个 优惠劵控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DiscountViewModel.h
 */
+ (instancetype) discountWithDict:(NSDictionary *)dict;
@end
