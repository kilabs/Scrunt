//
//  GantiPinViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/22/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "GantiPinViewController.h"

@interface GantiPinViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *pinLama;
@property (strong, nonatomic) IBOutlet UITextField *pinBaru;
@property (strong, nonatomic) IBOutlet UITextField *konfirmPin;

@end

@implementation GantiPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
     
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
