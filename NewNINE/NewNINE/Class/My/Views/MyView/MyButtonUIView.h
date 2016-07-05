//
//  MyButtonUIView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器 ---未付款 --预约成功 --已完成 --退款  按钮

#import <UIKit/UIKit.h>

@class MyButtonUIView;

@protocol MyButtonUIViewDelegate <NSObject>

@optional
/**
 *  我的控制器 ---未付款 --预约成功 --已完成 --退款  按钮
 *
 *  @param myButtonUIView MyButtonUIView
 *  @param tag            用来确定点击的是哪个分类
 */

/**
 *  我的控制器 ---未付款 --预约成功 --已完成 --退款  按钮
 *
 *  @param myButtonUIView MyButtonUIView
 *  @param tag            用来确定点击的是哪个分类
 *  @param name           用来区分是哪个代理    -------> 2 是 我的控制器 ---未付款 --预约成功 --已完成 --退款  按钮  代理
 */
- (void)myButtonUIView:(MyButtonUIView *)myButtonUIView buttonWithTag:(NSInteger)tag name:(NSString *)name;

@end


@interface MyButtonUIView : UIView

@property (nonatomic, assign) id <MyButtonUIViewDelegate> delegate;

- (void) setimageView:(NSString *)image lableText:(NSString *)text buttonWithTag:(NSInteger)tag;

@end
