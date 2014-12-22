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
#import "User.h"
#import "DelimaCommonFunction.h"
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
