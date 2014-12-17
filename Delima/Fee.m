//
//  Fee.m
//  Delima
//
//  Created by Arie Prasetyo on 12/16/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "Fee.h"
#import "Config.h"
#import <Realm.h>
#import "RealmManager.h"
#import "PropertyHelper.h"
@implementation Fee
+ (NSDictionary *)defaultPropertyValues {
    /*
     @property NSInteger id;
     @property NSString *guid;
     @property NSDate *createdAt;
     @property NSDate *updatedAt;
     @property NSInteger parentCode;
     @property NSInteger basicPrice;
     @property NSInteger salePrice;
     
     */
    return @{@"id" : @0,
             @"guid" : [[NSProcessInfo processInfo] globallyUniqueString],
             @"createdAt" : [NSDate date],
             @"updatedAt" : [NSDate date],
             @"parentCode" : @0,
             @"basicPrice" : @0,
             @"salePrice" : @0,
             };
}
+ (void)setCelullarFee{
    NSArray *data = [NSArray arrayWithArray:[PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:@"TopUp Pulsa"]];
    for (int i=0;i<data.count; i++) {
        
        NSArray *detail =[PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:[[data objectAtIndex:i]objectForKey:@"kode"]];
        for (int x=0; x<detail.count; x++) {
            Fee *f = [[Fee alloc]init];
            f.parentCode =[[[data objectAtIndex:i]objectForKey:@"kode"]integerValue];
            f.basicPrice =[[[detail objectAtIndex:x]objectForKey:@"kode"]integerValue];
            f.salePrice =[[[detail objectAtIndex:x]objectForKey:@"sell_price"]integerValue];
            [Fee save:f withRevision:NO];
        }
    }
    
    [Fee setGameFee];
}

+(void)setGameFee{
    
    NSArray *data = [NSArray arrayWithArray:[PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:@"Voucher Game"]];
    for (int i=0;i<data.count; i++) {
        
        NSArray *detail =[PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:[[data objectAtIndex:i]objectForKey:@"kode"]];
        for (int x=0; x<detail.count; x++) {
            Fee *f = [[Fee alloc]init];
            f.parentCode =[[[data objectAtIndex:i]objectForKey:@"kode"]integerValue];
            f.basicPrice =[[[detail objectAtIndex:x]objectForKey:@"kode"]integerValue];
            f.salePrice =[[[detail objectAtIndex:x]objectForKey:@"sell_price"]integerValue];
            [Fee save:f withRevision:NO];
        }
    }
    
    Config *c = [[Config alloc]init];
    c.isAlreadyLocalSync = YES;
    [Config save:c withRevision:YES];
    NSLog(@"done");
}
+ (NSString *)primaryKey {
    return @"guid";
}

+(void)save:(Fee *)fee withRevision:(BOOL)revision{
    fee = [[Fee alloc]initWithObject:fee];
    [[RealmManager sharedMORealmSingleton].realm beginWriteTransaction];
    //    if (revision) [MOUserProfile saveToRevision:userProfile];
    [[RealmManager sharedMORealmSingleton].realm addOrUpdateObject:fee];
    [[RealmManager sharedMORealmSingleton].realm commitWriteTransaction];
}

+(NSArray *)getPriceByparentCode:(NSInteger)parentCode{
    RLMResults *objects = [Fee objectsWhere:@"parentCode = %d",parentCode];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:objects.count];
    for(id object in objects) {
        Fee *item = [[Fee alloc] initWithObject:object];
        [mutableArray addObject:item];
    }
    
    return mutableArray;
}
@end
