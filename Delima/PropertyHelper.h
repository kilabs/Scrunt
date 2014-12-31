//
//  PropertyHelper.h
//  Delima
//
//  Created by Arie Prasetyo on 12/16/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyHelper : NSObject
+ (id)readFromKey:(NSString *)key;
+ (id)readFromKeys:(NSArray *)keys;
+ (void)setFavorite:(NSDictionary *)params;
+ (NSDictionary *)getTempFavorite;
+ (id)readFromKeys:(NSArray *)keys withPropertiesPath:(NSString *)propertiesPath;
@end
