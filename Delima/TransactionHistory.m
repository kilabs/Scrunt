//
//  TransactionHistory.m
//  Delima
//
//  Created by Arie Prasetyo on 12/23/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "TransactionHistory.h"
#import "RealmManager.h"
#import "RLMResults.h"
@implementation TransactionHistory
+ (NSDictionary *)defaultPropertyValues {
    /*
     @property NSInteger id;
     @property NSString *guid;
     @property NSDate *createdAt;
     @property NSDate *updatedAt;
     @property NSDate *executeDate;
     @property NSString *itemName;
     @property NSString *tujuan;
     @property NSString *keterangan;
     + (void)save:(TransactionHistory *)fee withRevision:(BOOL)revision;
     @end
     */
    return @{@"id" : @0,
             @"guid" : [[NSProcessInfo processInfo] globallyUniqueString],
             @"createdAt" : [NSDate date],
             @"updatedAt" : [NSDate date],
             @"executeDate" : @0,
             @"itemName" : @"",
             @"price" : @"",
             @"tujuan" : @"",
             @"keterangan" : @"",
             };
}
+(NSArray *)getAllHistory{
    RLMResults *objects = [TransactionHistory allObjects];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:objects.count];
    for(id object in objects) {
        TransactionHistory *item = [[TransactionHistory alloc] initWithObject:object];
        [mutableArray addObject:item];
    }
    
    return mutableArray;
}

+ (NSString *)primaryKey {
    return @"guid";
}
+(void)save:(TransactionHistory *)transactionHistory withRevision:(BOOL)revision{
    transactionHistory = [[TransactionHistory alloc]initWithObject:transactionHistory];
    [[RealmManager sharedMORealmSingleton].realm beginWriteTransaction];
    //    if (revision) [MOUserProfile saveToRevision:userProfile];
    [[RealmManager sharedMORealmSingleton].realm addOrUpdateObject:transactionHistory];
    [[RealmManager sharedMORealmSingleton].realm commitWriteTransaction];
}
@end
