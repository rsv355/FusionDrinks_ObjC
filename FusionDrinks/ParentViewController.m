//
//  ParentViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "ParentViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#define VALIDATEPASSCODE @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/GeneratePassCode/%@"


@interface ParentViewController ()
{
    NSString *strSelection;
    NSDictionary *dict;
}
@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/help
    [self.drawerView setHidden:YES];
    [self.viewPopup setHidden:YES];
    self.viewPopup.layer.cornerRadius=5.0f;
   

    NSString *storyboardID=[[NSUserDefaults standardUserDefaults]objectForKey:@"storyboardId"];
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:storyboardID];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
   
    [self changeLanguage];
    [self.lblHeaderTitle setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"title"]];
    
    
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


- (IBAction)btnDrawer:(id)sender {
    
    if (_btnDrawer.tag==0)
    {
        _btnDrawer.tag=1;
        _drawerView.hidden = NO;
        _drawerView.alpha = 0.1;
        [UIView animateWithDuration:0.25 animations:^{
            _drawerView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            // do some
        }];
        [self.btnDrawer setImage:[UIImage imageNamed:@"menuselected.png"] forState:UIControlStateNormal];
    
    }
    else if(_btnDrawer.tag==1)
    {
        _btnDrawer.tag=0;
        [UIView animateWithDuration:0.25 animations:^{            [_drawerView setAlpha:0.1f];
        } completion:^(BOOL finished) {
            _drawerView.hidden = YES;
        }];
         [self.btnDrawer setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)btnSpices:(id)sender
{
    _drawerView.hidden = YES;
    strSelection=@"1";
    [self changeButtonLogo];
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SPICES"];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.lblHeaderTitle setText:@"Spices"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.lblHeaderTitle setText:@"Gewürze"];
    }

}

- (IBAction)btnDrinks:(id)sender
{
    _drawerView.hidden = YES;
    strSelection=@"2";
     [self changeButtonLogo];
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DRINKS"];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.lblHeaderTitle setText:@"Drinks"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.lblHeaderTitle setText:@"Getränke"];
    }
}

- (IBAction)btnShop:(id)sender
{
    _drawerView.hidden = YES;
    strSelection=@"3";
     [self changeButtonLogo];
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SHOP"];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.lblHeaderTitle setText:@"Shop"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.lblHeaderTitle setText:@"Geschäft"];
    }
}

- (IBAction)btnNews:(id)sender
{
    _drawerView.hidden = YES;
    strSelection=@"4";
     [self changeButtonLogo];
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NEWS"];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.lblHeaderTitle setText:@"News"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.lblHeaderTitle setText:@"Nachrichten"];
    }
}

- (IBAction)btnChangeLanguage:(id)sender
{
    _btnDrawer.tag=0;
    strSelection=@"1";
    [self changeButtonLogo];
    [UIView animateWithDuration:0.25 animations:^{            [_drawerView setAlpha:0.1f];
    } completion:^(BOOL finished) {
        _drawerView.hidden = YES;
    }];
    [self.btnDrawer setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIActionSheet *actionsheet=[[UIActionSheet alloc]initWithTitle:@"Select Language" delegate:(id)self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"English",@"German", nil];
    [actionsheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
            switch (buttonIndex) {
                case 0:
                    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"languageStatus"];
                    [self viewDidLoad];
                    break;
                case 1:
                    [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"languageStatus"];
                    [self viewDidLoad];
                    break;
                
                default:
                    break;
            }
    
}
- (IBAction)btnAboutUs:(id)sender
{
       _drawerView.hidden = YES;
    strSelection=@"0";
    [self changeButtonLogo];
    _btnDrawer.tag=0;
    [UIView animateWithDuration:0.25 animations:^{            [_drawerView setAlpha:0.1f];
    } completion:^(BOOL finished) {
        _drawerView.hidden = YES;
    }];
    [self.btnDrawer setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ABOUT_US"];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.lblHeaderTitle setText:@"About Us"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.lblHeaderTitle setText:@"Über uns"];
    }
}

- (IBAction)btnContactUs:(id)sender
{
       _drawerView.hidden = YES;
    strSelection=@"0";
    [self changeButtonLogo];
    _btnDrawer.tag=0;
    [UIView animateWithDuration:0.25 animations:^{            [_drawerView setAlpha:0.1f];
    } completion:^(BOOL finished) {
        _drawerView.hidden = YES;
    }];
    [self.btnDrawer setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CONTACT_US"];
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.lblHeaderTitle setText:@"Contact Us"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.lblHeaderTitle setText:@"kontaktiere uns"];
    }
}

