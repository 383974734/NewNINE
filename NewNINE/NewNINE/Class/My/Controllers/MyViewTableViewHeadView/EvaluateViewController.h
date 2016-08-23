//
//  EvaluateViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 评价控制器

#import "BaseViewController.h"

@interface EvaluateViewController : BaseViewController
/** 设计师的id*/
@property (nonatomic, copy) NSString *orderStylistId;
/** 订单ID*/
@property (nonatomic, copy) NSString *orderOrderId;
/** 设计师头像*/
@property (nonatomic, copy) NSString *iconPhotoUrl;
/** 设计师名字*/
@property (nonatomic, copy) NSString *nameStr;


@end
