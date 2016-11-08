//
//  JYAccount.m
//  Joyce的新浪微博
//
//  Created by Joyce on 15/6/4.
//  Copyright (c) 2015年 Joyce. All rights reserved.
//

#import "JYAccount.h"

@implementation JYAccount
+(instancetype)accountWithDic:(NSDictionary *)dic{
    JYAccount *account = [[self alloc]init];
    account.access_token = dic[@"access_token"];
    account.expires_in = dic[@"expires_in"];
    account.uid = dic[@"uid"];
    //获取帐号存储的时间
    NSDate *creatTime = [NSDate date];
    account.creatTime = creatTime;
    return account;
}
/**
 *  对象归档存进沙盒的方法，目的是说明这个对象的哪些属性要存进沙盒的。
 *
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.creatTime forKey:@"creatTime"];
    [aCoder encodeObject:self.name forKey:@"name"];

}
/**
 *  对象归档存进沙盒是，目的是说明那些属性要从沙盒中取出来的
 *
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.creatTime = [aDecoder decodeObjectForKey:@"creatTime"];
        self.name = [aDecoder decodeObjectForKey:@"name"];

    }
    return self;
}
@end
