//
//  WelcomeViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.btnConfirm.layer.borderWidth=1.0f;
    self.btnConfirm.layer.borderColor=[UIColor colorWithRed:(242.0/255.0) green:(188.0/255.0) blue:(111.0/255.0) alpha:1.0f].CGColor;
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"languageStatus"];
    [self setLanguage];
    [[NSUserDefaults standardUserDefaults]setObject:@"SPICES" forKey:@"storyboardId"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Spices" forKey:@"title"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Gewürze" forKey:@"title"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnEnglishLanguage:(id)sender {
   
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"languageStatus"];
    [self setLanguage];
  
}
- (IBAction)btnGermanLanguage:(id)sender {
    
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"languageStatus"];
    [self setLanguage];
}
-(void)setLanguage
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"1"])
    {
         [self.lblDesc setText:@"LILAH is committed to responsible alcohol consumption. This website can only be a accessed by person of legal drinking age. Please respect the law of your country. By clicking the button, you confirm to have reached the legal age."];
        [self.btnConfirm setTitle:@"Confirm" forState:UIControlStateNormal];
        [self.lblWelcome setText:@"WELCOME"];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"] isEqualToString:@"2"])
    {
        [self.lblDesc setText:@"LILAH ist verantwortlich Alkoholkonsum begangen . Diese Website kann nur von Person gesetzliche Mindestalter erreicht werden. Bitte beachten Sie das Recht Ihres Landes. Mit einem Klick auf den Button , bestätigen Sie das gesetzliche Alter erreicht zu haben ."];
        [self.btnConfirm setTitle:@"Bestätigen" forState:UIControlStateNormal];
        [self.lblWelcome setText:@"HERZLICH WILLKOMMEN"];
    }
}
@end