-(void)changeButtonLogo
{
    if ([strSelection isEqualToString:@"1"]) {
        [self.btnSpices setImage:[UIImage imageNamed:@"spicesselected.png"] forState:UIControlStateNormal];
        [self.btnDrinks setImage:[UIImage imageNamed:@"drinks.png"] forState:UIControlStateNormal];
        [self.btnShop setImage:[UIImage imageNamed:@"shop.png"] forState:UIControlStateNormal];
        [self.btnNews setImage:[UIImage imageNamed:@"news.png"] forState:UIControlStateNormal];
    }
    else if ([strSelection isEqualToString:@"2"]) {
        [self.btnSpices setImage:[UIImage imageNamed:@"spices.png"] forState:UIControlStateNormal];
        [self.btnDrinks setImage:[UIImage imageNamed:@"drinksselected.png"] forState:UIControlStateNormal];
        [self.btnShop setImage:[UIImage imageNamed:@"shop.png"] forState:UIControlStateNormal];
        [self.btnNews setImage:[UIImage imageNamed:@"news.png"] forState:UIControlStateNormal];
    }
    else if ([strSelection isEqualToString:@"3"]) {
        [self.btnSpices setImage:[UIImage imageNamed:@"spices.png"] forState:UIControlStateNormal];
        [self.btnDrinks setImage:[UIImage imageNamed:@"drinks.png"] forState:UIControlStateNormal];
        [self.btnShop setImage:[UIImage imageNamed:@"shopselected.png"] forState:UIControlStateNormal];
        [self.btnNews setImage:[UIImage imageNamed:@"news.png"] forState:UIControlStateNormal];
    }
    else if ([strSelection isEqualToString:@"4"]) {
        [self.btnSpices setImage:[UIImage imageNamed:@"spices.png"] forState:UIControlStateNormal];
        [self.btnDrinks setImage:[UIImage imageNamed:@"drinks.png"] forState:UIControlStateNormal];
        [self.btnShop setImage:[UIImage imageNamed:@"shop.png"] forState:UIControlStateNormal];
        [self.btnNews setImage:[UIImage imageNamed:@"newsselected.png"] forState:UIControlStateNormal];
    }
    else{
        [self.btnSpices setImage:[UIImage imageNamed:@"spices.png"] forState:UIControlStateNormal];
        [self.btnDrinks setImage:[UIImage imageNamed:@"drinks.png"] forState:UIControlStateNormal];
        [self.btnShop setImage:[UIImage imageNamed:@"shop.png"] forState:UIControlStateNormal];
        [self.btnNews setImage:[UIImage imageNamed:@"news.png"] forState:UIControlStateNormal];

    }
}

-(void) changeLanguage
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.btnChangeLanguage setTitle:@"Change Language" forState:UIControlStateNormal];
        [self.btnAboutUs setTitle:@"About Us" forState:UIControlStateNormal];
        [self.btnContactUs setTitle:@"Contact Us" forState:UIControlStateNormal];
        [self.btnOrderHistory setTitle:@"Order History" forState:UIControlStateNormal];
        [self.lblHeaderTitle setText:@"Spices"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.btnChangeLanguage setTitle:@"Sprache ändern" forState:UIControlStateNormal];
        [self.btnAboutUs setTitle:@"Über uns" forState:UIControlStateNormal];
        [self.btnContactUs setTitle:@"kontaktiere uns" forState:UIControlStateNormal];
        [self.btnOrderHistory setTitle:@"Bestellverlauf" forState:UIControlStateNormal];
        [self.lblHeaderTitle setText:@"Gewürze"];
    }

}
- (IBAction)btnOrderHistory:(id)sender {
    _drawerView.hidden=YES;
    [self.viewPopup setHidden:NO];
    _btnDrawer.tag=0;
    [UIView animateWithDuration:0.25 animations:^{            [_drawerView setAlpha:0.1f];
    } completion:^(BOOL finished) {
        _drawerView.hidden = YES;
    }];
    [self.btnDrawer setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
}

-(IBAction)btnSend:(id)sender
{
    _drawerView.hidden=YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"FETCHURL :%@",VALIDATEPASSCODE);
    NSLog(@"--->>%@",self.txtPasscode.text);
    [manager GET:[NSString stringWithFormat:VALIDATEPASSCODE,self.txtPasscode.text] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"RESPONSE--->> %@",dict);
        if ([dict[@"PassCode"] isEqualToString:@"Invalid PassCode"]) {
            UIAlertView *alerView=[[UIAlertView alloc]initWithTitle:nil message:dict[@"PassCode"] delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alerView show];
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:[self.txtPasscode text] forKey:@"passcode"];
            _viewPopup.hidden=YES;
            _drawerView.hidden = YES;
            strSelection=@"0";
            [self changeButtonLogo];
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HISTORY"];
            [self addChildViewController:vc];
            vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
            [self.containerView addSubview:vc.view];
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
                [self.lblHeaderTitle setText:@"Order History"];
            }
            else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
                [self.lblHeaderTitle setText:@"Bestellverlauf"];
            }

        }
        //-------PARSING-------
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"Please enter proper Passcode" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlert show];
    }];
    
    
}
-(IBAction)btnCancel:(id)sender
{
    [self.viewPopup setHidden:YES];
}

@end

