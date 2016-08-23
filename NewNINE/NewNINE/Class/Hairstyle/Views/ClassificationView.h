//
//  ClassificationView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//发型-----------> 发型控分类view

#import <UIKit/UIKit.h>


@class ClassificationView;
@protocol ClassificationViewDelegate <NSObject>

@optional
/**
 *  点击发型分类出点的下拉列表点击代理
 *
 *  @param classificationView ClassificationView
 *  @param classification     点击后相应的文字
 *  @param classificationID   di
 */
- (void)classificationView:(ClassificationView *)classificationView didSelectRowWithClassification:(NSString *)classification classificationID:(NSString *)classificationID;

@end





@interface ClassificationView : UIView

/** 传递所选门店ID---------*/
typedef void (^ClassificationID) (NSString *strID, NSString *strName);
@property (nonatomic, strong)ClassificationID classificationID;
/** 传递所选门店ID---------*/
/** 点击隐藏区域选择控件---------*/
@property (nonatomic, copy) void (^buttonTouchUpInside)();
/** 点击隐藏区域选择控件---------*/

@property (nonatomic, copy) NSString *designerStr;
/** 发型控制器 发型分类 数据*/
@property (nonatomic, strong) NSArray *dataArray;
/** 设计师控制器 智能排序 数据*/
@property (nonatomic, strong) NSArray *designerArray;
/** 设计师控制器 全部区域 数据*/
@property (nonatomic, strong) NSArray *wholeRegionAray;

@property (nonatomic, assign) id<ClassificationViewDelegate> delegate;

@end
