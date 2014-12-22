//
//  API+TransferBankManager.m
//  Delima
//
//  Created by Arie Prasetyo on 12/17/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "API+TransferBankManager.h"
#import "delimaAPIManager.h"
#import "globalVariable.h"
#import "DelimaCommonFunction.h"
@implementation API_TransferBankManager

+ (NSURLSessionDataTask *)transfer:(NSDictionary *)params login:(void (^)(NSArray *posts, NSError *error))block{
    return [[delimaAPIManager sharedClient]POST:[NSString stringWithFormat:@"%@/bankTransferfc2.php",delimaAPIUrl] parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *postsFromResponse = responseObject;
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        NSLog(@"response object->%@",params);
        if ([[responseObject objectForKey:@"rc"]isEqualToString:@"00"]) {
            
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
