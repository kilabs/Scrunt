//
//  API+BayarManager.m
//  Delima
//
//  Created by Arie Prasetyo on 12/22/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "API+BayarManager.h"
#import "globalVariable.h"
#import "DelimaCommonFunction.h"
#import "delimaAPIManager.h"
@implementation API_BayarManager
+ (NSURLSessionDataTask *)paid:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block{
    return [[delimaAPIManager sharedClient]POST:[NSString stringWithFormat:@"%@billpaymentfc2.php",delimaAPIUrl] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *postsFromResponse = responseObject;
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        
        if ([[responseObject objectForKey:@"rc"]isEqualToString:@"00"]) {
            [mutablePosts addObject:postsFromResponse];
            //// save it into model
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
        }
        else{
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
            [[DelimaCommonFunction sharedCommonFunction]setAlert:@"Error" message:[responseObject objectForKey:@"msg"]];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}
@end
