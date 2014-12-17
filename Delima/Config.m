//
//  Config.m
//  Delima
//
//  Created by Arie Prasetyo on 12/16/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "Config.h"
#import <Realm.h>
#import "RealmManager.h"
@implementation Config
+ (NSDictionary *)defaultPropertyValues {
    return @{@"id" : @0,
             @"guid" : [[NSProcessInfo processInfo] globallyUniqueString],
             @"createdAt" : [NSDate date],
             @"updatedAt" : [NSDate date],
             @"isAlreadyLocalSync" : @NO,
             };
}

+(BOOL)getLocalSyncStatus{
    Config *isSync = [[Config alloc]init];
    if (isSync.isAlreadyLocalSync) {
        return true;
    }
    else{
        return false;
    }
}

+ (NSString *)primaryKey {
    return @"guid";
}
+(void)save:(Config *)config withRevision:(BOOL)revision{
    config = [[Config alloc]initWithObject:config];
    [[RealmManager sharedMORealmSingleton].realm beginWriteTransaction];
    //    if (revision) [MOUserProfile saveToRevision:userProfile];
    [[RealmManager sharedMORealmSingleton].realm addOrUpdateObject:config];
    [[RealmManager sharedMORealmSingleton].realm commitWriteTransaction];
}
@end
