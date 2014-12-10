//
//  RealmManager.h
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "RLMRealm.h"

@interface RealmManager : RLMRealm
+ (RealmManager *)sharedMORealmSingleton;
- (void)truncateRealm;
@property (nonatomic, strong) RLMRealm *realm;

@end
