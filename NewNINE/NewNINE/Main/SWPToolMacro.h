//
//  SWPToolMacro.h
//  swp_song
//
//  Created by songweiping on 15/8/31.
//  Copyright (c) 2015年 songweipng. All rights reserved.
//

#ifndef PalmHeCheng_SWPToolMacro_h
#define PalmHeCheng_SWPToolMacro_h


#define everLaunch  @"firstEnter"           /*!< 判断是否第一次进入应用: yes-不是第一次，no-是第一次 */
#define isLogined     @"islogined"              /*!< 判断用户登录状态: yes-已登录，no-未登录 */
#define userInfomation    @"userInfo"       /*!< NSUserDefault中，保存用户信息的key */
#define loginInfomation @"loginInfo"        /*!< NSUserDefault中，保存用户登录信息的key */
#define loginChange     @"loginChange"
#define extraReload     @"extraReload"     //购买商品更新列表信息
#define mediaChange     @"mediaChange"     //上传图片或者下载图片修改用户信息
#define exhangeChange   @"exchangeChange"  //交换名片更改信息

//存储发送的消息
#define messageText    @"messageText"
#define emailText      @"emailText"
#define askEmailText   @"askEmailText"

//存储用户基本信息
#define userCompan         @"company"
#define userInvitation_num @"invitation_num"
//#define userNickname       @"nickname"
#define userUid            @"UserID"
#define UserMobile         @"UserMobile"
#define UserPasswd         @"UserMobile"




//---------------------------------------------------------
/** 网络连接获取数据 */
//      开发环境
#define BaseURL @"http://121.40.92.117:8080/api/"
//      生产环境  ---  1.1版本
//#define BaseURL @"http://api.mlmsalon.com/api/"
//      生产环境  ---  1.2版本
//#define BaseURL @"http://api.mlmsalon.com/newapi/api/"
//      本地环境
//#define BaseURL @"http://192.168.0.106:1080/api/"

//---------------------------------------------------------

/** web网络连接获取数据 */
//      开发环境
#define developmentURL @"http://121.40.92.117:1080/Home/"
//      生产环境  ---  1.1版本
//#define developmentURL @"http://share.mlmsalon.com/Home/"
//      生产环境  ---  1.2版本
//#define developmentURL @"http://share.mlmsalon.com/Home/"
//      本地环境
//#define developmentURL @"http://192.168.0.106:1080/"
//---------------------------------------------------------



/** AFNetworking 获取 url */
#define GetConnectUrl(key) [[[[JSONOfNetWork getDictionaryFromPlist] objectForKey:@"obj"]objectForKey:@"api"] objectForKey:key]

// 写入NSUserDefault中的数据
#define SetUserDefault(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
// 获取NSUserDefault中的数据
#define GetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]


// 系统字体大小
#define SWP_SYSTEM_FONT_SIZE(size) [UIFont systemFontOfSize:size]

// 是否base64加密
#define IS_BASE64 @"YES"

/*
 *  从RGB获得颜色 0xffffff
 */
#define SWPUIColorFromRGB(rgbValue)                            \
[UIColor                                                    \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0   \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0             \
blue:((float)(rgbValue & 0xFF))/255.0                       \
alpha:1.0]
/*
 *  从RGB获得颜色 R G B A
 */
#define SWPColor(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]

/** 随机色 */
#define SWPRandomColor Color(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)



///*! 友盟分享    !*/
//#define UMENG_NAME          @"汽配网"
//#define UMENG_IMAGE_NAME    @"user_pengyouquan"
//
///** 友盟三方key */
//#define UMENG_APP_KEY       @"56175e2f67e58e330200164c"
//
///** QQ and QQ空间 ID and Key  tencent1104826127 */
//#define UMENG_QQ_ID         @"1104826127"
//#define UMENG_QQ_KEY        @"5cL4Fx96VxnIw8Oa"
//
///** 微信 ID and Key */
//#define UMENG_WX_ID         @"wx32df84e2e5aedfb9"
//#define UMENG_WX_KEY        @"a28b0b808ef5b8e60e7989638fe354f7"
//
///** QQ 和 微信的URL 两个用的一个 */
//#define UMENG_TX_URL        @"http://www.umeng.com/social"
//
///** 新浪微博打开 SSO */
//#define OPEN_SSO_URL        @"http://sns.whalecloud.com/sina2/callback"

//------------------
/*! 友盟分享    !*/
#define UMENG_NAME          @""
#define UMENG_IMAGE_NAME    @"logo"

/** 友盟三方key */
#define UMENG_APP_KEY       @"56af1b8967e58ec528001e19"


/** QQ and QQ空间 ID and Key  tencent1104558561 */
#define UMENG_QQ_ID         @"1104826127"
#define UMENG_QQ_KEY        @"5cL4Fx96VxnIw8Oa"

/** 微信 ID and Key */
#define UMENG_WX_ID         @"wxe94f6ebf0daa4bda"
#define UMENG_WX_KEY        @"e2f4f10444b6399f18e151737a0b653e"

/** QQ 和 微信的URL 两个用的一个 */
#define UMENG_TX_URL        @"http://www.umeng.com/social"

/** 新浪微博打开 SSO */
#define UMENG_SSO_ID         @"3272947599"
#define UMENG_SSO_KEY        @"66bbef3a8d63eb51eca20dcc3f088c61"
#define OPEN_SSO_URL         @"http://sns.whalecloud.com/sina2/callback"
//------------------


// 导航控制器 文字大小
#define NAVIGATION_TITLE_FONT_SIZE 18

/** 极光推送 设置取消别名 */
#define JPUSH_ALIAS @"NO_NAME"

#define SUCCESS                           @"200"
#define DATA_CODE                         @"code"
#define DATA_OBJ                          @"obj"
#define DATA_MESSAGE                      @"message"
#define DATA_NONT                         @"没有数据啦！"
#define DATA_GET_DATA                     @"努力获取中..."
#define DATA_COMMITE                      @"数据提交中..."
#define DATA_DELETE                       @"数据删除中..."
#define DATA_UPDATE                       @"修改中..."
#define DATA_LOGIN                        @"用户登录中..."
#define NETWORK_ERROR                     @"网络异常！"
#define HEADER_RERESHING_DATA_TITLE       @"努力刷新中..."
#define FOOTER_RERESHING_DATA_TITLE       @"努力加载中..."

//#define everLaunch  @"firstEnter"           /*!< 判断是否第一次进入应用: yes-不是第一次，no-是第一次 */

#endif
