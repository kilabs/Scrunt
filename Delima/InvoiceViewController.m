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
#import "PropertyHelper.h"
#import "Favorite.h"
@interface InvoiceViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *namaMitra;
@property (strong, nonatomic) IBOutlet UILabel *trxDate;
@property (strong, nonatomic) IBOutlet UILabel *terminal;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) IBOutlet UILabel *item;
@property (strong, nonatomic) IBOutlet UILabel *noTujuan;
@property (strong, nonatomic) IBOutlet UILabel *totalHarga;
@property (strong, nonatomic) IBOutlet UILabel *feeNominal;
@property (strong, nonatomic) IBOutlet UIView *favoriteView;

//@property (strong, nonatomic) IBOutlet UILabel *totalText;
@property (strong, nonatomic) IBOutlet UILabel *dataHarga;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@end

@implementation InvoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /////set favorite
    CGRect frame = _favoriteView.frame;
    frame.origin.y = self.view.frame.size.height-60;
    _favoriteView.frame = frame;
     _favoriteView.hidden = NO;
    //////
    
    
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
    if ([_feeText isEqualToString:@""]||!_feeText) {
        _feeText=@"0";
    };
    NSNumber * myNumbers = [f numberFromString:_feeText];
    _dataHarga.text =[NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:myNumber]];
    
    _feeNominal.text = [NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:myNumbers]];
    int data = [_hargaText integerValue]+[_feeText integerValue];
    
    _totalHarga.text =[NSString stringWithFormat:@"Rp %@,-",[[DelimaCommonFunction sharedCommonFunction] formatToRupiah:[NSNumber numberWithInt:data]]];

    NSLog(@"Pembaayaran %@ No.Bill %@ a/n %@ Sejumlah %@ telah berhasil",_item.text,_noTujuan.text,_namaPelanggan,_dataHarga.text);
    TransactionHistory *t = [[TransactionHistory alloc]init];
    t.executeDate =[NSDate date];
    t.tujuan = _noTujuan.text;
    t.itemName = _item.text;
    t.price =_dataHarga.text;
    t.parent = _typeString;
    NSString *state;
    NSLog(@"is bayar--->%d",_isBayar);
    if(_isBayar){
        state = @"Pembayaran";
        t.type = 2;}
    else{
        state = @"Pembelian";
        t.type = 1;}
    
    
    if(!_namaPelanggan)
        _namaPelanggan = @"";
    t.keterangan =[NSString stringWithFormat:@"%@ %@ No.Bill %@ a/n %@ Sejumlah %@ telah berhasil",state,_item.text,_noTujuan.text,_namaPelanggan,_dataHarga.text];
    [TransactionHistory save:t withRevision:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeWindow:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
- (IBAction)simpanFavorite:(id)sender {
    
    Favorite *f = [[Favorite alloc]init];
    f.amount =[[PropertyHelper getTempFavorite] objectForKey:@"amount"];
    if([[[PropertyHelper getTempFavorite] objectForKey:@"storyboardName"] isEqualToString:@"Beli"])
        f.type=1;
    else if ([[[PropertyHelper getTempFavorite] objectForKey:@"storyboardName"] isEqualToString:@"bayar"])
        f.type = 2;
    f.controllerName =[[PropertyHelper getTempFavorite] objectForKey:@"controllerName"];
    f.denom =[[PropertyHelper getTempFavorite] objectForKey:@"denom"];
    f.hargaJual = [[PropertyHelper getTempFavorite] objectForKey:@"hargaJual"];
    f.mercode =[[PropertyHelper getTempFavorite] objectForKey:@"mercode"];
    f.prodcode =[[PropertyHelper getTempFavorite] objectForKey:@"prodcode"];
    f.itemName =[[PropertyHelper getTempFavorite] objectForKey:@"prodName"];
    f.recipientNumber =[[PropertyHelper getTempFavorite] objectForKey:@"recipientNumber"];
    f.storyboardName =[[PropertyHelper getTempFavorite] objectForKey:@"storyboardName"];
    f.title =[[PropertyHelper getTempFavorite] objectForKey:@"subCategory"];
    f.hargaDasar =[[PropertyHelper getTempFavorite] objectForKey:@"hargaDasar"];
    if (_typeString) {
        f.parent = _typeString;
    }
    else{
        f.parent = [[PropertyHelper getTempFavorite] objectForKey:@"_typeString"];
    }
    
    [Favorite save:f withRevision:YES];
    _favoriteView.hidden = YES;
    [[DelimaCommonFunction sharedCommonFunction]setAlert:@"Sukses" message:@"Berhasil Menyimpan Transaksi Di Favorit"];
    
    
}


@end
