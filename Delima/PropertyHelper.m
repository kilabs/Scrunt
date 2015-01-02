//
//  PropertyHelper.m
//  Delima
//
//  Created by Arie Prasetyo on 12/16/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "PropertyHelper.h"

static NSString *_propertiesPath;
static NSDictionary *_dictionary;
static NSDictionary *tempDictionaryFavorite;

@implementation PropertyHelper

+ (id)readFromKeysRecursively:(NSArray *)keys {
    if ([keys count] == 1) {
        return [_dictionary objectForKey:keys.firstObject];
    }
    
    NSDictionary *currentDictionary = (NSDictionary *) [self readFromKeysRecursively:[keys subarrayWithRange:NSMakeRange(0, [keys count] - 1)]];
    
    return currentDictionary[keys.lastObject];
}

+ (id)readFromKey:(NSString *)key {
    return [self readFromKeys:@[key]];
}

+ (id)readFromKeys:(NSArray *)keys {
    return [self readFromKeys:keys withPropertiesPath:@"Properties"];
}

+ (id)readFromKeys:(NSArray *)keys withPropertiesPath:(NSString *)propertiesPath {
    @synchronized([PropertyHelper class]) {
        _propertiesPath = [[NSBundle mainBundle] pathForResource:propertiesPath ofType:@"plist"];
        _dictionary = [[NSDictionary alloc] initWithContentsOfFile:_propertiesPath];
        
        return [self readFromKeysRecursively:keys];
    }
}
+ (void)setFavorite:(NSDictionary *)params{
    tempDictionaryFavorite = params;
}
+(NSDictionary *)getTempFavorite{
    return tempDictionaryFavorite;
}
@end