//
//  IntegralViewModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "IntegralViewModel.h"

@implementation IntegralViewModel

/**
 *  快速 初始化一个 积分控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return IntegralViewModel
 */
+ (instancetype) integralWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  积分控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return IntegralViewModel
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.integralBalance      = dict[@"balance"];
        self.integralCreatedDate  = dict[@"createdDate"];
        self.integralIntegral     = dict[@"integral"];
        self.integralType         = dict[@"type"];
    }
    return self;
}


@end
