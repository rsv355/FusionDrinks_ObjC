//
//  ContactUsViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "ContactUsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setLanguageValues];
    
//    NSString *lat=@"47.279711";
//    NSString *longs=@"8.459705";
    CLLocationCoordinate2D  ctrpoint;
    ctrpoint.latitude = 47.279711;
    ctrpoint.longitude =8.459705;
    MKPointAnnotation *addAnnotation = [[MKPointAnnotation alloc] init];
    [addAnnotation setCoordinate:ctrpoint];
    [addAnnotation setTitle:@"Title"];
    [self.mapView addAnnotation:addAnnotation];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 47.279711;
    coordinate.longitude = 8.459705;
    _mapView.region = MKCoordinateRegionMakeWithDistance(coordinate, 2000, 2000);
    
   

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    
    NSDictionary *userInfo = [aNotification userInfo];
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect windowFrame = [self.view.window convertRect:self.view.frame fromView:self.view];
    CGRect keyboardFrame = CGRectIntersection (windowFrame, keyboardInfoFrame);
    CGRect coveredFrame = [self.view.window convertRect:keyboardFrame toView:self.view];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake (0.0, 0.0, coveredFrame.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.frame.size.width, self.scrollView.contentSize.height)];
    
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


-(BOOL) validateEmail:(NSString*) emailString{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
    //NSLog(@"%lu", (unsigned long)regExMatches);
    if (regExMatches == 0){
        return NO;
    }
    else
        return YES;
}



- (IBAction)btnSend:(id)sender {
    if ([self.txtEmail.text isEqualToString:@""]&&[self.txtMessageView.text isEqualToString:@""]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please fill all the details" message:nil delegate:(id)self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(![self validateEmail:self.txtEmail.text]){
        UIAlertView *emailvalid = [[UIAlertView alloc]initWithTitle:@"Please Enter  E-mail Address Properly." message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [emailvalid show];
        
        self.txtEmail.textColor = [UIColor redColor];
    }

    else{
    // Email Subject
    NSString *emailTitle = [self.txtSubject text];
    // Email Content
    NSString *messageBody = [self.txtMessageView text]; // Change the message body to HTML
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"miralai@daryabsofe.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];

}

-(void)setLanguageValues
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
        [self.lblAddress setText:@"Fusion Drinks GmbH \nRebhaldenstrasse 98910 \nAffoltern am Albis"];
        [self.lblPhoneNo setText:@"Call us ﻿\n+4176 576 77 26"];
        [self.txtName setPlaceholder:@"Name"];
        [self.txtEmail setPlaceholder:@"Email"];
        [self.txtSubject setPlaceholder:@"Subject"];
        [self.txtMessageView setPlaceholder:@"Message"];
        [self.btnSend setTitle:@"Send" forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
        [self.lblAddress setText:@"Fusion Drinks GmbH \nRebhaldenstrasse 98910 \nAffoltern am Albis"];
        [self.lblPhoneNo setText:@"rufen Sie uns \n﻿+4176 576 77 26"];
        [self.txtName setPlaceholder:@"Name"];
        [self.txtEmail setPlaceholder:@"Fach"];
        [self.txtSubject setPlaceholder:@"Email"];
        [self.txtMessageView setPlaceholder:@"Nachricht"];
        [self.btnSend setTitle:@"Senden" forState:UIControlStateNormal];
    }
}
@end
