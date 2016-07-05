//
//  StoreAddressModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/16.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "StoreAddressModel.h"

@implementation StoreAddressModel

/**
 *  快速 初始化一个 优惠劵控制器模型（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return StoreAddressModel
 */
+ (instancetype) storeAddressWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  优惠劵控制器模型（字典转数据模型）
 *
 *  @param dict
 *
 *  @return StoreAddressModel
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.storeAddressAddr           = dict[@"addr"];
        self.storeAddressCity           = dict[@"city"];
        self.storeAddressId             = dict[@"id"];
        self.storeAddressNames          = dict[@"names"];
        self.storeAddressPhone          = dict[@"phone"];
        self.storeAddressPhotoUrl       = dict[@"photoUrl"];
        self.storeAddressShopDistrict   = dict[@"shopDistrict"];
        self.storeAddressStatus         = dict[@"status"];
    }
    return self;
}


@end
