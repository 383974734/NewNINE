//
//  AppDelegate.m
//  NewNINE
//
//  Created by yinduo-zdy on 16/5/26.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "AppDelegate.h"
// ---------------------- 框架工具类 ----------------------
#import "TabBarViewController.h"
// 友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"       // 微信
#import "UMSocialSinaSSOHandler.h"      // 新浪

// ---------------------- 框架工具类 ----------------------

// ---------------------- controller ----------------------
// ---------------------- controller ----------------------

// ---------------------- view       ----------------------
// ---------------------- view       ----------------------

// ---------------------- model      ----------------------
// ---------------------- model      ----------------------


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self getUserinfoWithData];
    SetUserDefault(@"哈尔滨", @"cityName");
    self.window.backgroundColor     = [UIColor whiteColor];
    self.window.rootViewController  = [TabBarViewController new];
    [self.window makeKeyAndVisible];
    
    //设置友盟
    [self settingUM];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 设置友盟，分享
/**
 *  设置友盟分享
 */
- (void) settingUM {
    // 设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMENG_APP_KEY];
    
    // 打开调试log的开关
    [UMSocialData openLog:YES];
    
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];

    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:UMENG_SSO_ID secret:UMENG_SSO_KEY RedirectURL:OPEN_SSO_URL];

    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:UMENG_WX_ID appSecret:UMENG_WX_KEY url:UMENG_TX_URL];
    
}

- (void) getUserinfoWithData{
    if (!([GetUserDefault(userUid) length] > 0)) {
        return;
    }
    NSString *url  = [NSString stringWithFormat:@"%@%@", BaseURL, @"userinfo/getUserinfo"];
    NSArray *array = @[
                       [NSString stringWithFormat:@"mobile,%@", GetUserDefault(userUid)],//账号
                       ];
    [SVProgressHUD showWithStatus:HEADER_RERESHING_DATA_TITLE];
    [MainRequestTool mainPOST:url parameters:array isEncrypt:YES swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        //        [SVProgressHUD showInfoWithStatus:@"登录成功"];
        [SVProgressHUD dismiss];
        NSLog(@"%@", resultObject);
        if (resultObject != nil) {
            
            SetUserDefault(resultObject, @"getUserinfo");

        }else {
            
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"login/login数据错误%@", error);
    }];
}

@end
