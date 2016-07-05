//
//  HomeBannerModels.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/27.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "HomeBannerModels.h"

@implementation HomeBannerModels

/**
 *  快速 初始化一个 头部轮播（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) homeBannerWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  首页列表头部轮播数据模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.homeActivityBanner = dict[@"activityBanner"];
        self.homeActUrlBanner   = dict[@"actUrl"];
    }
    return self;
}


/**
 *  快速 初始化一个 明星轮播（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) homeStarBannerWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithStarBannerDic:dict];
}

/**
 *  首页明星轮播数据模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
- (instancetype) initWithStarBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.homeStarID         = dict[@"id"];
        self.homeStarPhotoUrl   = dict[@"photoUrl"];
    }
    return self;
}

/**
 *  快速 初始化一个 首页cell数据（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) homecellWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithCellDic:dict];
}

/**
 *  首页cell数据模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
- (instancetype) initWithCellDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.homeBuyCount = dict[@"buyCount"];
        self.homeCollectCount = dict[@"collectCount"];
        self.homeHairPhotoUrl = dict[@"hairPhotoUrl"];
        self.homeIconPhotoUrl = dict[@"iconPhotoUrl"];
        self.homeID = dict[@"id"];
        self.homeInfoDescription = dict[@"infoDescription"];
        self.homeInfoValues = dict[@"infoValues"];
        self.homeIntroduce = dict[@"introduce"];
        self.homeLevlNames = dict[@"levlNames"];
        self.homeLinkType = dict[@"linkType"];
        self.homeName = dict[@"name"];
        self.homeStarLevel = dict[@"starLevel"];
        self.homeStylistId = dict[@"stylistId"];
    }
    return self;
}


@end
