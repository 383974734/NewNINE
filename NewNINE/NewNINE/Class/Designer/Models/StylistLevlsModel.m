//
//  StylistLevlsModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
// -------- 美发师 职务接口

#import "StylistLevlsModel.h"

@implementation StylistLevlsModel

/**
 *  快速 初始化一个 美发师 职务接口（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
+ (instancetype) stylistLevlsWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  美发师 职务接口（字典转数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.stylistLevlsID = dict[@"id"];
        self.stylistLevlsLevlNames = dict[@"levlNames"];
        self.stylistLevlsLevlService = dict[@"levlService"];
        self.stylistLevlsOriginalPriceMast = dict[@"originalPriceMast"];
        self.stylistLevlsOriginalPriceSalev = dict[@"originalPriceSalev"];
        self.stylistLevlsPriceMast = dict[@"priceMast"];
        self.stylistLevlsPriceSalev = dict[@"priceSalev"];
        self.stylistLevlsSqu = dict[@"squ"];
        self.stylistLevlsStatus = dict[@"status"];
    }
    return self;
}

@end
