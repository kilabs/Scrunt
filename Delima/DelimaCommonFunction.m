//
//  DelimaCommonFunction.m
//  Delima
//
//  Created by Arie Prasetyo on 12/10/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "DelimaCommonFunction.h"
#import <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
@implementation DelimaCommonFunction

+ (DelimaCommonFunction *)sharedCommonFunction{
    static dispatch_once_t pred;
    static DelimaCommonFunction *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[DelimaCommonFunction alloc] init];
    });
    return shared;
}
-(void)giveBorderTo:(UIView *)view
          withColor:(UIColor *)color{
    CALayer *layer = view.layer;
    [layer setCornerRadius:10];
    [layer setBorderWidth:0.5];
    layer.borderColor=[color CGColor];
}

-(void)giveBorderTo:(UIView *)view
          withColor:(UIColor *)color
   withCornerRadius:(CGFloat)cornerRadius
    withBorderWidth:(CGFloat)borderWidth{
    CALayer *layer = view.layer;
    [layer setCornerRadius:cornerRadius];
    [layer setBorderWidth:borderWidth];
    layer.borderColor=[color CGColor];
}

-(void)giveCornerTo:(UIView *)view
         withRadius:(float)radius{
    CALayer *layer = view.layer;
    [layer setCornerRadius:radius];
}


-(void)giveBorderTo:(UIView *)view
         withRadius:(float)radius
    withBorderWidth:(float)width
          withColor:(UIColor *)color{
    CALayer *layer = view.layer;
    [layer setCornerRadius:radius];
    [layer setBorderWidth:width];
    layer.borderColor=[color CGColor];
}

-(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (NSString *) md5:(NSString *) input{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}
-(NSString *)documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSString *)pathForFile:(NSString *)fileName{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:fileName];
    return filePath;
}

-(BOOL)checkIfFileExist:(NSString *)fileName{
    return [[NSFileManager defaultManager] fileExistsAtPath:[self pathForFile:fileName]];
}

-(NSArray *)getDocumentDirectoryContents{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self documentPath] error:nil];
}

-(void)deleteItemName:(NSString *)itemName{
    [[NSFileManager defaultManager]removeItemAtPath:[self pathForFile:itemName] error:nil];
}


-(void)setAlert:(NSString *)title message:(NSString *)message{
    NSLog(@"title->%@",title);
    NSLog(@"title->%@",message);
    
}
@end
