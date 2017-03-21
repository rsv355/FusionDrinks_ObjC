//
//  WelcomeViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
- (IBAction)btnEnglishLanguage:(id)sender;
- (IBAction)btnGermanLanguage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;
@end
