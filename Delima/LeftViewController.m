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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
