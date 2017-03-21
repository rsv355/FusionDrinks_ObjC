//
//  OrderHistoryViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 31/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "OrderTableViewCell.h"
#define FETCHHISTORY @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/PassCodeOrderHistory/%@"

@interface OrderHistoryViewController ()
{
    NSArray *orderArr;
    OrderTableViewCell *cell;
    NSDictionary *dict;
}
@end

@implementation OrderHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getOrderHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getOrderHistory
{
    
    NSString *passcode=[[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"FETCHURL :%@",[NSString stringWithFormat:FETCHHISTORY,passcode]);
    
    [manager GET:[NSString stringWithFormat:FETCHHISTORY,passcode]  parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        orderArr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dic1 : %@",orderArr);
        
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"SPS" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
}
#pragma mark -UITableView DataSource and Delegate methods

- (NSUInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [orderArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dict=[orderArr objectAtIndex:indexPath.row];
    cell=(OrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.lblProductName setText:[dict objectForKey:@"ProductName"]];
   // [cell.lbldate setText:[dict objectForKey:@"OrderDate"]];
    [cell.lblStatus setText:[dict objectForKey:@"Status"]];
    NSString *qty=[NSString stringWithFormat:@"%@",[dict objectForKey:@"Quantity"]];
    NSString *total=[NSString stringWithFormat:@"%@",[dict objectForKey:@"TotalPrice"]];
    [cell.lblQty setText:[@"Quantity : " stringByAppendingString:qty]];
    [cell.lblTotal setText:[@"Total Price : " stringByAppendingString:total]];
    
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"Thumbnail"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [cell.lblImage setImage:[[UIImage alloc]initWithData:data]];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSDate *date=[[NSDate alloc]init];
    date=[self deserializeJsonDateString:[dict objectForKey:@"OrderDate"]];
    
    [cell.lbldate setText:[formatter stringFromDate:date]];
    return cell;
}
- (NSDate *)deserializeJsonDateString: (NSString *)jsonDateString
{
    NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT]; //get number of seconds to add or subtract according to the client default time zone
    
    NSInteger startPosition = [jsonDateString rangeOfString:@"("].location + 1; //start of the date value
    
    NSTimeInterval unixTime = [[jsonDateString substringWithRange:NSMakeRange(startPosition, 13)] doubleValue] / 1000; //WCF will send 13 digit-long value for the time interval since 1970 (millisecond precision) whereas iOS works with 10 digit-long values (second precision), hence the divide by 1000
    
    [[NSDate dateWithTimeIntervalSince1970:unixTime] dateByAddingTimeInterval:offset];
    NSDate *date=
    [[NSDate dateWithTimeIntervalSince1970:unixTime] dateByAddingTimeInterval:offset];
    
    return date;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    re
//}
@end
