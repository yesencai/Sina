//
//  JYHttpTool.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/2.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYHttpTool.h"
@implementation JYHttpTool
+(instancetype)httpTool{
    static JYHttpTool *tool;
    if (!tool) {
        tool = [[JYHttpTool alloc]init];
    }
    return tool;
}
+(void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
+(void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
   // manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

@end
