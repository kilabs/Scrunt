//
//  ViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/5/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import <MBProgressHud.h>
#import "BarHelper.h"
#import "DelimaCommonFunction.h"
#import "TransferTableViewController.h"
#import "LoginViewController.h"
#import "SharedBayarDetailViewController.h"
#import "SharedBeliViewController.h"
#import "TransactionHistory.h"
#import "API+CheckSaldo.h"
#import <AMSmoothAlertView.h>
#import <AMSmoothAlertConstants.h>
#import <SWRevealViewController.h>
#import "HomeTableViewCell.h"
#import "Favorite.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,AMSmoothAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableData;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) AMSmoothAlertView *alert;
@property (nonatomic) NSInteger state;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _userActive = [User getUserProfile];
    if (![_userActive.sessionid isEqualToString:@""]) {
        [self reloadData];
        [_tableData reloadData];
        [self reloadData:nil];
        
    }
    else{
        UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        LoginViewController *login = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        login = nav.viewControllers[0];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
    // Do any additional setup after loading the view, typically from a nib.
    _state = 0;
    self.revealViewController.panGestureRecognizer.enabled=YES;
    _data = [NSArray arrayWithArray:[TransactionHistory getAllHistory]];
    [_tableData reloadData];
    [_tableData reloadData];
    
    _tableData.tableFooterView = [[UIView alloc]init];
    self.view.backgroundColor =[UIColor whiteColor];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self setDefaultDelimaNavigationBar];
    self.revealViewController.panGestureRecognizer.enabled=YES;
    
    
}


-(void)reloadData{
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:_userActive.saldo];
    _balanceLabel.text =[NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:myNumber]];
    _tableData.delegate = self;
    _tableData.dataSource = self;
    [_tableData reloadData];
}
- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender {
    NSLog(@"data-->%d",_segmentedControl.selectedSegmentIndex);
    switch (_segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _state=0;
            _data = [NSArray arrayWithArray:[TransactionHistory getAllHistory]];
            [_tableData reloadData];
            break;
        case 1:
            _state=1;
            _data = [NSArray arrayWithArray:[Favorite getAllFavorite]];
            [_tableData reloadData];
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [_tableData dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (_state==0) {
        cell.transaction = [_data objectAtIndex:indexPath.row];
    }
    else{
        cell.favorite = [_data objectAtIndex:indexPath.row];
    }
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_state==0) {
        TransactionHistory *t;
        t = [_data objectAtIndex:indexPath.row];
        [self openPopup:t.keterangan];
    }
    else{
        Favorite *f = [_data objectAtIndex:indexPath.row];
        UIStoryboard *storyBoard;
        // Get the storyboard named secondStoryBoard from the main bundle:
        if([f.storyboardName isEqualToString:@"Beli"]){
            storyBoard= [UIStoryboard storyboardWithName:f.storyboardName bundle:nil];
            SharedBeliViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:f.controllerName];
            controller.title = f.title;
            controller.passingDataTujuan = f.recipientNumber;
            controller.passingDataDenom = f.denom;
            controller.passingDataHargaJual = f.hargaJual;
            controller.passingDataVendorName = f.itemName;
            controller.prodKode = f.prodcode;
            controller.hargaDasar = f.hargaDasar;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else if ([f.storyboardName isEqualToString:@"Bayar"]){
            storyBoard= [UIStoryboard storyboardWithName:f.storyboardName bundle:nil];
            SharedBayarDetailViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:f.controllerName];
            controller.title = f.title;
            controller.passingDataVendorName= f.itemName;
            controller.passingDataDenom = f.denom;
            controller.passingDataHargaJual = f.hargaJual;
            controller.passingDataTujuan = f.recipientNumber;
            controller.prodKode = f.prodcode;
            [self.navigationController pushViewController:controller animated:YES];
        }
        
        
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}
- (IBAction)reloadData:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{
                             @"uname":_userActive.uname,
                             @"passwd":_userActive.passwd,
                             @"terminal":_userActive.terminal,
                             @"mernumber":[NSString stringWithFormat:@"+%@",_userActive.merNumber],
                             @"mercode":_userActive.merchantCode,
                             
                             };
    [API_CheckSaldo checkSaldo:params p:^(NSArray *posts, NSError *error) {
        if(!error){
            if (posts.count>0) {
                
                if(![_userActive.saldo isEqualToString:[[[posts objectAtIndex:0]objectForKey:@"amt"] stringByReplacingOccurrencesOfString:@"\"" withString:@""]]){
                    _userActive.saldo =[[posts objectAtIndex:0]objectForKey:@"amt"];
                    [User save:_userActive withRevision:YES];
                    [self reloadData];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
                else{
                    _userActive.saldo =[[posts objectAtIndex:0]objectForKey:@"amt"];
                    _userActive.updatedAt = [NSDate date];
                    [User save:_userActive withRevision:YES];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self reloadData];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
            }
        }
        else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    }];
}


////alert

- (void)openPopup:(NSString *)message {
    _alert = [[AMSmoothAlertView alloc]initDropAlertWithTitle:@"Histori" andText:message andCancelButton:NO forAlertType:AlertSuccess];
    _alert.delegate = self;
    [_alert.defaultButton setTitle:@"Tutup" forState:UIControlStateNormal];
    _alert.completionBlock = ^void (AMSmoothAlertView *alertObj, UIButton *button) {
        if(button == alertObj.defaultButton) {
            NSLog(@"Default");
        } else {
            NSLog(@"Others");
        }
    };
    [_alert show];
}

#pragma mark - Delegates
- (void)alertView:(AMSmoothAlertView *)alertView didDismissWithButton:(UIButton *)button {
    if (alertView == _alert) {
        if (button == _alert.defaultButton) {
            NSLog(@"Default button touched!");
        }
        if (button == _alert.cancelButton) {
            NSLog(@"Cancel button touched!");
        }
    }
}

- (void)alertViewWillShow:(AMSmoothAlertView *)alertView {
    if (alertView.tag == 0)
        NSLog(@"AlertView Will Show: '%@'", alertView.titleLabel.text);
}

- (void)alertViewDidShow:(AMSmoothAlertView *)alertView {
    NSLog(@"AlertView Did Show: '%@'", alertView.titleLabel.text);
}

- (void)alertViewWillDismiss:(AMSmoothAlertView *)alertView {
    NSLog(@"AlertView Will Dismiss: '%@'", alertView.titleLabel.text);
}

- (void)alertViewDidDismiss:(AMSmoothAlertView *)alertView {
    NSLog(@"AlertView Did Dismiss: '%@'", alertView.titleLabel.text);
}

@end
