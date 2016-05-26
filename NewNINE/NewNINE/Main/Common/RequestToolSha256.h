//
//  RequestToolSha256.h
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestToolSha256 : NSObject

+(NSString *)editPasswd:(NSString *)mobile :(NSString *)passwd :(NSString *)newpasswd;

+(NSString *)editMobile:(NSString *)mobile :(NSString *)newmobile :(NSString *)authcode :(NSString *)passwd;

+(NSString *)editUserName:(NSString *)mobile :(NSString *)username;

+ (NSString *) excellentCourseWithDict:(NSDictionary *)dict;

@end
