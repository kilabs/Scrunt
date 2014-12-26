//
//  API+CheckSaldo.m
//  Delima
//
//  Created by Arie Prasetyo on 12/25/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "API+CheckSaldo.h"
#import "delimaAPIManager.h"
#import "DelimaCommonFunction.h"
#import "globalVariable.h"
@implementation API_CheckSaldo
+ (NSURLSessionDataTask *)checkSaldo:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block{
    return [[delimaAPIManager sharedClient]POST:[NSString stringWithFormat:@"%@checksaldofc3.php",delimaAPIUrl] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *postsFromResponse = responseObject;
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        NSLog(@"rsponse-->%@",responseObject);
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
