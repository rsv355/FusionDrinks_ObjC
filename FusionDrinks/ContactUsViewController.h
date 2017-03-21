//
//  ContactUsViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "UITextView+Placeholder.h"
#import <MessageUI/MessageUI.h>
@interface ContactUsViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNo;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtSubject;
@property (weak, nonatomic) IBOutlet UITextView *txtMessageView;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
- (IBAction)btnSend:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
