//
//  API+BayarManager.h
//  Delima
//
//  Created by Arie Prasetyo on 12/22/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_BayarManager : NSObject
+ (NSURLSessionDataTask *)paid:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block;
@end
