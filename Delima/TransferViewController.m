//
//  TransferViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/13/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "TransferViewController.h"
#import "PropertyHelper.h"
#import "DelimaCommonFunction.h"
#import "User.h"
#import "API+TransferBankManager.h"
#import <ActionSheetStringPicker.h>
#import <JVFloatLabeledTextField.h>
@interface TransferViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)NSMutableArray *dataBank;
@property (nonatomic,strong)NSMutableArray *dataBankCode;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *bankCode;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *phoneText;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *nominal;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *berita;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *noRekening;
@property (nonatomic) NSInteger selectedIndex;
@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bankCode.delegate = self;
    _phoneText.delegate =self;
    _nominal.delegate = self;
    _berita.delegate = self;
    _noRekening.delegate = self;
    _dataBank = [[NSMutableArray alloc]init];
    _dataBankCode = [[NSMutableArray alloc]init];
    NSArray *data=[PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:@"bank"];
    for (int i=0; i<data.count; i++) {
        [_dataBankCode addObject:[[data objectAtIndex:i]objectForKey:@"kode"]];
        [_dataBank addObject:[[data objectAtIndex:i]objectForKey:@"name"]];
    }
    
    
    
}
- (IBAction)openListBank:(UITextField *)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih Bank"
                                            rows:_dataBank
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _selectedIndex = selectedIndex;
                                           NSLog(@"Selected Value: %@", selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postToServer:(id)sender {
    _user = [User getUserProfile];
    NSDictionary *params = @{@"uname":_user.uname,
                             @"passwd":[[DelimaCommonFunction sharedCommonFunction]md5:_user.passwd],
                             @"merCode":_user.merchantCode,
                             @"mernumber":_user.merNumber,
                             @"terminal":_user.terminal,
                             @"senderName":_user.uname,
                             @"recipientPhone":_phoneText.text,
                             @"norek":_noRekening.text,
                             @"kodeBank":[_dataBankCode objectAtIndex:_selectedIndex],
                             @"destAmount":_nominal.text,
                             @"description":_berita.text,
                             @"idx":@"1",
                             @"ref":_user.ref
                             };
    [API_TransferBankManager transfer:params login:^(NSArray *posts, NSError *error) {
        
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
