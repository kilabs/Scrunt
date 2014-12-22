//
//  SharedBayarDetailViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/13/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "SharedBayarDetailViewController.h"
#import "PropertyHelper.h"
#import "ColorHelper.h"
#import <MBProgressHUD.h>
#import "User.h"
#import "API+BayarManager.h"
#import "DelimaCommonFunction.h"
#import "InquiryViewController.h"
#import <ActionSheetStringPicker.h>
@interface SharedBayarDetailViewController ()
@property (strong, nonatomic) IBOutlet UITextField *vendorText;
@property (strong, nonatomic) IBOutlet UITextField *noPelanggan;
@property (strong,nonatomic)NSMutableArray *opName;
@property (strong,nonatomic)NSMutableArray *kode;
@property (strong, nonatomic) IBOutlet UIButton *buttonKirim;
@property (strong, nonatomic) NSString *prodKode;
@property (strong, nonatomic) User *sharedUser;

@end

@implementation SharedBayarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _vendorText.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _noPelanggan.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    NSArray *data = [PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:self.title];
    _opName = [[NSMutableArray alloc]init];
    _kode = [[NSMutableArray alloc]init];
    for (int i=0; i<data.count; i++) {
        [_kode addObject:[[data objectAtIndex:i]objectForKey:@"kode"]];
        [_opName addObject:[[data objectAtIndex:i]objectForKey:@"name"]];
    }
    [[DelimaCommonFunction sharedCommonFunction]giveBorderTo:_buttonKirim withRadius:2 withBorderWidth:1 withColor:[UIColor delimaRedColor]];
}
- (IBAction)openActionSheet:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih"
                                            rows:_opName
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           //                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _vendorText.text = selectedValue;
                                           _prodKode =[_kode objectAtIndex:selectedIndex];
                                           NSLog(@"Selected Value: %@", selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
    
    
}
- (IBAction)sendToServer:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _sharedUser = [User getUserProfile];
    int randNum = rand() % (111111 - 999999) + 0000000;
    NSDictionary *params = @{@"uname":_sharedUser.uname,
                             @"amount":@"1",
                             @"passwd":_sharedUser.passwd,
                             @"mercode":_sharedUser.merchantCode,
                             @"mernumber":[NSString stringWithFormat:@"+%@",_sharedUser.merNumber],
                             @"terminal":_sharedUser.terminal,
                             @"traxId":[NSString stringWithFormat:@"%d",randNum],
                             @"prodcode":_prodKode,
                             @"recipientNumber":_noPelanggan.text,
                             @"billNumber":_noPelanggan.text,
                             @"bit61":_noPelanggan.text,
                             @"feeadmin":@"1",
                             @"idx":@"1",
                             @"ref":_sharedUser.ref
                             };
    [API_BayarManager paid:params p:^(NSArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIStoryboard *s = [UIStoryboard storyboardWithName:@"Inquiry" bundle:nil];
                
                UINavigationController *nav = [s instantiateViewControllerWithIdentifier:@"InvoiceNavigationController"];
                InquiryViewController *purchaseContr = (InquiryViewController *)[s instantiateViewControllerWithIdentifier:@"InquiryViewController"];
                
                purchaseContr.bit61 =[[posts objectAtIndex:0]objectForKey:@"bit61"];
                purchaseContr.prodCode = _prodKode;
                purchaseContr.prodName =_vendorText.text;
                purchaseContr.fee =[[posts objectAtIndex:0]objectForKey:@"feeAdm"];
                purchaseContr.namaMitraString = _vendorText.text;
                purchaseContr.noPelanggannamaMitraString = [[posts objectAtIndex:0]objectForKey:@"billNumber"];
                purchaseContr.namaPelanggannamaMitraString = [[posts objectAtIndex:0]objectForKey:@"recipientName"];
                int postData;
                postData = [[[posts objectAtIndex:0]objectForKey:@"feeAdm"]integerValue]+[[[posts objectAtIndex:0]objectForKey:@"feeAmount"]integerValue];
                purchaseContr.noTujuannamaMitraString = [NSString stringWithFormat:@"%d",postData];
                int total = [[[posts objectAtIndex:0]objectForKey:@"amount"]integerValue];
                purchaseContr.harganamaMitraString =[NSString stringWithFormat:@"%d",total];
                nav.viewControllers =@[purchaseContr];
                [self presentViewController:nav animated:YES completion:nil];
            }
            else{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
        }
    }];
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
