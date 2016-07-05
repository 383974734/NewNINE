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
@end
