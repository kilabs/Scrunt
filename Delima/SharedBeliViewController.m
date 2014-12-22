//
//  SharedBeliViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/13/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "SharedBeliViewController.h"
#import "Fee.h"
#import "User.h"
#import "PropertyHelper.h"
#import "DelimaCommonFunction.h"
#import "ColorHelper.h"
#import "API+BeliManager.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MBProgressHUD.h>
#import <ActionSheetStringPicker.h>
@interface SharedBeliViewController ()<ABPeoplePickerNavigationControllerDelegate,UINavigationControllerDelegate,ABPersonViewControllerDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *pilihText;
@property (strong,nonatomic)NSMutableArray *kode;
@property (strong,nonatomic)NSMutableArray *opName;
@property (strong,nonatomic)NSMutableArray *denomination;
@property (strong,nonatomic)NSArray *listDenom;
@property (nonatomic)NSInteger selectedIndex;
@property (strong, nonatomic) IBOutlet UILabel *titlelabel;
@property (strong, nonatomic) IBOutlet UITextField *opNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *denomTextfield;
@property (strong, nonatomic) IBOutlet UITextField *hargaJual;
@property (strong, nonatomic) IBOutlet UITextField *hpTujuan;
@property (strong, nonatomic) IBOutlet UIButton *buttonKirim;
@property (strong, nonatomic) NSString *prodKode;
@property (strong, nonatomic) User *sharedUser;

@end

@implementation SharedBeliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _opNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _denomTextfield.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _hargaJual.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _hpTujuan.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _hpTujuan.delegate = self;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if(![self.title isEqualToString:@"TopUp Pulsa"]){
        _titlelabel.text=@"Pilih Dealer";
    }
    
    NSArray *data = [PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:self.title];
    _denomination = [[NSMutableArray alloc]init];
    _kode = [[NSMutableArray alloc]init];
    _opName = [[NSMutableArray alloc]init];
    
    for (int i=0; i<data.count; i++) {
        NSLog(@"data->%@",[[data objectAtIndex:i]objectForKey:@"name"]);
        [_kode addObject:[[data objectAtIndex:i]objectForKey:@"kode"]];
        [_opName addObject:[[data objectAtIndex:i]objectForKey:@"name"]];
    }
    [[DelimaCommonFunction sharedCommonFunction]giveBorderTo:_buttonKirim withRadius:2 withBorderWidth:1 withColor:[UIColor delimaRedColor]];
    
}

- (IBAction)openOp:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih"
                                            rows:_opName
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           //                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _selectedIndex = selectedIndex;
                                           _opNameTextField.text=selectedValue;
                                           _prodKode =[_kode objectAtIndex:_selectedIndex];
                                           [self setPrice:[[_kode objectAtIndex:_selectedIndex]integerValue]];
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
-(void)setPrice:(int)parentCode{
    [_denomination removeAllObjects];
    _listDenom = [Fee getPriceByparentCode:parentCode];
    
    for (int i=0; i<_listDenom.count; i++) {
        Fee *c = [_listDenom objectAtIndex:i];
        [_denomination addObject:[NSString stringWithFormat:@"%ld/%ld",(long)c.basicPrice,(long)c.salePrice]];
    }
    
}
- (IBAction)openDenom:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih"
                                            rows:_denomination
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           //                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _selectedIndex = selectedIndex;
                                           _denomTextfield.text = selectedValue;
                                           Fee *c = [_listDenom objectAtIndex:selectedIndex];
                                           _hargaJual.text =[NSString stringWithFormat:@"%ld",(long)c.salePrice];
                                           NSLog(@"Selected Value: %@", selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
- (IBAction)openContact:(id)sender {
    ABPeoplePickerNavigationController *addressBookController = [[ABPeoplePickerNavigationController alloc]init];
    addressBookController.peoplePickerDelegate = self;
    [addressBookController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    addressBookController.delegate = self;
    
    addressBookController.navigationBar.tintColor = [UIColor blackColor];
    addressBookController.searchDisplayController.searchBar.tintColor = [UIColor blackColor];
    
    addressBookController.searchDisplayController.searchBar.backgroundColor = [UIColor blackColor];
    [self presentViewController:addressBookController animated:YES completion:^{
        
    }];
    addressBookController = nil;
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    ABMultiValueRef phone = ABRecordCopyValue(person, property);
    _hpTujuan.text = [[[[NSString stringWithFormat:@"%@",(__bridge NSString *)ABMultiValueCopyValueAtIndex(phone, ABMultiValueGetIndexForIdentifier(phone, identifier))] stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"-" withString:@""]stringByReplacingOccurrencesOfString:@"+62" withString:@"0"];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    ABPersonViewController *controller = [[ABPersonViewController alloc] init];
    controller.displayedPerson = person;
    controller.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonEmailProperty]];
    controller.personViewDelegate = self;
    [peoplePicker pushViewController:controller animated:YES];
    return NO;
}

-(BOOL)personViewController:(ABPersonViewController *)personViewController
shouldPerformDefaultActionForPerson:(ABRecordRef)person
                   property:(ABPropertyID)property
                 identifier:(ABMultiValueIdentifier)identifierForValue
{
    ABMutableMultiValueRef multiEmail = ABRecordCopyValue(person, property);
    
    NSString *emailAddress = (__bridge NSString *) ABMultiValueCopyValueAtIndex(multiEmail, identifierForValue);
    
    NSLog(@"strEmail %@",emailAddress);
    
    ABPeoplePickerNavigationController *peoplePicker = (ABPeoplePickerNavigationController *)personViewController.navigationController;
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSString *phoneStr = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phones, 0);
    
    //strip number from brakets
    NSMutableString *tmpStr1 = [NSMutableString stringWithFormat:@"%@", phoneStr];
    NSString *strippedStr1 = [tmpStr1 stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"()-"];
    strippedStr1 = [[strippedStr1 componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    
    
    _hpTujuan.text = [strippedStr1 stringByReplacingOccurrencesOfString:@"+62" withString:@"0"];
    
    //dismiss
    if (![strippedStr1 isEqualToString:@"null"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
    return NO;
}
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)sendToServer:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _sharedUser = [User getUserProfile];
    int randNum = rand() % (111111 - 999999) + 0000000;
    NSDictionary *params = @{@"uname":_sharedUser.uname,
                             @"passwd":[[DelimaCommonFunction sharedCommonFunction]md5:_sharedUser.passwd],
                             @"mercode":_sharedUser.merchantCode,
                             @"mernumber":_sharedUser.merNumber,
                             @"terminal":_sharedUser.terminal,
                             @"traxId":[NSString stringWithFormat:@"%d",randNum],
                             @"prodcode":_prodKode,
                             @"recipientNumber":_hpTujuan.text,
                             @"billNumber":_hpTujuan.text,
                             @"bit61":_hpTujuan.text,
                             @"amount":_hargaJual.text,
                             @"feeadmin":@"1000",
                             @"idx":@"3",
                             @"ref":_sharedUser.ref
                             };
    
    [API_BeliManager purchase:params p:^(NSArray *posts, NSError *error) {
        if (!error) {
           
        }
    }];
    
}

@end

