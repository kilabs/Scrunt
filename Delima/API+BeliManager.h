//
//  API+BeliManager.h
//  Delima
//
//  Created by Arie Prasetyo on 12/21/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface API_BeliManager : NSObject
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

- (instancetype)initWithBeliPulsa:(NSDictionary *)attributes;
- (instancetype)initWithBeliVoucher:(NSDictionary *)attributes;
+ (NSURLSessionDataTask *)purchase:(NSDictionary *)parameters p:(void (^)(NSArray *posts, NSError *error))block;
@end
