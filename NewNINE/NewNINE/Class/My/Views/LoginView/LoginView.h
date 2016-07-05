//
//  LoginView.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----------> 登录veiw

#import <UIKit/UIKit.h>

@class LoginView;

@protocol LoginViewDelegate <NSObject>

@optional
/**
 *  登录页面代理事件
 *
 *  @param LoginView       LoginView
 *  @param tag             用来确定那个button
 *  @param telephoneNumber 电话号
 *  @param password        密码
 */
- (void)LoginView:(LoginView *)LoginView btnWithTag:(NSInteger)tag telephoneNumber:(NSString *)telephoneNumber password:(NSString *)password;
@end

@interface LoginView : UIView

@property (nonatomic, assign) id<LoginViewDelegate> delegete;

@end
