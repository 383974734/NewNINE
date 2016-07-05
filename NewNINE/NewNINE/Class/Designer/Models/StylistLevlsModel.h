//
//  StylistLevlsModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
// -------- 美发师 职务接口

#import <Foundation/Foundation.h>

@interface StylistLevlsModel : NSObject

/** */
@property (nonatomic, copy) NSString *stylistLevlsID;
/** */
@property (nonatomic, copy) NSString *stylistLevlsLevlNames;
/** */
@property (nonatomic, copy) NSString *stylistLevlsLevlService;
/** */
@property (nonatomic, copy) NSString *stylistLevlsOriginalPriceMast;
/** */
@property (nonatomic, copy) NSString *stylistLevlsOriginalPriceSalev;
/** */
@property (nonatomic, copy) NSString *stylistLevlsPriceMast;
/** */
@property (nonatomic, copy) NSString *stylistLevlsPriceSalev;
/** */
@property (nonatomic, copy) NSString *stylistLevlsSqu;
/** */
@property (nonatomic, copy) NSString *stylistLevlsStatus;

/**
 *  快速 初始化一个 美发师 职务接口（字典转化数据模型）
 *
 *  @param dict
 *
 *  @return DesignerViewModel
 */
+ (instancetype) stylistLevlsWithDict:(NSDictionary *)dict;

@end
