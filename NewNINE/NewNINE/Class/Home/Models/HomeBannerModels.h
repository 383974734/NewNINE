//
//  HomeBannerModels.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/27.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeBannerModels : NSObject

//头部轮播
//------------------------------------------
/** 头部轮播图片*/
@property (nonatomic, copy) NSString *homeActivityBanner;
/** 头部轮播图片点击详情url*/
@property (nonatomic, copy) NSString *homeActUrlBanner;

//明星轮播
//------------------------------------------
/** 明星轮播图片id*/
@property (nonatomic, copy) NSString *homeStarID;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeStarPhotoUrl;

//首页cell
//------------------------------------------
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeBuyCount;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeCollectCount;
/** Cell 背景图片*/
@property (nonatomic, copy) NSString *homeHairPhotoUrl;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeIconPhotoUrl;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeID;
/** cell 图片说明*/
@property (nonatomic, copy) NSString *homeInfoDescription;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeInfoValues;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeIntroduce;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeLevlNames;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeLinkType;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeName;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeStarLevel;
/** 明星轮播图片*/
@property (nonatomic, copy) NSString *homeStylistId;

/**
 *  快速 初始化一个 （字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) homeBannerWithDict:(NSDictionary *)dict;

/**
 *  快速 初始化一个 明星轮播（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) homeStarBannerWithDict:(NSDictionary *)dict;

/**
 *  快速 初始化一个 首页cell数据（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) homecellWithDict:(NSDictionary *)dict;
@end
