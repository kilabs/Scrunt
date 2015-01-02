//
//  HomeTableViewCell.h
//  Delima
//
//  Created by Arie Prasetyo on 12/31/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TransactionHistory;
@class Favorite;
@interface HomeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *transactionDate;
@property (strong, nonatomic) TransactionHistory *transaction;
@property (strong, nonatomic) Favorite *favorite;
@property (strong, nonatomic) IBOutlet UILabel *price;

@end
