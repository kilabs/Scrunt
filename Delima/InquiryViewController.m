//
//  InquiryViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/22/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "InquiryViewController.h"
#import "PropertyHelper.h"
#import "ColorHelper.h"
#import <MBProgressHUD.h>
#import "User.h"
#import "API+BayarManager.h"
#import "InvoiceViewController.h"
#import "DelimaCommonFunction.h"
#import "InquiryViewController.h"
#import "API+CashIn.h"
#import <ActionSheetStringPicker.h>

@interface InquiryViewController ()
@property (strong, nonatomic) IBOutlet UILabel *namaMitra;
@property (strong, nonatomic) IBOutlet UILabel *tanggal;

@property (strong, nonatomic) IBOutlet UILabel *noPelanggan;
@property (strong, nonatomic) IBOutlet UILabel *namaPelanggan;
@property (strong, nonatomic) IBOutlet UILabel *jumlahBulan;
@property (strong, nonatomic) IBOutlet UILabel *noTujuan;
@property (strong, nonatomic) IBOutlet UILabel *harga;
@property (strong, nonatomic) User *sharedUser;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@end

@implementation InquiryViewController
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _namaMitra.text = _namaMitraString;
    _tanggal.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    _noPelanggan.text = _noPelanggannamaMitraString;
    _namaPelanggan.text =_namaPelanggannamaMitraString;
    _jumlahBulan.text = _jumlahBulannamaMitraString;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * feeNumber = [f numberFromString:_noTujuannamaMitraString];
    NSNumber * hargaNumber = [f numberFromString:_harganamaMitraString];
    _noTujuan.text =[NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:feeNumber]];
    _harga.text = [NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:hargaNumber]];;
    // Do any additional setup after loading the view.
}
- (IBAction)submitToServer:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _sharedUser = [User getUserProfile];
    
    if(_bit61)
    {
        int randNum = rand() % (111111 - 999999) + 0000000;
        NSDictionary *params = @{@"uname":_sharedUser.uname,
                                 @"amount":@"1",
                                 @"passwd":_sharedUser.passwd,
                                 @"mercode":_sharedUser.merchantCode,
                                 @"mernumber":[NSString stringWithFormat:@"+%@",_sharedUser.merNumber],
                                 @"terminal":_sharedUser.terminal,
                                 @"traxId":[NSString stringWithFormat:@"%d",randNum],
                                 @"prodcode":_prodCode,
                                 @"recipientNumber":_noPelanggan.text,
                                 @"billNumber":_noPelanggan.text,
                                 @"bit61":_bit61,
                                 @"feeadmin":_fee,
                                 @"idx":@"3",
                                 @"ref":_sharedUser.ref
                                 };
        [API_BayarManager paid:params p:^(NSArray *posts, NSError *error) {
            if (!error) {
                if(posts.count !=0){
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Invoice" bundle:nil];
                    UINavigationController *nav = [s instantiateViewControllerWithIdentifier:@"InvoiceNavigationController"];
                    InvoiceViewController *purchaseContr = (InvoiceViewController *)[s instantiateViewControllerWithIdentifier:@"InvoiceViewController"];
                    purchaseContr.feeText = _noTujuannamaMitraString;
                    purchaseContr.namaMitraString = _sharedUser.uname;
                    purchaseContr.noTujuanString = _noPelanggannamaMitraString;
                    
                    purchaseContr.itemString = _prodName;
                    purchaseContr.namaPelanggan = _namaPelanggannamaMitraString;
                    purchaseContr.hargaText = _harganamaMitraString;
                    nav.viewControllers =@[purchaseContr];
                    [self presentViewController:nav animated:YES completion:nil];
                }
                else{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
            }
        }];
    }
    else if(_sessionid){
        NSDictionary *params = @{@"uname":_sharedUser.uname,
                                 @"amount":_harga.text,
                                 @"passwd":_sharedUser.passwd,
                                 @"mercode":_sharedUser.merchantCode,
                                 @"mernumber":[NSString stringWithFormat:@"+%@",_sharedUser.merNumber],
                                 @"terminal":_sharedUser.terminal,
                                 @"traxId":_trxId,
                                 @"recName":_namaPelanggan.text,
                                 @"feeAdm":_noTujuan.text,
                                 @"prodcode":_prodCode,
                                 @"recipientNumber":_noPelanggan.text,
                                 @"billNumber":_noPelanggan.text,
                                 @"sessionid":_sessionid,
                                 };
        NSLog(@"params->%@",params);
        [API_CashIn cashIn:params p:^(NSArray *posts, NSError *error){
            if (!error) {
                if(posts.count !=0){
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    UIStoryboard *s = [UIStoryboard storyboardWithName:@"Invoice" bundle:nil];
                    UINavigationController *nav = [s instantiateViewControllerWithIdentifier:@"InvoiceNavigationController"];
                    InvoiceViewController *purchaseContr = (InvoiceViewController *)[s instantiateViewControllerWithIdentifier:@"InvoiceViewController"];
                    purchaseContr.feeText = _noTujuannamaMitraString;
                    purchaseContr.namaMitraString = _sharedUser.uname;
                    purchaseContr.noTujuanString = _noPelanggannamaMitraString;
                    
                    purchaseContr.itemString = _prodName;
                    purchaseContr.namaPelanggan = _namaPelanggannamaMitraString;
                    purchaseContr.hargaText = _harganamaMitraString;
                    nav.viewControllers =@[purchaseContr];
                    [self presentViewController:nav animated:YES completion:nil];
                }
                else{
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                }
            }
        }];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
