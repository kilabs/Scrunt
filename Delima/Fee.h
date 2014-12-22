//
//  Fee.h
//  Delima
//
//  Created by Arie Prasetyo on 12/16/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "RLMObject.h"

@interface Fee : RLMObject
@property NSInteger id;
@property NSString *guid;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property NSInteger parentCode;
@property NSInteger basicPrice;
@property NSInteger salePrice;
+(NSArray *)getPriceByparentCode:(NSInteger)parentCode;
+ (void)save:(Fee *)fee withRevision:(BOOL)revision;
+ (void)setCelullarFee;
+ (void)setGameFee;

@end
