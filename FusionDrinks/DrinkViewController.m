//
//  DrinkViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "DrinkViewController.h"
#import "DrinkCollectionViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#define FETCHALLPRODUCT @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/GetProductByCategory/%@"

@interface DrinkViewController ()
{
    DrinkCollectionViewCell *cell;
    NSMutableArray *productArr;
    NSString *languageId;
}
@end

@implementation DrinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    productArr=[[NSMutableArray alloc]init];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        languageId=@"-1";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        languageId=@"-2";
    }

    [self fetchAllProducts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource and Delegate method

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return [productArr count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dict=[productArr objectAtIndex:indexPath.row];
   
    [cell.lblDrinkName setText:[dict objectForKey:@"ProductName"]];
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"ThumbImage"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [cell.imgDrink setImage:[[UIImage alloc]initWithData:data]];
    [self fetchSingleProductData:dict];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double side1,side2;
        CGSize collectionviewSize=self.collectionView.frame.size;
        side1=collectionviewSize.width/2-20;
        side2=collectionviewSize.width/2;
    
    return CGSizeMake(side1, side2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indexes=[[NSString alloc]initWithFormat:@"%ld",indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:indexes forKey:@"productIndex"];
    
    NSLog(@"selected index::%ld",indexPath.row);

    
    UIViewController *popover = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DRINKS_DESC"];
    popover.modalPresentationStyle = UIModalPresentationCustom;
    [popover setTransitioningDelegate:_customTransitionController];
    [self presentViewController:popover animated:YES completion:nil];
    }

#pragma mark - Consume Web service methods
-(void)fetchAllProducts{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"FETCHURL :%@",FETCHALLPRODUCT);
    
    [manager GET:[NSString stringWithFormat:FETCHALLPRODUCT,languageId]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"dic1 : %@",dic1);
    
        [self fetchDataResponse:dic1];
        [self.collectionView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"SPS" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];

}

- (void)fetchDataResponse:(NSDictionary*)dictionary {
   
    NSLog(@"----FETCHED---%@",dictionary[@"ListProduct"]);
    productArr=[dictionary objectForKey:@"ListProduct"];
   
    NSLog(@"---NO. Of Products :: %ld",[productArr count]);
    
}
-(void)fetchSingleProductData :(NSDictionary *)dictionary
{
    NSLog(@"method called");
    NSArray *arrIng=[dictionary objectForKey:@"Ingredients"];
    NSArray *arrMethod=[dictionary objectForKey:@"MethodSteps"];
    NSLog(@"----ING::%ld----METhod:::%ld",[arrIng count],[arrMethod count]);
}

@end
