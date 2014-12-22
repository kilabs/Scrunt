//
//  API+TransferBankManager.h
//  Delima
//
//  Created by Arie Prasetyo on 12/17/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_TransferBankManager : NSObject
- (instancetype)initWithTransfer:(NSDictionary *)attributes;
+ (NSURLSessionDataTask *)transfer:(NSDictionary *)params login:(void (^)(NSArray *posts, NSError *error))block;
@end
