//
//  InvoiceViewController.h
//  Delima
//
//  Created by Arie Prasetyo on 12/22/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceViewController : UIViewController
@property (strong, nonatomic) NSString *namaMitraString;
@property (strong, nonatomic) NSString *terminalString;
@property (strong, nonatomic) NSString *typeString;
@property (strong, nonatomic) NSString *itemString;

@property (strong, nonatomic) NSString *noTujuanString;

@property (strong, nonatomic) NSString *hargaText;
@property (strong, nonatomic) NSString *feeText;
@property (strong, nonatomic) NSString *totalText;
@property (strong, nonatomic) NSString *namaPelanggan;
@property (nonatomic) NSInteger transactionType;
@property (nonatomic) BOOL isBayar;
@end
