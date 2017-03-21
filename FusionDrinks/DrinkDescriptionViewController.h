//
//  DrinkDescriptionViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkDescriptionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblPasscode;
- (IBAction)btnClose:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)btnNext:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPrevious;
- (IBAction)btnPrevious:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
- (IBAction)btnSend:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnRequestCode:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEnterPasscode;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@end
