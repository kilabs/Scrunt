//
//  API+LoginManager.h
//  Delima
//
//  Created by Arie Prasetyo on 12/10/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_LoginManager : NSObject
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

- (instancetype)initWithUserBasicAttribute:(NSDictionary *)attributes;
+ (NSURLSessionDataTask *)login:(NSDictionary *)params login:(void (^)(NSArray *posts, NSError *error))block;
@end
