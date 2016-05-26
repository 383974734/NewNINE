//
//  MainRequestTool.h
//  ClientNINE
//
//  Created by yinduo-zdy on 16/5/3.
//  Copyright © 2016年 yinduo-zdy. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! ---------------------- Tool       ---------------------- !*/
#import <AFNetworking/AFNetworking.h>     // AFNetworking 网络库
/*! ---------------------- Tool       ---------------------- !*/

NS_ASSUME_NONNULL_BEGIN

/*! SwpRequest 的请求成功 回调 Block !*/
typedef void(^SwpResultSuccessHandle)(NSURLSessionDataTask *task, id resultObject);
/*! SwpRequest 的请求失败 回调 Block !*/
typedef void(^SwpResultErrorHandle)(NSURLSessionDataTask *task, NSError *error, NSString *errorMessage);

@interface MainRequestTool : NSObject


#pragma mark - SwpRequest Tool Methods
/*!
 *
 *  @brief  mainPOST                         ( 请求网络获取数据 <POST> )
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
+ (void)mainPOST:(NSString *)URLString parameters:(NSArray *)parameters isEncrypt:(BOOL)encrypt swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError;


/*!
 *
 *  @brief  mainPOSTAddFile                  ( 请求网络获上传文件 单文件上传 <POST> )
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
+ (void)mainPOSTAddFile:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt fileName:(NSString *)fileName fileData:(NSData *)fileData swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError;

/*!
 *
 *  @brief  mainPOSTAddFiles                 ( 请求网络获上传文件 多文件上传, 文件名称相同使用该方法 <POST> )
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
+ (void)mainPOSTAddFiles:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt fileName:(NSString *)fileName fileDatas:(NSArray *)fileDatas swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError;

/*!
 *
 *  @brief  mainPOSTAddWithFiles             ( 请求网络获上传文件 多文件上传, 文件名称不相同相同使用该方法  <POST> )
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
+ (void)mainPOSTAddWithFiles:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt fileNames:(NSArray *)fileNames fileDatas:(NSArray *)fileDatas swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError;

/*!
 *
 *  @brief  mainRequestAFNetworkingTest  ( AFNetworking 测试方法 )
 *
 *  @param  URLString                   请求的 url
 *
 *  @param  parameters                  请求 需要传递的参数
 *
 *  @param  encrypt                     请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *
 *  @since  1.0.7
 */
+ (void) mainRequestAFNetworkingTest:(NSString *)URLString parameters:(NSDictionary *)parameters isEncrypt:(BOOL)encrypt;

/**
 *  网络请求  get方法
 *
 *  @param URLString        请求的 url
 *  @param parameters       请求 需要传递的参数
 *  @param encrypt          请求 是否 对参数加密 (YES 加密 / NO 不加密)
 *  @param swpResultSuccess 请求获取数据成功
 *  @param swpResultError   请求获取数据失败
 */
+ (void)mainGET:(NSString *)URLString parameters:(NSArray *)parameters isEncrypt:(BOOL)encrypt swpResultSuccess:(SwpResultSuccessHandle)swpResultSuccess swpResultError:(SwpResultErrorHandle)swpResultError;


@end
NS_ASSUME_NONNULL_END