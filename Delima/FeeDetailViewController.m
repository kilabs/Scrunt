//
//  FeeDetailViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/22/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "FeeDetailViewController.h"
#import "Fee.h"
#import "ColorHelper.h"
#import "PropertyHelper.h"
#import "DelimaCommonFunction.h"
#import <ActionSheetStringPicker.h>
#import <MBProgressHUD.h>
@interface FeeDetailViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *vendorTextField;
@property (strong, nonatomic) IBOutlet UITextField *denomTextField;
@property (strong, nonatomic) IBOutlet UITextField *hargaJual;
@property (strong, nonatomic) IBOutlet UIButton *simpanButton;
@property (nonatomic,strong)NSMutableArray *vendor;
@property (nonatomic,strong)NSMutableArray *kode;
@property (nonatomic,strong)NSMutableArray *nominal;
@property (strong,nonatomic)NSArray *listDenom;
@property (strong, nonatomic) NSString *prodKode;
@property (nonatomic) NSInteger idItems;
@property (nonatomic) NSInteger basicPrice;
@property (strong, nonatomic) Fee *f;
@property (strong, nonatomic) MBProgressHUD *hud;


@end

@implementation FeeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _f = [[Fee alloc]init];
    _vendorTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _vendorTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _hargaJual.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _hargaJual.delegate = self;
    NSArray *data ;
    _nominal = [[NSMutableArray alloc]init];
    _kode = [[NSMutableArray alloc]init];
    _vendor = [[NSMutableArray alloc]init];
    if(_isCelular){
        
        data = [PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:@"TopUp Pulsa"];
        
    }
    else{
        data = [PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:@"Voucher Game"];
    }
    for (int i=0; i<data.count; i++) {
        NSLog(@"data->%@",[[data objectAtIndex:i]objectForKey:@"name"]);
        [_kode addObject:[[data objectAtIndex:i]objectForKey:@"kode"]];
        [_vendor addObject:[[data objectAtIndex:i]objectForKey:@"name"]];
    }
    [[DelimaCommonFunction sharedCommonFunction]giveBorderTo:_simpanButton withRadius:2 withBorderWidth:1 withColor:[UIColor delimaRedColor]];
    // Do any additional setup after loading the view.
}
- (IBAction)openVendor:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih"
                                            rows:_vendor
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           //                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _vendorTextField.text=selectedValue;
                                           _prodKode =[_kode objectAtIndex:selectedIndex];
                                           [self setPrice:[[_kode objectAtIndex:selectedIndex]integerValue]];
                                           NSLog(@"Selected Value: %@", selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
- (IBAction)openDenom:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih"
                                            rows:_nominal
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           //                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _denomTextField.text = selectedValue;
                                           Fee *c = [_listDenom objectAtIndex:selectedIndex];
                                           _idItems = c.id;
                                           _basicPrice = c.basicPrice;
                                           _hargaJual.text =[NSString stringWithFormat:@"%ld",(long)c.salePrice];
                                           NSLog(@"Selected Value: %@", selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
}
- (IBAction)saveDenom:(id)sender {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Saving Data";
    _f.id = _idItems;
    _f.parentCode = [_prodKode integerValue];
    _f.basicPrice = _basicPrice;
    _f.salePrice = [_hargaJual.text integerValue];
    [Fee save:_f withRevision:YES];
    [self performSelector:@selector(closeHud) withObject:nil afterDelay:2];
    
}
-(void)closeHud{
    _hud.hidden = YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPrice:(int)parentCode{
    [_nominal removeAllObjects];
    _listDenom = [Fee getPriceByparentCode:parentCode];
   
    for (int i=0; i<_listDenom.count; i++) {
        Fee *c = [_listDenom objectAtIndex:i];
        [_nominal addObject:[NSString stringWithFormat:@"%ld/%ld",(long)c.basicPrice,(long)c.salePrice]];
    }
    _denomTextField.text = @"";
    _hargaJual.text =@"";
    
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
