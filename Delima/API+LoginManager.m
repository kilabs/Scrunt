//
//  API+LoginManager.m
//  Delima
//
//  Created by Arie Prasetyo on 12/10/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "API+LoginManager.h"
#import "DelimaCommonFunction.h"
#import "globalVariable.h"
#import "delimaAPIManager.h"
#import "User.h"
#import <NSJSONSerialization+RemovingNulls.h>
@implementation API_LoginManager
/*
 @property (nonatomic, strong) NSString *rc;
 @property (nonatomic, strong) NSString *saldo;
 @property (nonatomic, strong) NSString *sign;
 @property (nonatomic, strong) NSString *merNumber;
 @property (nonatomic, strong) NSString *ideva;
 @property (nonatomic, strong) NSString *sessionid;
 @property (nonatomic, strong) NSString *idcode;
 @property (nonatomic, strong) NSString *typeeva;
 @property (nonatomic, strong) NSString *merchantCode;
 @property (nonatomic, strong) NSString *name;
 */
- (instancetype)initWithUserBasicAttribute:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.rc = [attributes objectForKey:@"rc"];
    self.saldo = [attributes objectForKey:@"saldo"];
    self.sign = [attributes valueForKeyPath:@"sign"];
    self.merNumber = [attributes objectForKey:@"merNumber"];
    self.ideva = [attributes valueForKeyPath:@"ideva"];
    self.sessionid = [attributes valueForKeyPath:@"sessionid"];
    self.idcode = [attributes valueForKeyPath:@"idcode"];
    self.typeeva = [attributes valueForKeyPath:@"typeeva"];
    self.merchantCode = [attributes valueForKeyPath:@"merchantCode"];
    self.name = [attributes valueForKeyPath:@"merchantCode"];
    
    
    return self;
}
+ (NSURLSessionDataTask *)login:(NSDictionary *)params login:(void (^)(NSArray *posts, NSError *error))block{
    
    return [[delimaAPIManager sharedClient]POST:[NSString stringWithFormat:@"%@/loginfc2.php",delimaAPIUrl] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *postsFromResponse = responseObject;
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        if ([[responseObject objectForKey:@"rc"]isEqualToString:@"00"]) {
            
            API_LoginManager *post = [[API_LoginManager alloc]initWithUserBasicAttribute:postsFromResponse];
            [mutablePosts addObject:post];
            
            User * u =[[User alloc]initWithObject:post];
            
            u.uname = [params objectForKey:@"uname"];
            u.passwd = [params objectForKey:@"passwd"];
            u.version = [params objectForKey:@"version"];
            u.ref = [params objectForKey:@"ref"];
            u.os =@"IOS";
            u.terminal =[params objectForKey:@"terminal"];
            [User save:u withRevision:YES];
            //// save it into model
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
        }
        else{
             NSLog(@"data-->%@",[responseObject objectForKey:@"rc"]);
            NSLog(@"data-->%@",[responseObject objectForKey:@"msg"]);
            [[DelimaCommonFunction sharedCommonFunction]setAlert:@"Error" message:[responseObject objectForKey:@"msg"]];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}
@end
