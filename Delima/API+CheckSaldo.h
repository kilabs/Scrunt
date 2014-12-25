//
//  API+CheckSaldo.h
//  Delima
//
//  Created by Arie Prasetyo on 12/25/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_CheckSaldo : NSObject
+ (NSURLSessionDataTask *)checkSaldo:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block;
@end
