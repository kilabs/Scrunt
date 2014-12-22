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
#import "DelimaCommonFunction.h"
#import "TransferTableViewController.h"
#import "LoginViewController.h"
#import <SWRevealViewController.h>
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableData;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _segmentedControl.selectedSegmentIndex =0;
    [_segmentedControl addTarget:self
                         action:@selector(segmentedControlValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setDefaultDelimaNavigationBar];
    self.revealViewController.panGestureRecognizer.enabled=YES;
    _userActive = [User getUserProfile];
    if (![_userActive.sessionid isEqualToString:@""]) {
        [self reloadData];
    }
    else{
        UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        LoginViewController *login = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        login = nav.viewControllers[0];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
    
    
}


-(void)reloadData{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:_userActive.saldo];
    _balanceLabel.text =[NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:myNumber]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)segmentedControlValueChanged:(id)sender{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"History");
            break;
        case 1:
            NSLog(@"Favorit");
            break;
        default: 
            break; 
    }

}
@end
