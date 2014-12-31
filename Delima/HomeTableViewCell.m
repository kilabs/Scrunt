//
//  HomeTableViewCell.m
//  Delima
//
//  Created by Arie Prasetyo on 12/31/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "TransactionHistory.h"
@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTransaction:(TransactionHistory *)transaction{
    _transaction = transaction;
    switch (_transaction.type) {
        case 1:
            [_icon setImage:[UIImage imageNamed:@"buy"]];
            break;
        case 2:
            [_icon setImage:[UIImage imageNamed:@"bill"]];
            break;
    }
    _transactionDate.text = _transaction.itemName;
    _productName.text = [_transaction.parent stringByReplacingOccurrencesOfString:@";" withString:@" "];
    _price.text = _transaction.price;
}
@end
