//
//  API+CashIn.h
//  Delima
//
//  Created by Arie Prasetyo on 12/27/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_CashIn : NSObject
+ (NSURLSessionDataTask *)cashIn:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block;
@end
