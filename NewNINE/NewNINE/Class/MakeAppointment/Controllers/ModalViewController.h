//
//  ModalViewController.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/7/4.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;

@protocol ModalViewControllerDelegate <NSObject>

@optional

/**
 *  ModalViewControllerDelegate   模态视图发型选择分类代理
 *
 *  @param modalViewController ModalViewController
 *  @param didSelectStr        选择的发型分类内容
 *  @param productType         产品类型
 *  @param selectedSegmentStr  发型分类
 *  @param productId           产品id
 *  @param productName         选择产品名称产品
 */
- (void)modalViewController:(ModalViewController *)modalViewController didSelectStr:(NSString *)didSelectStr productType:(NSString *)productType selectedSegmentStr:(NSString *)selectedSegmentStr productId:(NSString *)productId productName:(NSString *)productName;

@end


@interface ModalViewController : UIViewController

@property (nonatomic, assign) id<ModalViewControllerDelegate> delegate;
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
