//
//  ChooseTimeModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/24.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "ChooseTimeModel.h"

@implementation ChooseTimeModel


/**
 *  快速 初始化一个 选择时间控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return ChooseTimeModel
 */
+ (instancetype) chooseTimeWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  选择时间控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return ChooseTimeModel
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.chooseStylistId        = dict[@"stylistId"];
        self.chooseAppointDate      = dict[@"appointDate"];
    }
    return self;
}


/**
 *  快速 初始化一个 时间显示控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return ChooseTimeModel
 */
+ (instancetype) appointsTimesWithDict:(NSDictionary *)dict {
    return [[self alloc] initAppointsTimesWithBannerDic:dict];
}

/**
 *  选择时间显示控制器模型控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return ChooseTimeModel
 */
- (instancetype) initAppointsTimesWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.chooseAppointTimes        = dict[@"appointTimes"];
        self.chooseStylistTimesId      = dict[@"id"];
        self.chooseAppointStatus       = dict[@"status"];
        self.chooseStylistStylistId    = dict[@"stylistId"];
    }
    return self;
}


@end
