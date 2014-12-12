//
//  AppDelegate.m
//  Delima
//
//  Created by Arie Prasetyo on 12/5/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LeftViewController.h"
#import "LoginViewController.h"
#import <Realm.h>
#import "ColorHelper.h"
#import <SWRevealViewController.h>
@interface AppDelegate ()

@end
@interface AppDelegate()<SWRevealViewControllerDelegate>
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIFont *defaultFontType = [UIFont fontWithName:@"Avenir Next"
                                              size:15];
    
    NSDictionary *defaultFontAttributes = [NSDictionary dictionaryWithObject:defaultFontType
                                                                      forKey:NSFontAttributeName];
    
    //  Title font configuration
    UIFont *titleFontType = [UIFont fontWithName:@"Avenir Next"
                                            size:17];
    
    NSDictionary *titleFontAttributes = [NSDictionary dictionaryWithObjects:@[titleFontType, [UIColor whiteColor]]
                                                                    forKeys:@[NSFontAttributeName, NSForegroundColorAttributeName]];
    
    //  Segmented control configuration
    [[UISegmentedControl appearance] setTitleTextAttributes:defaultFontAttributes
                                                   forState:UIControlStateNormal];
    
    //  Navigation bar configuration
    [[UINavigationBar appearance] setBarTintColor:[UIColor delimaRedColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:titleFontAttributes];
    
    //  Navigation bar button item configuration
    [[UIBarButtonItem appearance] setTitleTextAttributes:defaultFontAttributes
                                                forState:UIControlStateNormal];
    
    //  Back button configuration
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    UIImage *originalBackButtonImage = [UIImage imageNamed:@"icon-back.png"];
    CGSize backButtonSize = CGSizeMake(33, 33);
    UIGraphicsBeginImageContextWithOptions(backButtonSize, NO, 0.0);
    [originalBackButtonImage drawInRect:CGRectMake(0, 0, backButtonSize.width, backButtonSize.height)];
    UIImage *backButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    backButtonImage = [backButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 33, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
