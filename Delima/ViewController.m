//
//  ViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/5/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "BarHelper.h"
#import "TransferTableViewController.h"
#import "LoginViewController.h"
#import <SWRevealViewController.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setDefaultDelimaNavigationBar];
    self.revealViewController.panGestureRecognizer.enabled=YES;
    _userActive = [User getUserProfile];
    if (![_userActive.sessionid isEqualToString:@""]) {
    }
    else{
        UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        LoginViewController *login = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        login = nav.viewControllers[0];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
