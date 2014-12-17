//
//  SharedBeliViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/13/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "SharedBeliViewController.h"
#import "Fee.h"
#import "PropertyHelper.h"
#import <ActionSheetStringPicker.h>
@interface SharedBeliViewController ()
@property (strong, nonatomic) IBOutlet UILabel *pilihText;
@property (strong,nonatomic)NSMutableArray *kode;
@property (strong,nonatomic)NSMutableArray *opName;
@property (strong,nonatomic)NSMutableArray *denomination;
@property (nonatomic)NSInteger selectedIndex;

@end

@implementation SharedBeliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSArray *data = [PropertyHelper readFromKeys:@[@"data"] withPropertiesPath:self.title];
    _denomination = [[NSMutableArray alloc]init];
    _kode = [[NSMutableArray alloc]init];
    _opName = [[NSMutableArray alloc]init];
    for (int i=0; i<data.count; i++) {
        NSLog(@"data->%@",[[data objectAtIndex:i]objectForKey:@"name"]);
        [_kode addObject:[[data objectAtIndex:i]objectForKey:@"kode"]];
        [_opName addObject:[[data objectAtIndex:i]objectForKey:@"name"]];
    }
 
   
}

- (IBAction)openOp:(UITextField *)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih Operator"
                                            rows:_opName
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
//                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _selectedIndex = selectedIndex;
                                           
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
    NSLog(@"parentcode-->%d",parentCode);
    NSArray *d = [Fee getPriceByparentCode:parentCode];
   
    for (int i=0; i<d.count; i++) {
        Fee *c = [d objectAtIndex:i];
        [_denomination addObject:[NSString stringWithFormat:@"%d/%ld",c.basicPrice,(long)c.salePrice]];
    }
    
}
- (IBAction)openDenom:(UITextField *)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Pilih Operator"
                                            rows:_denomination
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           //                                           _bankCode.text =selectedValue;
                                           NSLog(@"Picker: %@", picker);
                                           _selectedIndex = selectedIndex;
                                           
                                           [self setPrice:[[_kode objectAtIndex:_selectedIndex]integerValue]];
                                           NSLog(@"Selected Value: %@", selectedValue);
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
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
