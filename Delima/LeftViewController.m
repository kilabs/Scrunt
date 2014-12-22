//
//  LeftViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/5/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "LeftViewController.h"
#import "MenuCell.h"
#import "ColorHelper.h"
#import "CashInViewController.h"
#import "ViewController.h"
#import "ViewController.h"
#import "TransferTableViewController.h"
#import "HistoryTableViewController.h"
#import "BayarListTableViewController.h"
#import "BeliListTableViewController.h"
#import <SWRevealViewController.h>
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableVIew;
@property (strong,nonatomic) NSArray *menu;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableVIew.delegate = self;
    _tableVIew.dataSource  =self;
    _tableVIew.tableFooterView = [[UIView alloc]init];
    _tableVIew.backgroundColor = [UIColor delimaDarkGrayColor];
    _tableVIew.backgroundView.backgroundColor = [UIColor delimaDarkGrayColor];
    _menu = [NSArray arrayWithObjects:@"Home",@"Isi Saldo",@"Transfer",@"Beli",@"Bayar",@"History Online",@"Profil & Pengaturan",@"Logout", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _menu.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuCell *cell = [_tableVIew dequeueReusableCellWithIdentifier:@"Cell"];
    cell.menuName.text = [_menu objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UINavigationController *nav = (UINavigationController *) self.revealViewController.frontViewController;
    UIStoryboard *storyBoard;
    if (indexPath.row==0) {
        // Get the storyboard named secondStoryBoard from the main bundle:
         storyBoard= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        nav.viewControllers = [NSArray arrayWithObjects:controller, nil];
        // Then push the new view controller in the usual way:
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }
    
    if (indexPath.row==1) {
        // Get the storyboard named secondStoryBoard from the main bundle:
       storyBoard = [UIStoryboard storyboardWithName:@"Cashin" bundle:nil];
        CashInViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"CashInViewController"];
        nav.viewControllers = [NSArray arrayWithObjects:controller, nil];
        // Then push the new view controller in the usual way:
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }
    if (indexPath.row==2) {
        // Get the storyboard named secondStoryBoard from the main bundle:
        storyBoard = [UIStoryboard storyboardWithName:@"Transfer" bundle:nil];
        TransferTableViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"TransferTable"];
        nav.viewControllers = [NSArray arrayWithObjects:controller, nil];
        // Then push the new view controller in the usual way:
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }
    if (indexPath.row==3) {
        // Get the storyboard named secondStoryBoard from the main bundle:
        storyBoard = [UIStoryboard storyboardWithName:@"Beli" bundle:nil];
        BeliListTableViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"BeliList"];
        nav.viewControllers = [NSArray arrayWithObjects:controller, nil];
        // Then push the new view controller in the usual way:
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }
    if (indexPath.row==4) {
        // Get the storyboard named secondStoryBoard from the main bundle:
        storyBoard = [UIStoryboard storyboardWithName:@"Bayar" bundle:nil];
        BayarListTableViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"BayarList"];
        nav.viewControllers = [NSArray arrayWithObjects:controller, nil];
        // Then push the new view controller in the usual way:
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }
    if (indexPath.row==5) {
        // Get the storyboard named secondStoryBoard from the main bundle:
        storyBoard = [UIStoryboard storyboardWithName:@"History" bundle:nil];
        BayarListTableViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"HistoryTableViewController"];
        nav.viewControllers = [NSArray arrayWithObjects:controller, nil];
        // Then push the new view controller in the usual way:
        [self.revealViewController pushFrontViewController:nav animated:YES];
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
