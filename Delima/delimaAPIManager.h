//
//  delimaAPIManager.h
//  Delima
//
//  Created by Arie Prasetyo on 12/6/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface delimaAPIManager : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
