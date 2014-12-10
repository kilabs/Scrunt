//
//  DelimaCommonFunction.h
//  Delima
//
//  Created by Arie Prasetyo on 12/10/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DelimaCommonFunction : NSObject

+ (NSString *)osVersionBuild;
+ (DelimaCommonFunction *)sharedCommonFunction;
- (NSString *) md5:(NSString *) input;
@end
