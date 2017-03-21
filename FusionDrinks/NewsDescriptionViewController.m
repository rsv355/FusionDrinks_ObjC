//
//  NewsDescriptionViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "NewsDescriptionViewController.h"

@interface NewsDescriptionViewController ()

@end

@implementation NewsDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.lblTitle setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"title"]];
    [self.lblDescription setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"description"]];
    NSURL *url=[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"image"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.imageNews setImage:[[UIImage alloc]initWithData:data]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
