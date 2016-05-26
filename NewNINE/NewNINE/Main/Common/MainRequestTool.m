//
//  MainRequestTool.m
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import "MainRequestTool.h"
#import<CommonCrypto/CommonDigest.h>

@interface MainRequestTool ()

#pragma mark - Networking Property
/*! AFHTTPSessionManager 网络请求管理者对象 !*/
@property (nonatomic, strong) AFHTTPSessionManager *swpSessionManager;

@end

@implementation MainRequestTool

#pragma mark - SwpRequest Tool Methods
/*!
 *
 *  @brief  swpPOST                         ( 请求网络获取数据 <POST> )
 *
 *  @param  URLString                       请求的 url
 *
 *  @param  parameters                      请求 需要传递的参数
 *
 *  @param  encrypt                         请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *
 *  @param  swpResultSuccess                请求获取数据成功
 *
 *  @param  swpResultError                  请求获取数据失败
 *
 *  @since  1.0.8
 */
+ (void)mainPOST:(NSString *)URLString parameters:(NSArray *)parameters isEncrypt:(BOOL)encrypt swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError {
    // 初始化自定义网络请求类
    MainRequestTool *swpRequest          = [MainRequestTool shareInstance];
    
    // 字典加密
//    NSDictionary         *dictionary     = encrypt ? [swpRequest encryptedParamsWithDict:parameters] : parameters;
    
    NSDictionary         *dictionary     = [swpRequest requestDitc:parameters];
    // 返回结果集
    __block NSDictionary *resultObject   = [NSDictionary dictionary];
    
    // 显示 状态栏 请求数据的菊花
    [swpRequest settingNetworkPicture:YES];
    
    // 发起请求
    [swpRequest.swpSessionManager POST:URLString parameters:dictionary progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultObject = [swpRequest requestDispose:responseObject isBase64:encrypt];
        swpResultSuccess(task, resultObject);
        [swpRequest settingNetworkPicture:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorInfo = error == nil ? nil : [NSString stringWithFormat:@"错误代码%ld \n 错误信息%@", (long)error.code, error.localizedDescription];
        swpResultError(task, error, errorInfo);
        [swpRequest settingNetworkPicture:NO];
    }];
    
}

/**
 *  网络请求  get方法
 *
 *  @param URLString        请求的 url
 *  @param parameters       请求 需要传递的参数
 *  @param encrypt          请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *  @param swpResultSuccess 请求获取数据成功
 *  @param swpResultError   请求获取数据失败
 */
+ (void)mainGET:(NSString *)URLString parameters:(NSArray *)parameters isEncrypt:(BOOL)encrypt swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError {
    MainRequestTool *swpRequest          = [MainRequestTool shareInstance];
    
    // 字典加密
//    NSDictionary         *dictionary     = encrypt ? [swpRequest encryptedParamsWithDict:parameters] : parameters;
    
    NSDictionary         *dictionary     = [swpRequest requestDitc:parameters];
    
    // 返回结果集
    __block NSDictionary *resultObject   = [NSDictionary dictionary];
    
    // 显示 状态栏 请求数据的菊花
    [swpRequest settingNetworkPicture:YES];
    
    // 发起请求
    [swpRequest.swpSessionManager GET:URLString parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultObject = [swpRequest requestDispose:responseObject isBase64:encrypt];
        swpResultSuccess(task, resultObject);
        [swpRequest settingNetworkPicture:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorInfo = error == nil ? nil : [NSString stringWithFormat:@"错误代码%ld \n 错误信息%@", (long)error.code, error.localizedDescription];
        swpResultError(task, error, errorInfo);
        [swpRequest settingNetworkPicture:NO];
    }];
}

/*!
 *  @author swp_song, 2016-01-05 22:31:06
 *
 *  @brief  swpPOSTAddFile                  ( 请求网络获上传文件 单文件上传 <POST> )
 *
 *  @param  URLString                       请求的 url
 *
 *  @param  parameters                      请求 需要传递的参数
 *
 *  @param  encrypt                         请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *
 *  @param  fileName                        请求 上传文件的名称 (和后台一致)
 *
 *  @param  fileData                        请求 上传文件的数据流
 *
 *  @param  swpResultSuccess                请求获取数据成功
 *
 *  @param  swpResultError                  请求获取数据失败
 *
 *  @since  1.0.8
 */
+ (void)mainPOSTAddFile:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt fileName:(NSString *)fileName fileData:(NSData *)fileData swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError {
    
    // 初始化自定义网络请求类
    MainRequestTool *swpRequest          = [MainRequestTool shareInstance];
    
    // 字典加密
    NSDictionary         *dictionary     = encrypt ? [swpRequest encryptedParamsWithDict:parameters] : parameters;
    // 返回结果集
    __block NSDictionary *resultObject   = [NSDictionary dictionary];
    
    // 显示 状态栏 请求数据的菊花
    [swpRequest settingNetworkPicture:YES];
    
    // 发起请求
    [swpRequest.swpSessionManager POST:URLString parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:fileName fileName:@"picture.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultObject = [swpRequest requestDispose:responseObject isBase64:encrypt];
        swpResultSuccess(task, resultObject);
        [swpRequest settingNetworkPicture:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorInfo = error == nil ? nil : [NSString stringWithFormat:@"错误代码%ld \n 错误信息%@", (long)error.code, error.localizedDescription];
        swpResultError(task, error, errorInfo);
        [swpRequest settingNetworkPicture:NO];
    }];
}

