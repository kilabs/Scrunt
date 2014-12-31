//
//  CashInViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/13/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "CashInViewController.h"
#import "BarHelper.h"
#import "User.h"
#import <MBProgressHUD.h>
#import "API+CashIn.h"
#import "InquiryViewController.h"
@interface CashInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nomorTujuan;
@property (strong, nonatomic) IBOutlet UITextField *nominal;
@property (strong, nonatomic) IBOutlet UIButton *kirimButton;

@end

@implementation CashInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nomorTujuan.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _nominal.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self setDefaultDelimaNavigationBar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendToServer:(id)sender {
    _sharedUser = [User getUserProfile];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{@"amount":_nominal.text,
                             @"passwd":_sharedUser.passwd,
                             @"terminal":_sharedUser.terminal,
                             @"mercode":_sharedUser.merchantCode,
                             @"uname":_sharedUser.uname,
                             @"sessionid":_sharedUser.sessionid,
                             @"mernumber":[NSString stringWithFormat:@"+%@",_sharedUser.merNumber],
                             @"recipientNumber":_nomorTujuan.text
                             };
     NSLog(@"_shared user->%@",_sharedUser);
     NSLog(@"_shared user->%@",params);
    [API_CashIn cashIn:params p:^(NSArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){

                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIStoryboard *s = [UIStoryboard storyboardWithName:@"Inquiry" bundle:nil];
                
                UINavigationController *nav = [s instantiateViewControllerWithIdentifier:@"InvoiceNavigationController"];
                InquiryViewController *purchaseContr = (InquiryViewController *)[s instantiateViewControllerWithIdentifier:@"InquiryViewController"];
                
                purchaseContr.sessionid = @"13";
                purchaseContr.prodCode = [[posts objectAtIndex:0]objectForKey:@"productCode"];
                purchaseContr.prodName =@"Transfer Saldo";
                purchaseContr.fee =[[posts objectAtIndex:0]objectForKey:@"feeAmount"];
                purchaseContr.namaMitraString = _sharedUser.uname,
                purchaseContr.noPelanggannamaMitraString = [[posts objectAtIndex:0]objectForKey:@"recipientNumber"];
                purchaseContr.namaPelanggannamaMitraString = [[posts objectAtIndex:0]objectForKey:@"recipientName"];
                purchaseContr.jumlahBulannamaMitraString = @"0";
                
                int postData;
                postData = [[[posts objectAtIndex:0]objectForKey:@"feeAmount"]integerValue]+[[[posts objectAtIndex:0]objectForKey:@"amount"]integerValue];
                
                purchaseContr.noTujuannamaMitraString = [[posts objectAtIndex:0]objectForKey:@"feeAmount"];
                purchaseContr.trxId =[[posts objectAtIndex:0]objectForKey:@"traxId"];
              //  int total = [[[posts objectAtIndex:0]objectForKey:@"amount"]integerValue];
                
                purchaseContr.harganamaMitraString =[[posts objectAtIndex:0]objectForKey:@"amount"];
                
                nav.viewControllers =@[purchaseContr];
                [self presentViewController:nav animated:YES completion:nil];
            }
            else{

                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
        }
    }];
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
