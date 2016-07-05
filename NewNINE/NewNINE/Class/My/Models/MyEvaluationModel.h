//
//  MyEvaluationModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/17.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEvaluationModel : NSObject

/** 用户评论*/
@property (nonatomic, copy) NSDictionary *myUserComment;
/** 设计师信息*/
@property (nonatomic, copy) NSDictionary *myStylistInfo;


/**
 *  快速 初始化一个 订单控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return MyEvaluationModel
 */
+ (instancetype) myEvaluationWithDict:(NSDictionary *)dict;


@end