/*!
 *  @author swp_song, 2016-01-05 22:35:33
 *
 *  @brief  swpPOSTAddFiles                 ( 请求网络获上传文件 多文件上传, 文件名称相同使用该方法 <POST> )
 *
 *  @param  URLString                       请求的 url
 *
 *  @param  parameters                      请求 需要传递的参数
 *
 *  @param  encrypt                         请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *
 *  @param  fileName                        请求 上传文件的名称 (和后台一致)
 *
 *  @param  fileDatas                       请求 上传文件的流数组
 *
 *  @param  swpResultSuccess                请求获取数据成功
 *
 *  @param  swpResultError                  请求获取数据失败
 *
 *  @since  1.0.8
 */
+ (void)mainPOSTAddFiles:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt fileName:(NSString *)fileName fileDatas:(NSArray *)fileDatas swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError {
    
    // 初始化自定义网络请求类
    MainRequestTool *swpRequest          = [MainRequestTool shareInstance];
    
    // 字典加密
    NSDictionary         *dictionary     = encrypt ? [swpRequest encryptedParamsWithDict:parameters] : parameters;
    // 返回结果集
    __block NSDictionary *resultObject   = [NSDictionary dictionary];
    
    // 显示 状态栏 请求数据的菊花
    [swpRequest settingNetworkPicture:YES];
    
    // 发起请求
    [swpRequest.swpSessionManager POST:URLString parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<fileDatas.count; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@[%i]", fileName, i];
            [formData appendPartWithFileData:fileDatas[i] name:imageName fileName:imageName mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultObject = [swpRequest requestDispose:responseObject isBase64:encrypt];
        swpResultSuccess(task, resultObject);
        [swpRequest settingNetworkPicture:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorInfo = error == nil ? nil : [NSString stringWithFormat:@"错误代码%ld \n 错误信息%@", (long)error.code, error.localizedDescription];
        swpResultError(task, error, errorInfo);
        [swpRequest settingNetworkPicture:NO];
    }];
    
}

/*!
 *  @author swp_song, 2016-01-05 22:42:50
 *
 *  @brief  swpPOSTAddWithFiles             ( 请求网络获上传文件 多文件上传, 文件名称不相同相同使用该方法  <POST> )
 *
 *  @param  URLString                       请求的 url
 *
 *  @param  parameters                      请求 需要传递的参数
 *
 *  @param  encrypt                         请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *
 *  @param  fileNames                       请求 上传文件的名称数组 (和后台一致)
 *
 *  @param  fileDatas                       请求 上传文件的流数组
 *
 *  @param  swpResultSuccess                请求获取数据成功
 *
 *  @param  swpResultError                  请求获取数据失败
 *
 *  @since  1.0.8
 */
+ (void)mainPOSTAddWithFiles:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt fileNames:(NSArray *)fileNames fileDatas:(NSArray *)fileDatas swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError {
    
    // 初始化自定义网络请求类
    MainRequestTool *swpRequest          = [MainRequestTool shareInstance];
    
    // 字典加密
    NSDictionary         *dictionary     = encrypt ? [swpRequest encryptedParamsWithDict:parameters] : parameters;
    // 返回结果集
    __block NSDictionary *resultObject   = [NSDictionary dictionary];
    
    // 显示 状态栏 请求数据的菊花
    [swpRequest settingNetworkPicture:YES];
    
    // 发起请求
    [swpRequest.swpSessionManager POST:URLString parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<fileDatas.count; i++) {
            [formData appendPartWithFileData:fileDatas[i] name:fileNames[i] fileName:fileNames[i] mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultObject = [swpRequest requestDispose:responseObject isBase64:encrypt];
        swpResultSuccess(task, resultObject);
        [swpRequest settingNetworkPicture:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *errorInfo = error == nil ? nil : [NSString stringWithFormat:@"错误代码%ld \n 错误信息%@", (long)error.code, error.localizedDescription];
        swpResultError(task, error, errorInfo);
        [swpRequest settingNetworkPicture:NO];
    }];
    
}

/*!
 *  @author swp_song, 2015-12-11 17:24:00
 *
 *  @brief  swpRequestAFNetworkingTest  ( AFNetworking 测试方法 )
 *
 *  @param  URLString                   请求的 url
 *
 *  @param  parameters                  请求 需要传递的参数
 *
 *  @param  encrypt                     请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *
 *  @since  1.0.7
 */
+ (void) mainRequestAFNetworkingTest:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt {
    NSLog(@"This is AFNetworking Test Method");
}

#pragma mark - Init SwpRequest Method
/*!
 *  @author swp_song, 2015-12-11 16:55:07
 *
 *  @brief  shareInstance       ( 单利 快速初始化一个 用户数据模型 )
 *
 *  @return SwpRequest
 *
 *  @since  1.0.7
 */
+ (instancetype) shareInstance {
    static MainRequestTool *swpRequest = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        swpRequest = [[self alloc] init];
    });
    return swpRequest;
}

