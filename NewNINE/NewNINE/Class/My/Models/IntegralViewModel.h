//
//  IntegralViewModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/15.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralViewModel : NSObject

/** 剩余积分数*/
@property (nonatomic, copy) NSString *integralBalance;
/** 创建日期*/
@property (nonatomic, copy) NSString *integralCreatedDate;
/** 积分*/
@property (nonatomic, copy) NSString *integralIntegral;
/** 类型*/
@property (nonatomic, copy) NSString *integralType;



/**
 *  快速 初始化一个 积分控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return IntegralViewModel
 */
+ (instancetype) integralWithDict:(NSDictionary *)dict ;
@end
