//
//  DesignerViewModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/8.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "DesignerViewModel.h"

@implementation DesignerViewModel

/**
 *  快速 初始化一个 美发师数据接口moel（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
+ (instancetype) designerWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithBannerDic:dict];
}

/**
 *  美发师数据接口moel（字典转数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
- (instancetype) initWithBannerDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.designerBought = dict[@"bought"];
        self.designerCollected = dict[@"collected"];
        self.designerIconPhotoUrl = dict[@"iconPhotoUrl"];
        self.designerId = dict[@"id"];
        self.designerIntroduce = dict[@"introduce"];
        self.designerLeveName = dict[@"leveName"];
        self.designerName = dict[@"name"];
        self.designerPhotoOne = dict[@"photoOne"];
        self.designerPhotoTwo = dict[@"photoTwo"];
        self.designerPhotoThr = dict[@"photoThr"];
        self.designerPriceMast = dict[@"priceMast"];
        self.designerStarLevel = dict[@"starLevel"];
    }
    return self;
}



/**
 *  快速 初始化一个 设计师数据接口moel（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
+ (instancetype) designerCollectionWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDesignerCollectionDic:dict];
}

/**
 *  设计师数据接口moel（字典转数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
- (instancetype) initWithDesignerCollectionDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.designerBought         = dict[@"bought"];
        self.designerCollected      = dict[@"collected"];
        self.designerIconPhotoUrl   = dict[@"iconPhotoUrl"];
        self.designerId             = dict[@"id"];
        self.designerIntroduce      = dict[@"introduce"];
        self.designerLeveName       = dict[@"leveName"];
        self.designerName           = dict[@"name"];
        self.designerPriceMast      = dict[@"priceMast"];
        self.designerStarLevel      = dict[@"starLevel"];
    }
    return self;
}

@end