//#pragma mark - POST Parameters Encrypt Methods
///*!
// *  @author swp_song, 2015-12-11 16:56:43
// *
// *  @brief  encryptedParamsWithDict     ( 对字典 进行加密 返回 加密之后的字典 )
// *
// *  @param  dict
// *
// *  @return NSDictionary
// *
// *  @since  1.0.7
// */
//- (NSDictionary *)encryptedParamsWithDict:(NSDictionary *)dict {
//    
//    //创建返回字典
//    NSMutableDictionary* returnDict = [[NSMutableDictionary alloc]init];
//    [dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL *stop) {
//        
//        //传入字典自检 查询字典中的key和Obj是否有空值
//        if (key == nil || obj == nil) {
//            NSAssert(nil, @"something nil in dictionary");
//            *stop = YES;
//        }
//        
//    }];
//    return returnDict;
//}

-(NSDictionary *)encryptedParamsWithDict:(NSDictionary *)dic
{
    NSMutableDictionary *tempdic = [NSMutableDictionary new];
    
    NSArray *keys = [dic allKeys];
    NSArray *values = [dic allValues];
    
    NSString *str = @"";
    for (int i = 0; i < keys.count; i++)
    {
        
        [tempdic setObject:values[i] forKey:keys[i]];
        // 这里要注意拼接的时候， 判断是否为空。
        str = [NSString stringWithFormat:@"%@%@=%@&",str,keys[i],values[i] ];
    }
    
    str = [NSString stringWithFormat:@"%@%@",str , @"key=3e9bb86c6980c3b79e5b936ce10b9b96"];
    
    str = [self getSha256String:str];
    
    [tempdic setObject:str forKey:@"sign"];
    NSLog(@" --- %@ ----",tempdic);
    return tempdic;
}

/*!
 *  @author swp_song, 2015-12-11 16:59:57
 *
 *  @brief  settingNetworkPicture   ( 显示 或隐藏 网络获取数据时 UINavigationBar 上的图标(转圈的菊花) )
 *
 *  @param  isShow                  networkActivityIndicatorVisible YES 显示，NO 隐藏
 *
 *  @since  1.0.7
 */
- (void) settingNetworkPicture:(BOOL)isShow {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = isShow;
}


#pragma mark - Request Dispose Method
/*!
 *  @author swp_song, 15-12-11 16:12:31
 *
 *  @brief  requestDispose      ( 返回 网络 结果集 处理 )
 *
 *  @param  responseObject
 *
 *  @param  base64              是否base64加密
 *
 *  @return NSDictionary
 *
 *  @since  1.0.7
 */
- (NSDictionary *)requestDispose:(id)responseObject isBase64:(BOOL)base64 {
    
    // 转换成 字符串
    NSString *decodeJson = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"responseJson === > %@", decodeJson);
    
    if (!decodeJson) {
        NSLog(@" responseObject ===> %@", decodeJson);
        return nil;
    }
    
    NSLog(@"responseObject ===> %@", decodeJson);
    
    // 字符串转成流
    NSData       *data = [decodeJson dataUsingEncoding:NSUTF8StringEncoding];
    // 转换字典
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    // 返回结果集
    NSLog(@"dict    : ===> %@",  dict);
    return dict;
}

#pragma Init AFHTTPSessionManager Method
- (AFHTTPSessionManager *)swpSessionManager {
    
    if (!_swpSessionManager) {
        
        _swpSessionManager = [AFHTTPSessionManager manager];
        _swpSessionManager.responseSerializer  = [AFHTTPResponseSerializer serializer];
        [_swpSessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/html", @"text/css", @"text/javascript", nil]];
    }
    return _swpSessionManager;
}

//sha256加密方式
- (NSString *)getSha256String:(NSString *)srcString
{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = nil ; //[NSData dataWithBytes:cstr length:content.length];

    data = [srcString dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}



- (NSDictionary *) requestDitc:(NSArray *)array {
    NSMutableDictionary *tempdic = [NSMutableDictionary new];
    NSString *str = @"";
    for (int i = 0; array.count > i; i++) {
        [tempdic setObject:[array[i] componentsSeparatedByString:@","][1] forKey:[array[i] componentsSeparatedByString:@","][0]];
        // 这里要注意拼接的时候， 判断是否为空。
        if ([[array[i] componentsSeparatedByString:@","][1] isEqualToString:@""]) {
            str = [NSString stringWithFormat:@"%@%@=%@&",str,[array[i] componentsSeparatedByString:@","][0], @""];
        }else {
            str = [NSString stringWithFormat:@"%@%@=%@&",str,[array[i] componentsSeparatedByString:@","][0],[array[i] componentsSeparatedByString:@","][1]];
        }
        
    }
    str = [NSString stringWithFormat:@"%@%@",str , @"key=3e9bb86c6980c3b79e5b936ce10b9b96"];
    
    str = [self getSha256String:str];
    
    [tempdic setObject:str forKey:@"sign"];
    
    return tempdic;
}

@end
