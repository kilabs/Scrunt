//
//  User.h
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "RLMObject.h"

@interface User : RLMObject
@property NSInteger id;
@property NSString *guid;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property NSString *uname;
@property NSString *terminal;
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
+ (User *)getUserProfile;
+ (void)save:(User *)userProfile withRevision:(BOOL)revision;
@end
