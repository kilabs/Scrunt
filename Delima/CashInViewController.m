//
//  CashInViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/13/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "CashInViewController.h"
#import "BarHelper.h"
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
