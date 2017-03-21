//
//  NewsListViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsTableViewCell.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#define FETCHALLNEWS @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/GetAllNews/%@"


@interface NewsListViewController ()
{
    NSArray *newsArr;
}
@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchgAllNews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- UITableView Datasource and Delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [newsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NewsTableViewCell *cell=(NewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *dc=[newsArr objectAtIndex:indexPath.row];
    [cell.lblNewsTitle setText:[dc objectForKey:@"Title"]];
    [cell.lblNewsDesc setText:[dc objectForKey:@"Description"]];
    NSURL *url = [NSURL URLWithString:[dc objectForKey:@"ThumbImage"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [cell.imgNews setImage:[[UIImage alloc]initWithData:data]];
    
    /*-----On Select Background Color------*/
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor clearColor];
    [cell setSelectedBackgroundView:bgColorView];
       return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dc=[newsArr objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults]setObject:[dc objectForKey:@"Title"] forKey:@"title"];
     [[NSUserDefaults standardUserDefaults]setObject:[dc objectForKey:@"Description"] forKey:@"description"];
     [[NSUserDefaults standardUserDefaults]setObject:[dc objectForKey:@"ThumbImage"] forKey:@"image"];
    
    
    UIViewController *popover = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NEWS_DESC"];
    popover.modalPresentationStyle = UIModalPresentationCustom;
    [popover setTransitioningDelegate:_customTransitionController];
    [self presentViewController:popover animated:YES completion:nil];
}

-(void) fetchgAllNews
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //NSLog(@"FETCHURL :%@",[NSString stringWithFormat:FETCHNPSQUE,[[NSUserDefaults standardUserDefaults]objectForKey:@"defuserid"]]);
    
    [manager GET:[NSString stringWithFormat:FETCHALLNEWS,[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"dic1 : %@",dic1);
        newsArr=[dic1 objectForKey:@"ListNews"];
        if ([newsArr count]==0) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"No news available" delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        [self.tableView reloadData];
                //[self response1:dic1];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"SPS" message:@"Network error. Please try again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];

}
@end
