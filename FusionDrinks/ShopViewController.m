//
//  ShopViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopCollectionViewCell.h"
#import "CustomAnimationAndTransiotion.h"
@interface ShopViewController ()
{
    ShopCollectionViewCell *cell;
    NSArray *imageArray,*urlArr;
}
@property (strong,nonatomic)CustomAnimationAndTransiotion *customTransitionController;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    imageArray=[[NSArray alloc]initWithObjects:@"shop1.png",@"shop2.png",@"shop3.png",@"shop4.jpg",@"shop5.png",@"shop6.png",@"shop7.png",@"shop8.png",@"shop9.jpg",@"shop10.png",@"shop11.png", nil];
    
    urlArr=[[NSArray alloc]initWithObjects:@"http://www.ullrich.ch/shop/spirituosen/detail.php?ID_NR_Art=31024",@"https://www.schuewo.ch/de/lilah-chai-cream-liqueur-70-cl-70-cl/a!57317/",@"https://www.galaxus.ch/de/s2/product/lilah-cream-likoere-70cl-spirituosen-5643397",@"http://www.drink-shop.ch/de/liqueur/lilah-naturally-flavored-chai-cream-likor-70-cl-17-schweiz.html",@"http://gartencentershop.ch/lilah-chai-cream-liqueur.html",@"http://www.teelade.ch/shop/pi.php/LILAH-CREAM-Chai-Cream-Liqueur-17-Alc-Vol-70-cl.html",@"http://www.flaeschehals.ch/de/artikel/2875499_lilah_-_chai_cream.htm",@"http://www.pepillo.ch/news/lilah-chai-cream-liqueur-17-vol-70-cl.html",@"http://casadeltequila.ch/index.php?main_page=advanced_search_result&search_in_description=1&keyword=lilah&x=0&y=0",@"http://www.trinkgenuss.ch/lilah-chai-cream-likoer-70cl.html",@"http://boesch-getraenke.ch/lilah-20chai-20cream-20liquer.html", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imageArray count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2==0){
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.imageView1 setImage:[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]]];
    }
    else
    {
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell2" forIndexPath:indexPath];
        [cell.imageView2 setImage:[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]]];
    }
    return cell;
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    double side1,side2;
////    CGSize collectionviewSize=self.collectionView.frame.size;
////    side1=collectionviewSize.width/2-20;
////    side2=collectionviewSize.width/2;
//    if (indexPath.row%2==0) {
//        side1=184;
//        side2=104;
//    }
//    else if(indexPath.row==5)
//    {
//        side1=140;
//        side2=80;
//    }
//    else
//    {
//        side1=140;
//        side2=140;
//    }
//    
//    return CGSizeMake(side1, side2);
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSUserDefaults standardUserDefaults]setObject:[urlArr objectAtIndex:indexPath.row] forKey:@"webUrl"];
    
    UIViewController *popover = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHOP_WEBVIEW"];
    popover.modalPresentationStyle = UIModalPresentationCustom;
    [popover setTransitioningDelegate:_customTransitionController];
    [self presentViewController:popover animated:YES completion:nil];
}

@end
