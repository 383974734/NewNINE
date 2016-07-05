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

@property (nonatomic, copy) NSString *strCity;

@property (nonatomic ,assign)id<DesignerHeadViewDelegate> delegate;

@end
