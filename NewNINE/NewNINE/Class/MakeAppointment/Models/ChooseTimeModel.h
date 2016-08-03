//
//  ChooseTimeModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/24.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseTimeModel : NSObject

/** time*/
@property (nonatomic, copy) NSString *chooseAppointDate;
/** id*/
@property (nonatomic, copy) NSString *chooseStylistId;


//----book/getAppointsTimes


/** appointTimes*/
@property (nonatomic, copy) NSString *chooseAppointTimes;
/** id*/
@property (nonatomic, copy) NSString *chooseStylistTimesId;
/** status*/
@property (nonatomic, copy) NSString *chooseAppointStatus;
/** stylistId*/
@property (nonatomic, copy) NSString *chooseStylistStylistId;


// -------book/getProductInfos
/** 原价格*/
@property (nonatomic, copy) NSString *originalPrice;
/** 价格*/
@property (nonatomic, copy) NSString *price;
/** 产品ID*/
@property (nonatomic, copy) NSString *productId;
/** 产品名称*/
@property (nonatomic, copy) NSString *productName;

/**
 *  快速 初始化一个 选择时间控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return ChooseTimeModel
 */
+ (instancetype) chooseTimeWithDict:(NSDictionary *)dict;


/**
 *  快速 初始化一个 时间显示控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return ChooseTimeModel
 */
+ (instancetype) appointsTimesWithDict:(NSDictionary *)dict;


/**
 *  快速 初始化一个 预约发型选择分类显示控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return ChooseTimeModel
 */
+ (instancetype) productInfosWithDict:(NSDictionary *)dict;
@end
