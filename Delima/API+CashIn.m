//
//  API+CashIn.m
//  Delima
//
//  Created by Arie Prasetyo on 12/27/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "API+CashIn.h"
#import "delimaAPIManager.h"
#import "DelimaCommonFunction.h"
#import "globalVariable.h"
@implementation API_CashIn
+ (NSURLSessionDataTask *)cashIn:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block{
    return [[delimaAPIManager sharedClient]POST:[NSString stringWithFormat:@"%@cashinfc.php",delimaAPIUrl] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *postsFromResponse = responseObject;
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        NSLog(@"rsponse-->%@",[responseObject objectForKey:@"outputTransaction"]);
        if ([[[responseObject objectForKey:@"outputTransaction"] objectForKey:@"resultCode"]isEqualToString:@"0"]) {
            [mutablePosts addObject:[responseObject objectForKey:@"outputTransaction"]];
            //// save it into model
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
        }
        else{
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
                [[DelimaCommonFunction sharedCommonFunction]setAlert:@"Error" message:[responseObject objectForKey:@"msg"]];
            }
            
            
        }
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            NSLog(@"error %@",error);
            block([NSArray array], error);
        }
    }];
}
@end
