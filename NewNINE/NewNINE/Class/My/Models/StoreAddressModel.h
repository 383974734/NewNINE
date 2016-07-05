//
//  StoreAddressModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreAddressModel : NSObject

/** 地址*/
@property (nonatomic, copy) NSString *storeAddressAddr;
/** 城市*/
@property (nonatomic, copy) NSString *storeAddressCity;
/** id*/
@property (nonatomic, copy) NSString *storeAddressId;
/** 名称*/
@property (nonatomic, copy) NSString *storeAddressNames;
/** 电话*/
@property (nonatomic, copy) NSString *storeAddressPhone;
/** 图片*/
@property (nonatomic, copy) NSString *storeAddressPhotoUrl;
/** 商店地区*/
@property (nonatomic, copy) NSString *storeAddressShopDistrict;
/** 状态*/
@property (nonatomic, copy) NSString *storeAddressStatus;



/**
 *  快速 初始化一个 优惠劵控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return StoreAddressModel
 */
+ (instancetype) storeAddressWithDict:(NSDictionary *)dict;
@end
