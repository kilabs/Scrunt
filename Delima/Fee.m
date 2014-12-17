//
//  Fee.m
//  Delima
//
//  Created by Arie Prasetyo on 12/16/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "Fee.h"
#import <Realm.h>
#import "RealmManager.h"
@implementation Fee
+ (NSDictionary *)defaultPropertyValues {
    /*
     @property NSInteger id;
     @property NSString *guid;
     @property NSDate *createdAt;
     @property NSDate *updatedAt;
     @property NSInteger parentCode;
     @property NSInteger basicPrice;
     @property NSInteger salePrice;
     
     */
    return @{@"id" : @0,
             @"guid" : [[NSProcessInfo processInfo] globallyUniqueString],
             @"createdAt" : [NSDate date],
             @"updatedAt" : [NSDate date],
             @"parentCode" : @0,
             @"basicPrice" : @0,
             @"salePrice" : @0,
             };
}
+ (void)setCelullarFee{
    NSLog(@"celular Fee");
    [Fee setGameFee];
}
+(void)setGameFee{
    NSLog(@"game Fee");
}
+ (NSString *)primaryKey {
    return @"guid";
}

+(void)save:(Fee *)fee withRevision:(BOOL)revision{
    fee = [[Fee alloc]initWithObject:fee];
    [[RealmManager sharedMORealmSingleton].realm beginWriteTransaction];
    //    if (revision) [MOUserProfile saveToRevision:userProfile];
    [[RealmManager sharedMORealmSingleton].realm addOrUpdateObject:fee];
    [[RealmManager sharedMORealmSingleton].realm commitWriteTransaction];
}

@end
