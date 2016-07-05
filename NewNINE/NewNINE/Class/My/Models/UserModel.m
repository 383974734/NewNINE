//
//  UserModel.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/6/14.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//
//  -----> 用户信息数据模型

#import "UserModel.h"

@implementation UserModel

/**
 *  重写userModel 初始化方法
 *
 *  @return UserModel
 */
- (instancetype)init {
    if (self = [super init]) {
        self.userBalance = @"0";
        self.userCollecNum = @"";
        self.userCouponNum = @"0";
        self.userIconPhotoUrl = @"";
        self.userIntegral = @"0";
        self.userMobile = @"";
        self.userOrders = @"";
        self.userProxyInfoId = @"";
        self.userName = @"未登录";
    }
    return self;
}

/**
 *  单利 快速初始化一个 用户数据模型
 *
 *  @return UserModel
 */
+ (instancetype) shareInstance {
    static UserModel *user = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        user = [[self alloc]init];
    });
    return user;
}

/**
 *  快速 初始化 用户数据模型 (字典转换模型数据)
 *
 *  @param  dict
 *
 *  @return UserModel
 */
+ (instancetype) userWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

/**
 *  用户数据 字典转数据模型
 *
 *  @param  dict
 *
 *  @return UserModel
 */
- (instancetype) initWithDict:(NSDictionary *)dict {
    NSLog(@"%@", dict);
    if (self = [super init]) {
        self.userBalance        = dict[@"balance"];
        self.userCollecNum      = dict[@"collecNum"];
        self.userCouponNum      = dict[@"couponNum"];
        self.userIconPhotoUrl   = dict[@"iconPhotoUrl"];
        self.userIntegral       = dict[@"integral"];
        self.userMobile         = dict[@"mobile"];
        self.userOrders         = dict[@"orders"];
        self.userProxyInfoId    = dict[@"proxyInfoId"];
        self.userName           = dict[@"userName"];
        
    }
    return self;
}

/**
 *  保存 用户数据
 
 *
 *  @param user
 */
+ (void) saveUser:(UserModel *)user {
    
    [UserModel shareInstance].userBalance       = user.userBalance;
    [UserModel shareInstance].userCollecNum     = user.userCollecNum;
    [UserModel shareInstance].userCouponNum     = user.userCouponNum;
    [UserModel shareInstance].userIconPhotoUrl  = user.userIconPhotoUrl;
    [UserModel shareInstance].userIntegral      = user.userIntegral;
    [UserModel shareInstance].userMobile        = user.userMobile;
    [UserModel shareInstance].userOrders        = user.userOrders;
    [UserModel shareInstance].userProxyInfoId   = user.userProxyInfoId;
    [UserModel shareInstance].userName          = user.userName;
}


@end
