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
//        NSLog(<#NSString *format, ...#>)
//
//        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        NSLog(@"-------->%@",responseObject);
//        if (postsFromResponse) {
//            API_LoginManager *post = [[API_LoginManager alloc]initWithUserBasicAttribute:postsFromResponse];
//            [mutablePosts addObject:post];
//        }
        if (block) {
            block([NSArray arrayWithArray:nil], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            NSLog(@"error--->%@",error);
            block([NSArray array], error);
        }
    }];
}
//+(void)login:(NSDictionary *)params{
//    NSLog(@"params-->%@",params);
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
//                                                       options:NSJSONReadingMutableContainers
//                                                         error:nil];
//    NSString* stripped = [NSString stringWithFormat:@"{%@}",[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil removingNulls:YES ignoreArrays:NO]];
//    NSLog(@"Stripped-->%@",stripped);
//    [stripped stringByReplacingOccurrencesOfString:@";" withString:@"\","];
//    NSLog(@"stripped->%@")
////    [[delimaAPIManager sharedClient]POST:[NSString stringWithFormat:@"%@/loginfc2.php",delimaAPIUrl] parameters:stripped success:^(AFHTTPRequestOperation *operation, id responseObject) {
////        NSLog(@"response object--->%@",[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil]);
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        
////    }];
//};
@end
