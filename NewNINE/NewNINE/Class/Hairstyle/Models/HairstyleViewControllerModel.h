//
//  HairstyleViewControllerModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/2.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  发型-----------> 发型控制器模型

#import <Foundation/Foundation.h>

@interface HairstyleViewControllerModel : NSObject
/** 收集计数*/
@property (nonatomic, copy) NSString *hairstyleCollectCount;
/** 发型照片的URL*/
@property (nonatomic, copy) NSString *hairstyleHairPhotoUrl;
/** id*/
@property (nonatomic, copy) NSString *hairstyleID;
/** 信息描述*/
@property (nonatomic, copy) NSString *hairstyleInfoDescription;
/** 判断是否是公共发型*/
@property (nonatomic, copy) NSString *hairstyleLinkType;

//----opusinfo/getOpusClass
/** 分类id*/
@property (nonatomic, copy) NSString *hairstyleClasID;
/** 分类名字*/
@property (nonatomic, copy) NSString *hairstyleClasName;
/** 分类状态*/
@property (nonatomic, copy) NSString *hairstyleClasStatus;







/**
 *  快速 初始化一个 发型控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) hairstyleWithDict:(NSDictionary *)dict;



/**
 *  快速 初始化一个 发型控制器分类模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return HomeBannerModels
 */
+ (instancetype) hairstyleClasWithDict:(NSDictionary *)dict;

@end
