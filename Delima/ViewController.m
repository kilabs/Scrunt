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
#import "TransactionHistory.h"
#import "API+CheckSaldo.h"
#import <SWRevealViewController.h>
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableData;
@property (strong, nonatomic) IBOutlet UILabel *balanceLabel;
@property (strong, nonatomic) NSArray *data;
@property (nonatomic) NSInteger state;

@end

@implementation ViewController

- (void)viewDidLoad {
    _state = 0;
    _data = [NSArray arrayWithArray:[TransactionHistory getAllHistory]];
    [_tableData reloadData];
    [_tableData reloadData];
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
        [_tableData reloadData];
        
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
    _tableData.delegate = self;
    _tableData.dataSource = self;
    [_tableData reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)segmentedControlValueChanged:(id)sender{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            _state=0;
            _data = [NSArray arrayWithArray:[TransactionHistory getAllHistory]];
            [_tableData reloadData];
            break;
        case 1:
            _state=1;
            NSLog(@"Favorit");
            break;
        default:
            break;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_tableData dequeueReusableCellWithIdentifier:@"Cell"];
    TransactionHistory *t;
    if (_state==0) {
        t = [_data objectAtIndex:indexPath.row];
    }
    else{
        
    }
    cell.textLabel.text =t.itemName;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
                    NSLog(@"_user active-->%@",_userActive);
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
                else{
                    NSLog(@"_user active before-->%@",_userActive);
                    _userActive.saldo =[[posts objectAtIndex:0]objectForKey:@"amt"];
                    _userActive.updatedAt = [NSDate date];
                    [User save:_userActive withRevision:YES];
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                    NSLog(@"sama->%@",_userActive);
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
            }
        }
    }];
}
@end
