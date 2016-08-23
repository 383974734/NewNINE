//
//  DesignerHeadView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 设计师控制器 导航

#import <UIKit/UIKit.h>

@class DesignerHeadView;

@protocol DesignerHeadViewDelegate <NSObject>

@optional
/**
 *  设计师控制器 导航点击不同的按钮 响应不同的事件
 *
 *  @param designerHeadView designerHeadView
 *  @param btn              点击的button
 */
- (void)designerHeadView:(DesignerHeadView *)designerHeadView buttonWithTag:(UIButton *)btn;

@end

@interface DesignerHeadView : UIView

/** 当前选择的城市 */
@property (nonatomic, copy) NSString *strCity;
/** 当前选择的全部区域str */
@property (nonatomic, copy) NSString *followStr;
/** 当前选择的排序str */
@property (nonatomic, copy) NSString *timeStr;
/** 当前选择的筛选str */
@property (nonatomic, copy) NSString *classificationStr;

@property (nonatomic ,assign)id<DesignerHeadViewDelegate> delegate;

@end
