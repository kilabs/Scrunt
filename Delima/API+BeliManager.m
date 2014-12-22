//
//  API+BeliManager.m
//  Delima
//
//  Created by Arie Prasetyo on 12/21/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "API+BeliManager.h"
#import "delimaAPIManager.h"
#import "globalVariable.h"
#import "DelimaCommonFunction.h"
@implementation API_BeliManager
- (instancetype)initWithBeliPulsa:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }

    
    return self;
}
+ (NSURLSessionDataTask *)purchase:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block{
    return [[delimaAPIManager sharedClient]POST:[NSString stringWithFormat:@"%@/billpaymentfc2.php",delimaAPIUrl] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
         NSLog(@"data-->%@",responseObject);
        NSDictionary *postsFromResponse = responseObject;
        NSMutableArray *mutablePosts = [[NSMutableArray alloc]init];
        if ([[responseObject objectForKey:@"rc"]isEqualToString:@"00"]) {
                
            //// save it into model
            if (block) {
                block([NSArray arrayWithArray:mutablePosts], nil);
            }
        }
        else{
            NSLog(@"data-->%@",responseObject);
            [[DelimaCommonFunction sharedCommonFunction]setAlert:@"Error" message:[responseObject objectForKey:@"msg"]];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end
