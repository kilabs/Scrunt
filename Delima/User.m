//
//  User.m
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "User.h"
#import <Realm.h>
#import "RealmManager.h"
@implementation User
+ (NSDictionary *)defaultPropertyValues {
    /*
     @property NSInteger id;
     @property NSString *guid;
     @property NSDate *createdAt;
     @property NSDate *updatedAt;
     @property NSString *uname;
     @property NSString *passwd;
     @property NSString *os;
     @property NSString *version;
     @property NSString *ref;
     @property NSString *rc;
     @property NSString *saldo;
     @property NSString *sign;
     @property NSString *merNumber;
     @property NSString *ideva;
     @property NSString *sessionid;
     @property NSString *typeeva;
     @property NSString *idcode;
     @property NSString *merchantCode;
     @property NSString *name;
     */
    return @{@"id" : @0,
             @"guid" : [[NSProcessInfo processInfo] globallyUniqueString],
             @"createdAt" : [NSDate date],
             @"updatedAt" : [NSDate date],
             @"os" : @"",
             @"version" : @"",
             @"rc" : @"",
             @"sign" : @"",
             @"merNumber" : @"",
             @"ideva":@"",
             @"sessionid":@"",
             @"typeeva":@"",
             @"idcode":@"",
             @"merchantCode":@"",
             @"terminal":@"",
             @"passwd":@"",
             @"name":@"",
             @"uname":@"",
             @"ref":@""
             };
}

+ (NSString *)primaryKey {
    return @"id";
}
+ (User *)getUserProfile {
    RLMResults *array = [User allObjects];
    if(array.count > 0) {
        return [[User alloc] initWithObject:array[0]];
    } else {
        return [[User alloc] init];
    }
}
+(void)save:(User *)userProfile withRevision:(BOOL)revision{
    userProfile = [[User alloc]initWithObject:userProfile];
    [[RealmManager sharedMORealmSingleton].realm beginWriteTransaction];
    //    if (revision) [MOUserProfile saveToRevision:userProfile];
    [[RealmManager sharedMORealmSingleton].realm addOrUpdateObject:userProfile];
    [[RealmManager sharedMORealmSingleton].realm commitWriteTransaction];
}
@end
