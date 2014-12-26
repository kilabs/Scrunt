//
//  RealmManager.m
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "RealmManager.h"
#import "User.h"
#import "Favorite.h"
@implementation RealmManager
+ (RealmManager *)sharedMORealmSingleton {
    static dispatch_once_t pred;
    static RealmManager *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[RealmManager alloc] init];
    });
    return shared;
}

- (id)init {
    self = [super init];
    if(self) {
        //        [GVUserDefaults standardUserDefaults].databaseVersion = 1;
        //        [self performMigrationIfNeeded];
        _realm = [RLMRealm defaultRealm];
       
    }
    return self;
}

-(void)truncateRealm{
    [_realm beginWriteTransaction];
    [_realm deleteObjects:[User allObjects]];
    [_realm deleteObjects:[Favorite allObjects]];
    [_realm commitWriteTransaction];
}
@end
