//
//  TransactionHistory.h
//  Delima
//
//  Created by Arie Prasetyo on 12/23/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "RLMObject.h"

@interface TransactionHistory : RLMObject
@property NSInteger id;
@property NSString *guid;
@property NSDate *createdAt;
@property NSDate *updatedAt;
@property NSDate *executeDate;
@property NSString *itemName;
@property NSString *price;
@property NSString *parent;
@property NSString *tujuan;
@property NSString *keterangan;
@property NSInteger type;


//////ingat!
//1 beli
//2.bayar
//3.cashin
//4.transfer bank
//
+ (void)save:(TransactionHistory *)fee withRevision:(BOOL)revision;
+(NSArray *)getAllHistory;
@end
/*
 
 NSLog(@"data-->%@",_itemString);
 NSLog(@"data-->%@",_trxDate.text);
 NSLog(@"data-->%@",_dataHarga.text);
 NSLog(@"data-->%@",_noTujuan.text);
 NSLog(@"data-->%@",_namaPelanggan);
 NSLog(@"Pembaayaran %@ No.Bill %@ a/n %@ Sejumlah %@ telah berhasil",_item.text,_noTujuan.text,_namaPelanggan,_dataHarga.text);
 */
