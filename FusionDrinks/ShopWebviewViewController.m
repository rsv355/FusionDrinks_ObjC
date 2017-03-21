//
//  ShopWebviewViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 06/04/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "ShopWebviewViewController.h"

@interface ShopWebviewViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ShopWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *webUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"webUrl"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: webUrl] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 1.0];
    [self.webView loadRequest: request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
