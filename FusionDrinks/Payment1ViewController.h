//
//  Payment1ViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 31/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
@interface Payment1ViewController : UIViewController
@property(nonatomic, strong, readwrite) NSString *environment;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantity;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;

@property (weak, nonatomic) IBOutlet UIView *popupView;

@property (weak, nonatomic) IBOutlet UITextField *txtFName;
@property (weak, nonatomic) IBOutlet UITextField *txtLName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;

@property (weak, nonatomic) IBOutlet UITextField *txtState;

@property (weak, nonatomic) IBOutlet UITextField *txtCountry;

@property (weak, nonatomic) IBOutlet UITextField *txtPincode;
- (IBAction)btnSend:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtQuantity;
@property (weak, nonatomic) IBOutlet UIButton *btnOk;
- (IBAction)btnOk:(id)sender;

- (IBAction)btnCancel:(id)sender;
@end
