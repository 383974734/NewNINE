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
/** */
@property (nonatomic, copy) NSString *homeBuyCount;
/** */
@property (nonatomic, copy) NSString *homeCollectCount;
/** Cell 背景图片*/
@property (nonatomic, copy) NSString *homeHairPhotoUrl;
/** */
@property (nonatomic, copy) NSString *homeIconPhotoUrl;
/** 发型Id*/
@property (nonatomic, copy) NSString *homeID;
/** cell 图片说明*/
@property (nonatomic, copy) NSString *homeInfoDescription;
/** */
@property (nonatomic, copy) NSString *homeInfoValues;
/** */
@property (nonatomic, copy) NSString *homeIntroduce;
/** */
@property (nonatomic, copy) NSString *homeLevlNames;
/** 1、设计师  2、门店  1跳转原发型详细页面 2跳转新的发型详细页面*/
@property (nonatomic, copy) NSString *homeLinkType;
/** */
@property (nonatomic, copy) NSString *homeName;
/** */
@property (nonatomic, copy) NSString *homeStarLevel;
/** */
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
