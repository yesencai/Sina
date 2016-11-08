//
//  JYHttpTool.h
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/2.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface JYHttpTool : NSObject

+(instancetype)httpTool;
/**
 *  GET请求
 *
 *  @param path       url
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+(void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;
/**
 *  POST请求
 *
 *  @param path       url
 *  @param parameters 参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+(void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;
@end
