//
//  ServiceClassificationViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/8/9.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 预约美发服务分类控制器

#import "BaseViewController.h"


@class ServiceClassificationViewController;

@protocol ServiceClassificationViewControllerDelegate <NSObject>

@optional

/**
 *  ServiceClassificationViewController        发型选择分类代理
 *
 *  @param serviceClassificationViewController ServiceClassificationViewController
 *  @param productSelectArray                  记录所有被选择的发型分类名称-长短-价钱
 *  @param productType                         产品类型 1-烫发 2-染发 3－护理 4- 养发 7-洗色 8- 接发
 *  @param selectedSegmentStr                  记录发型长中短分类
 *  @param productArrayArrayId                 产品ID数组
 *  @param productName                         选择产品名称产品
 *  @param productArrayMoney                   产品价钱数组
 */
- (void)serviceClassificationViewController:(ServiceClassificationViewController *)serviceClassificationViewController productSelectArray:(NSMutableArray *)productSelectArray productType:(NSString *)productType selectedSegmentStr:(NSString *)selectedSegmentStr productArrayArrayId:(NSArray *)productArrayArrayId productName:(NSString *)productName productArrayMoney:(NSMutableArray *)productArrayMoney;

@end


@interface ServiceClassificationViewController : BaseViewController
@property (nonatomic, assign) id<ServiceClassificationViewControllerDelegate> delegate;
/** 导航文字*/
@property (nonatomic, copy) NSString *titleName;
/** 所选择的产品类型*/
@property (nonatomic, copy) NSString *productTypeName;
/** 产品ID*/
@property (nonatomic, copy) NSString *productId;
/** 设计师ID*/
@property (nonatomic, copy) NSString *stylistinfoId;
/** 产品类型 1-烫发 2-染发 3－护理 4- 养发*/
@property (nonatomic, copy) NSString *productType;
/** 发型分类 11烫发（长发） 12烫发（中发）13(短发) 21染发（长） 22染发（中） 23染发（短） 31、护理 41、养发*/
@property (nonatomic, copy) NSString *productClas;
/** 发型分类按钮是否显示*/
@property (nonatomic, getter=isProductClasBtn) BOOL  productClasBtn;

@end
