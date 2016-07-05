//
//  MyEvaluationModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/17.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MyEvaluationModel.h"

@implementation MyEvaluationModel


/**
 *  快速 初始化一个 订单控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return MyEvaluationModel
 */
+ (instancetype) myEvaluationWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  订单控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return MyEvaluationModel
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.myUserComment = dict[@"userComment"];
        self.myStylistInfo = dict[@"stylistInfo"];
    }
    return self;
}



@end
