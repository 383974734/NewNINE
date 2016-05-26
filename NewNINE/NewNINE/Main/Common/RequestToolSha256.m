//
//  RequestToolSha256.m
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/13.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "RequestToolSha256.h"
#import<CommonCrypto/CommonDigest.h>

@implementation RequestToolSha256
//接口传值位置
//-------------------------------------------------------------------------------------------------------

+ (NSString *) excellentCourseWithDict:(NSDictionary *)dict {
    NSString *param = [NSString stringWithFormat:
                       @"mobile=%@&"
                       @"passwd=%@&"
                       @"newpasswd=%@"
                       ,dict[@"mobile"],dict[@"passwd"],dict[@"newpasswd"]];
    return [self contentStr:param];
}



+(NSString *)editPasswd:(NSString *)mobile
                 :(NSString *)passwd
                 :(NSString *)newpasswd
{
    NSString *param = [NSString stringWithFormat:
                       @"mobile=%@&"
                       @"passwd=%@&"
                       @"newpasswd=%@"
                       ,mobile,passwd,newpasswd];
    return [self contentStr:param];
}

+(NSString *)editMobile:(NSString *)mobile
                 :(NSString *)newmobile
                 :(NSString *)authcode
                 :(NSString *)passwd
{
    NSString *param = [NSString stringWithFormat:
                       @"mobile=%@&"
                       @"newmobile=%@&"
                       @"authcode=%@&"
                       @"passwd=%@"
                       ,mobile,newmobile,authcode,passwd];
    return [self contentStr:param];
}


+(NSString *)editUserName:(NSString *)mobile
                   :(NSString *)username
{
    NSString *param = [NSString stringWithFormat:
                       @"mobile=%@&"
                       @"username=%@"
                       ,mobile,username];
    return [self contentStr:param];
}




















//-------------------------------------------------------------------------------------------------------
//接口传值位置

#pragma mark - sha256
// 这里以下不要动

+ (NSString *) contentStr:(NSString *)param {
    NSString *content = [NSString stringWithFormat:@"%@&key=3e9bb86c6980c3b79e5b936ce10b9b96",param];
    
    return [self sha256:content];
}

+ (NSString*) sha256:(NSString *)content
{
    const char *cstr = [content cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = nil ; //[NSData dataWithBytes:cstr length:content.length];

    data = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
