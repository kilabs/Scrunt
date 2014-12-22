//
//  DelimaCommonFunction.h
//  Delima
//
//  Created by Arie Prasetyo on 12/10/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DelimaCommonFunction : NSObject

+ (DelimaCommonFunction *)sharedCommonFunction;
- (NSString *) md5:(NSString *) input;
-(void)giveBorderTo:(UIView *)view
          withColor:(UIColor *)color;
-(NSString *)formatToRupiah:(NSNumber *)nominal;
-(void)giveBorderTo:(UIView *)view
         withRadius:(float)radius
    withBorderWidth:(float)width
          withColor:(UIColor *)color;

-(void)giveCornerTo:(UIView *)view
         withRadius:(float)radius;

-(void)giveBorderTo:(UIView *)view
          withColor:(UIColor *)color
   withCornerRadius:(CGFloat)cornerRadius
    withBorderWidth:(CGFloat)borderWidth;

-(BOOL) isValidEmail:(NSString *)checkString;
-(NSString *)pathForFile:(NSString *)fileName;
-(BOOL)checkIfFileExist:(NSString *)fileName;
-(void)deleteItemName:(NSString *)itemName;
-(NSString *)documentPath;
-(NSArray *)getDocumentDirectoryContents;
-(void)setAlert:(NSString *)title message:(NSString *)message;
@end
