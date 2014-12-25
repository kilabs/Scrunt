//
//  InvoiceViewController.m
//  Delima
//
//  Created by Arie Prasetyo on 12/22/14.
//  Copyright (c) 2014 netra. All rights reserved.
//

#import "InvoiceViewController.h"
#import "DelimaCommonFunction.h"
#import "TransactionHistory.h"
@interface InvoiceViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *namaMitra;
@property (strong, nonatomic) IBOutlet UILabel *trxDate;
@property (strong, nonatomic) IBOutlet UILabel *terminal;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *item;
@property (strong, nonatomic) IBOutlet UILabel *noTujuan;
@property (strong, nonatomic) IBOutlet UILabel *totalHarga;
@property (strong, nonatomic) IBOutlet UILabel *feeNominal;

//@property (strong, nonatomic) IBOutlet UILabel *totalText;
@property (strong, nonatomic) IBOutlet UILabel *dataHarga;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@end

@implementation InvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scroller.delegate  =self;
    _scroller.contentSize = CGSizeMake(320, 600);
    _namaMitra.text = _namaMitraString;
    _trxDate.text =[NSString stringWithFormat:@"%@",[NSDate date]];
    _type.text = _typeString;
    _item.text = _itemString;
    _noTujuan.text = _noTujuanString;
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:_hargaText];
    if ([_feeText isEqualToString:@""]) {
        _feeText=@"0";
    };
    NSNumber * myNumbers = [f numberFromString:_feeText];
    _dataHarga.text =[NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:myNumber]];
    
    _feeNominal.text = [NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:myNumbers]];
    int data = [_hargaText integerValue]+[_feeText integerValue];
    
    _totalHarga.text =[NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:[NSNumber numberWithInt:data]]];
    
    NSLog(@"data-->%@",_itemString);
    NSLog(@"data-->%@",_trxDate.text);
    NSLog(@"data-->%@",_dataHarga.text);
    NSLog(@"data-->%@",_noTujuan.text);
    NSLog(@"data-->%@",_namaPelanggan);
    NSLog(@"Pembaayaran %@ No.Bill %@ a/n %@ Sejumlah %@ telah berhasil",_item.text,_noTujuan.text,_namaPelanggan,_dataHarga.text);
    TransactionHistory *t = [[TransactionHistory alloc]init];
    t.executeDate =[NSDate date];
    t.tujuan = _noTujuan.text;
    t.itemName = _item.text;
    t.price =_dataHarga.text;
    t.keterangan =[NSString stringWithFormat:@"Pembaayaran %@ No.Bill %@ a/n %@ Sejumlah %@ telah berhasil",_item.text,_noTujuan.text,_namaPelanggan,_dataHarga.text];
    [TransactionHistory save:t withRevision:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeWindow:(id)sender {
    [[[self presentingViewController] presentingViewController]  dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveToImage:(id)sender {
    UIImage* image = nil;
    
    UIGraphicsBeginImageContext(_scroller.contentSize);
    {
        CGPoint savedContentOffset = _scroller.contentOffset;
        CGRect savedFrame = _scroller.frame;
        
        _scroller.contentOffset = CGPointZero;
        _scroller.frame = CGRectMake(0, 0, _scroller.contentSize.width, _scroller.contentSize.height);
        
        [_scroller.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        _scroller.contentOffset = savedContentOffset;
        _scroller.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
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
