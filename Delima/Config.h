//
//  Config.h
//  Delima
//
//  Created by Arie Prasetyo on 12/16/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "RLMObject.h"

@interface Config : RLMObject
@property NSInteger id;
@property NSString *guid;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property BOOL isAlreadyLocalSync;
+(BOOL)getLocalSyncStatus;
+ (void)save:(Config *)config withRevision:(BOOL)revision;
@end
