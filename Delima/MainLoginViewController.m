//
//  MainLoginViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/7/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "MainLoginViewController.h"
#import "User.h"
#import "Fee.h"
#import <MBProgressHUD.h>
#import "DelimaCommonFunction.h"
#import "API+LoginManager.h"
@interface MainLoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;

@end

@implementation MainLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userName.delegate = self;
    _userName.tag = 1;
    _userName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _password.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    _password.secureTextEntry = YES;
    _password.tag =2;
    _password.delegate = self;
    self.navigationController.navigationBar.hidden = NO;
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginPressed:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{@"uname":_userName.text,
                             @"passwd":[[DelimaCommonFunction sharedCommonFunction]md5:_password.text],
                             @"terminal":[[NSUUID UUID] UUIDString],
                             @"os":@"IOS",
                             @"version":[[UIDevice currentDevice] systemVersion],
                             @"ref":@"DelimaMobile"
                             };
    [API_LoginManager login:params login:^(NSArray *posts, NSError *error) {
        if(!error){
            if(posts.count <1){
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
            else{
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }
        else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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
