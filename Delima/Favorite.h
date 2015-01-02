//
//  Favorite.h
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "RLMObject.h"

@interface Favorite : RLMObject

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
@property NSString *hargaDasar;
@property NSString *parent;


+ (void)save:(Favorite *)favorite withRevision:(BOOL)revision;
+(NSArray *)getAllFavorite;

@end
