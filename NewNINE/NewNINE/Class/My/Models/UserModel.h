//
//  UserModel.h
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/** 用户登陆账号 */
@property (copy, nonatomic) NSString *userMobile;
/** 用户昵称 */
@property (copy, nonatomic) NSString *userName;
/** 订单 */
@property (copy, nonatomic) NSString *userOrders;
/** 优惠券 */
@property (copy, nonatomic) NSString *userCouponNum;
/** 积分 */
@property (copy, nonatomic) NSString *userIntegral;
/** 代理信息ID */
@property (copy, nonatomic) NSString *userProxyInfoId;
/** 用户头像 */
@property (copy, nonatomic) NSString *userIconPhotoUrl;
/** 收集 */
@property (copy, nonatomic) NSString *userBalance;
/** 平衡 */
@property (copy, nonatomic) NSString *userCollecNum;


@property (nonatomic,   copy) NSString *oneTitle;
@property (nonatomic,   copy) NSString *twoTitle;
@property (nonatomic,   copy) NSString *backgroundImage;
@property (nonatomic, assign) BOOL      onejudge;
@property (nonatomic, assign) BOOL      twojudge;




/**
 *  单利 快速初始化一个 用户数据模型
 *
 *  @return UserModel
 */
+ (instancetype) shareInstance;

/**
 *  快速 初始化 用户数据模型 (字典转换模型数据)
 *
 *  @param  dict
 *
 *  @return UserModel
 */
+ (instancetype) userWithDict:(NSDictionary *)dict;

/**
 *  用户数据 字典转数据模型
 *
 *  @param  dict
 *
 *  @return UserModel
 */
- (instancetype) initWithDict:(NSDictionary *)dict;

/**
 *  保存 用户数据
 *
 *  @param user
 */
+ (void) saveUser:(UserModel *)user;

@end
