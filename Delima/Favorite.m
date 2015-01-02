//
//  Favorite.m
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "Favorite.h"
#import "RealmManager.h"
#import "RLMResults.h"
@implementation Favorite
+ (NSDictionary *)defaultPropertyValues {
    /*
     @property NSInteger id;
     @property NSInteger type;
     @property NSString *guid;
     @property NSDate *createdAt;
     @property NSDate *updatedAt;
     @property NSString *itemName;
     @property NSString *hargaJual;
     @property NSString *amount;
     @property NSString *title;
     @property NSString *mercode;
     @property NSString *prodcode;
     @property NSString *recipientNumber;
     @property NSString *controllerName;
     @property NSString *denom;
     @property NSString *storyboardName;
     @property NSString *parent;
     */
    return @{@"id" : @0,
             @"guid" : [[NSProcessInfo processInfo] globallyUniqueString],
             @"createdAt" : [NSDate date],
             @"updatedAt" : [NSDate date],
             @"type" : @0,
             @"itemName" : @"",
             @"hargaJual" : @"",
             @"amount" : @"",
             @"title" : @"",
             @"mercode" : @"",
             @"prodcode":@"",
             @"recipientNumber":@"",
             @"controllerName":@"",
             @"denom":@"",
             @"hargaDasar":@"",
             @"storyboardName":@"",
             @"parent":@""
             };
}
+ (void)save:(Favorite *)favorite withRevision:(BOOL)revision{
    favorite = [[Favorite alloc]initWithObject:favorite];
    [[RealmManager sharedMORealmSingleton].realm beginWriteTransaction];
    //    if (revision) [MOUserProfile saveToRevision:userProfile];
    [[RealmManager sharedMORealmSingleton].realm addOrUpdateObject:favorite];
    [[RealmManager sharedMORealmSingleton].realm commitWriteTransaction];
}
+(NSArray *)getAllFavorite{
    RLMResults *objects = [[Favorite allObjects]
                           sortedResultsUsingProperty:@"createdAt" ascending:NO];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:objects.count];
    for(id object in objects) {
        Favorite *item = [[Favorite alloc] initWithObject:object];
        [mutableArray addObject:item];
    }
    NSLog(@"mutableArray->%@",mutableArray);
    return mutableArray;
}

+ (NSString *)primaryKey {
    return @"guid";
}

@end
