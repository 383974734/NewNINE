//
//  RegisterView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 注册veiw

#import <UIKit/UIKit.h>

@class RegisterView;

@protocol RegisterViewDelegate <NSObject>

@optional
/**
 *  注册页面点击代理事件
 *
 *  @param registerView       RegisterView
 *  @param btn                用来确定那个button
 *  @param telephoneNumber    账号
 *  @param verificationNumber 验证码
 *  @param password           密码
 *  @param userName           昵称
 *  @param gender             性别
 */
- (void)registerView:(RegisterView *)registerView buttonWithTag:(NSInteger)btn telephoneNumber:(NSString *)telephoneNumber verificationNumber:(NSString *)verificationNumber password:(NSString *)password userName:(NSString *)userName gender:(NSString *)gender;

@end

@interface RegisterView : UIView

@property (nonatomic, assign) id<RegisterViewDelegate> delegate;

@end
