//
//  MyNumberView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/7.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 我的控制器 ---收藏 --积分 --优惠卷

#import <UIKit/UIKit.h>

@class MyNumberView;

@protocol MyNumberViewDelegate <NSObject>

@optional

/**
 *  我的控制器 ---收藏 --积分 --优惠卷
 *
 *  @param myNumberView MyNumberView
 *  @param tag          用来确定点击的是哪个分类
 *  @param name         用来区分是哪个代理    -------> 1 是 我的控制器 ---收藏 --积分 --优惠卷  代理
 */
- (void)myNumberView:(MyNumberView *)myNumberView buttonWithTag:(NSInteger)tag name:(NSString *)name;

@end

@interface MyNumberView : UIView
@property (nonatomic, assign) id<MyNumberViewDelegate> delegate;

- (void) setImageView:(NSString *)image nameText:(NSString *)name numberText:(NSString *)number imageLandRWithHidden:(BOOL)hidden tag:(NSInteger)tag;

- (void) setWithNumber:(NSString *)number;
@end
