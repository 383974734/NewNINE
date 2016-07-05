//
//  DesignerViewModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/8.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
// 美发师数据接口moel

#import <Foundation/Foundation.h>

@interface DesignerViewModel : NSObject
/** 美单数*/
@property (nonatomic, copy) NSString *designerBought;
/** 收藏数*/
@property (nonatomic, copy) NSString *designerCollected;
/** 设计师头像*/
@property (nonatomic, copy) NSString *designerIconPhotoUrl;
/** id*/
@property (nonatomic, copy) NSString *designerId;
/** 设计师签名*/
@property (nonatomic, copy) NSString *designerIntroduce;
/** 设计师级别*/
@property (nonatomic, copy) NSString *designerLeveName;
/** 设计师名字*/
@property (nonatomic, copy) NSString *designerName;
/** 图片一*/
@property (nonatomic, copy) NSString *designerPhotoOne;
/** 图片二*/
@property (nonatomic, copy) NSString *designerPhotoThr;
/** 图片三*/
@property (nonatomic, copy) NSString *designerPhotoTwo;
/** 价钱*/
@property (nonatomic, copy) NSString *designerPriceMast;
/** */
@property (nonatomic, copy) NSString *designerStarLevel;

/**
 *  快速 初始化一个 美发师数据接口moel（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
+ (instancetype) designerWithDict:(NSDictionary *)dict;


/**
 *  快速 初始化一个 设计师数据接口moel（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
+ (instancetype) designerCollectionWithDict:(NSDictionary *)dict;

@end
