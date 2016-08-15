//
//  PlaceOrderViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/18.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//  -----------> 提交订单、订单详情 -- 控制器

#import "BaseViewController.h"

@class  OrderViewModel;

@interface PlaceOrderViewController : BaseViewController

@property (nonatomic, strong) OrderViewModel *orderViewModel;


/** 导航名称*/
@property (nonatomic, copy) NSString         *titleString;

/** 合计金额(立减)*/
@property (nonatomic, copy) NSString         *totalString;
/** 合计金额用来积分抵扣(立减)*/
@property (nonatomic, copy) NSString         *deductibleTotalString;
/** 所选分类项目ID集合*/
@property (nonatomic, copy) NSString         *productIDString;
/** 设计师预约首页数据*/
@property (nonatomic, strong) NSDictionary   *makeAppointmentDic;
/** 选择护理类型默认数据*/
@property (nonatomic, strong) NSMutableArray *placeOrderArray;

@end
