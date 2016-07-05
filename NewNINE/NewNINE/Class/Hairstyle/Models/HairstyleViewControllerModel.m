//
//  HairstyleViewControllerModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/2.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  发型-----------> 发型控制器模型

#import "HairstyleViewControllerModel.h"

@implementation HairstyleViewControllerModel

/**
 *  快速 初始化一个 发型控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) hairstyleWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  发型控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.hairstyleCollectCount      = dict[@"collectCount"];
        self.hairstyleHairPhotoUrl      = dict[@"hairPhotoUrl"];
        self.hairstyleID                = dict[@"id"];
        self.hairstyleInfoDescription   = dict[@"infoDescription"];
        self.hairstyleLinkType          = dict[@"linkType"];
    }
    return self;
}

/**
 *  快速 初始化一个 发型控制器分类模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) hairstyleClasWithDict:(NSDictionary *)dict {
    return [[self alloc] initHairstyleClasWithBannerDic:dict];
}

/**
 *  发型控制器分类模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
- (instancetype) initHairstyleClasWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.hairstyleClasID      = dict[@"id"];
        self.hairstyleClasName    = dict[@"clasName"];
        self.hairstyleClasStatus  = dict[@"status"];

    }
    return self;
}


@end
