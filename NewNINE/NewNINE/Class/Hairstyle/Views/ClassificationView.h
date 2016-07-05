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

@property (nonatomic, copy) NSString *designerStr;

@property (nonatomic, strong) NSArray *dataArray;
/** 设计师*/
@property (nonatomic, strong) NSArray *designerArray;

@property (nonatomic, assign) id<ClassificationViewDelegate> delegate;

@end
