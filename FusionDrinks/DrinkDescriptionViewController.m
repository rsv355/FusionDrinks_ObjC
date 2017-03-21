//
//  DrinkDescriptionViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "DrinkDescriptionViewController.h"
#import "DrinkTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#define FETCHALLPRODUCT @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/GetProductByCategory/%@"

#define GETPASSCODE @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/GeneratePassCode/0"
#define VALIDATEPASSCODE @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/GeneratePassCode/%@"
@interface DrinkDescriptionViewController ()
{
    DrinkTableViewCell *cell;
    NSArray *productArr;
    NSUInteger index;
    NSArray *ingredientArr,*methodArr,*titleArr;
    NSString *languageId;
    NSDictionary *dict;
}
@end

@implementation DrinkDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.popupView setHidden:YES];
    self.popupView.layer.cornerRadius=7.0f;
    productArr=[[NSArray alloc]init];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        languageId=@"-1";
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        languageId=@"-2";
    }
    
    NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:@"productIndex"];
   
    NSNumber *number = [NSNumber numberWithLongLong: str.longLongValue];
     index = number.unsignedIntegerValue;
    NSLog(@"----%ld",index);
    
    
    titleArr=[[NSArray alloc]initWithObjects:@"Ingredients",@"Methods", nil];
    [self fetchAllProducts];
    
    NSString *pstr=[[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"];
    if ([pstr length]==0) {
        [self.lblPasscode setHidden:YES];
    }
    else
    {
        [self.lblPasscode setText:[@"Passcode : " stringByAppendingString:pstr]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// keyboard hide on touch outside
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
#pragma mark- UITableView Datasource and Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"----NUMB:: %ld",[ingredientArr count]);
    return [ingredientArr count]+[methodArr count]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     cell.backgroundColor=[UIColor blackColor];
    if (indexPath.row==0||indexPath.row==[ingredientArr count]+1) {
        cell=(DrinkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        if (indexPath.row==0) {
            [cell.lblHeader setText:@"INGREDIENT :"];
        }
        else if (indexPath.row==[ingredientArr count]+1) {
            [cell.lblHeader setText:@"METHODS :"];
        }
    }
    else
    {
    cell=(DrinkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (indexPath.row<=[ingredientArr count] ) {
            [cell.lblTitle setText:[ingredientArr objectAtIndex:indexPath.row-1]];
           
        }
        else if(indexPath.row>[ingredientArr count]+1) {
           //  NSLog(@"---%ld---->",indexPath.row);
            [cell.lblTitle setText:[methodArr objectAtIndex:indexPath.row-([ingredientArr count]+2)]];
        }
    
    }
    return cell;
}
- (NSUInteger)numberOfWordsInString:(NSString *)str {
    __block NSUInteger count = 0;
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length])
                            options:NSStringEnumerationByWords|NSStringEnumerationSubstringNotRequired
                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                             count++;
                         }];
    return count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight;
   if (indexPath.row==0||indexPath.row==[ingredientArr count]+1)
   {
        cellHeight=40;
       
   }
    else
    {
        if ([cell.lblTitle text].length <20) {
            cellHeight=40;
        }
        else {
            cellHeight=80;
        }
    }
    return cellHeight;
}


- (IBAction)btnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)fetchAllProducts{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"FETCHURL :%@",FETCHALLPRODUCT);
    
    [manager GET:[NSString stringWithFormat:FETCHALLPRODUCT,languageId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        productArr=[dic1 objectForKey:@"ListProduct"];
        NSLog(@"----->>%ld",[productArr count]);
        //[self.tableView reloadData];
        [self btnInteraction];
        [self fetchSingleProductData:index];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
}

-(void)fetchSingleProductData :(NSUInteger )indexes
{
//    NSLog(@"method called");

    NSDictionary *dataDict=[productArr objectAtIndex:indexes];
    [self.lblProductName setText:[dataDict objectForKey:@"ProductName"]];
   // NSLog(@"---NAME::%@",dataDict);
    NSURL *url = [NSURL URLWithString:[dataDict objectForKey:@"ThumbImage"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.imgProduct setImage:[[UIImage alloc]initWithData:data]];
    
        NSArray *arrIng=[dataDict objectForKey:@"Ingredients"];
        NSArray *arrMethod=[dataDict objectForKey:@"MethodSteps"];
    ingredientArr = [arrIng valueForKey:@"Ingredient"];
    methodArr = [arrMethod valueForKey:@"Step"];
   // NSLog(@"----NUMB:: %ld",[ingredientArr count]);
    [self.tableView reloadData];
    
    [[NSUserDefaults standardUserDefaults]setObject:[dataDict objectForKey:@"ProductName"] forKey:@"productName"];
    [[NSUserDefaults standardUserDefaults]setObject:[dataDict objectForKey:@"ProductPrice"] forKey:@"productPrice"];
    [[NSUserDefaults standardUserDefaults]setObject:[dataDict objectForKey:@"ThumbImage"] forKey:@"productImage"];
    
     [[NSUserDefaults standardUserDefaults]setObject:[dataDict objectForKey:@"ProductId"] forKey:@"productId"];
}


- (IBAction)btnNext:(id)sender {
    if (index==[productArr count]-1) {
        [self.btnNext setUserInteractionEnabled:NO];
    }
    else
    {
        index+=1;
        if (index==[productArr count]-1) {
            [self.btnNext setUserInteractionEnabled:NO];
        }
    }
    NSLog(@"NCurrent Index::%ld",index);
    [self btnInteraction];
     [self fetchSingleProductData:index];
}
- (IBAction)btnPrevious:(id)sender {
    NSLog(@"_______%ld",[productArr count]);
    if (index==0) {
        [self.btnPrevious setUserInteractionEnabled:NO];
    }
    else
    {
        index-=1;
        if (index==0) {
            [self.btnPrevious setUserInteractionEnabled:NO];
        }
    }
    NSLog(@"PCurrent Index::%ld",index);
    [self btnInteraction];
     [self fetchSingleProductData:index];
}
-(void)btnInteraction
{
    if (index==0) {
        [self.btnPrevious setUserInteractionEnabled:NO];
    }
    else if (index>=[productArr count]) {
        [self.btnNext setUserInteractionEnabled:NO];
    }
    else
    {
        [self.btnPrevious setUserInteractionEnabled:YES];
        [self.btnNext setUserInteractionEnabled:YES];
    }

}


#pragma mark - Passocde methods


- (IBAction)btnBuy:(id)sender {
    [self.popupView setHidden:NO];
}
- (IBAction)btnSend:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"FETCHURL :%@",VALIDATEPASSCODE);
    
    [manager GET:[NSString stringWithFormat:VALIDATEPASSCODE,self.txtEnterPasscode.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"RESPONSE--->> %@",dict);
        if ([dict[@"PassCode"] isEqualToString:@"Invalid PassCode"]) {
            UIAlertView *alerView=[[UIAlertView alloc]initWithTitle:nil message:dict[@"PassCode"] delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alerView show];
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:[self.txtEnterPasscode text] forKey:@"passcode"];
            UIViewController *viewController=[self.storyboard instantiateViewControllerWithIdentifier:@"PAYMENT1"];
            [self presentViewController:viewController animated:YES completion:nil];
        }
        //-------PARSING-------
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Please enter proper Passcode" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
    
}

- (IBAction)btnCancel:(id)sender {
    [self.popupView setHidden:YES];
}

- (IBAction)btnRequestCode:(id)sender {
    [self GetPasscode];
    
}

-(void)GetPasscode{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"FETCHURL :%@",GETPASSCODE);
    
    [manager GET:GETPASSCODE parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        self.txtEnterPasscode.text=[dict objectForKey:@"PassCode"];
        [self.txtEnterPasscode setUserInteractionEnabled:NO];
        //-------PARSING-------
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
}

@end
