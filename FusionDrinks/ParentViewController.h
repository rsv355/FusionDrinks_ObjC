//
//  ParentViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentViewController : UIViewController
- (IBAction)btnDrawer:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrawer;
@property (weak, nonatomic) IBOutlet UIView *drawerView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;


- (IBAction)btnSpices:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSpices;

- (IBAction)btnDrinks:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDrinks;

- (IBAction)btnShop:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnShop;

- (IBAction)btnNews:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnNews;

- (IBAction)btnChangeLanguage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeLanguage;

- (IBAction)btnAboutUs:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAboutUs;

- (IBAction)btnContactUs:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnContactUs;

- (IBAction)btnOrderHistory:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOrderHistory;

@property (weak, nonatomic) IBOutlet UITextField *txtPasscode;
- (IBAction)btnSend:(id)sender;
-(IBAction)btnCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UILabel *lblPasscode;
@end
