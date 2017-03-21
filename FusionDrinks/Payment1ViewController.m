//
//  Payment1ViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 31/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "Payment1ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "JSONHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "PayPalMobile.h"

#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface Payment1ViewController ()
{
    NSString *qty;
    NSString *unitprice,*totalprice,*tprice;
    NSDictionary *params;
}
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;


@end

@implementation Payment1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewPopup.layer.borderWidth=1.0f;
    self.viewPopup.layer.borderColor=[UIColor colorWithRed:(242.0/255.0) green:(188.0/255.0) blue:(111.0/255.0) alpha:0.8].CGColor;
    NSURL *url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]objectForKey:@"productImage"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self.imgProduct setImage:[[UIImage alloc]initWithData:data]];
    [self.productName setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"productName"]];
    unitprice=[[NSUserDefaults standardUserDefaults]objectForKey:@"productPrice"];
    [self.lblUnitPrice setText:[@"UNIT PRICE : " stringByAppendingString:[@"€" stringByAppendingString:[NSString stringWithFormat:@"%@",unitprice]]]];
    [self.popupView setHidden:NO];
    NSLog(@"PASSCODE-->%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"]);
    /*---------PAYPAL-----------*/
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.languageOrLocale = @"EUR";
    _payPalConfig.merchantName = @"Awesome Shirts, Inc.";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.

    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;

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



- (IBAction)btnOk:(id)sender {
    if ([self.txtQuantity.text isEqualToString:@"0"]||[self.txtQuantity.text isEqualToString:@""]||[self.txtQuantity.text isEqualToString:@"00"]||[self.txtQuantity.text isEqualToString:@"000"]) {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:nil message:@"please enter more than 0" delegate:(id)self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alrt show];
    }
    else
    {
        [self.txtQuantity endEditing:YES];
        qty=[self.txtQuantity text];
        [self.popupView setHidden:YES];
        
        double n1=[qty doubleValue];
        double n2=[unitprice doubleValue];
        double result=n1*n2;
        tprice=[NSString stringWithFormat:@"%.2f",result];        totalprice=[@"€" stringByAppendingString:[NSString stringWithFormat:@"%.2f",result]];
        [self.lblTotalPrice setText:[@"TOTAL PRICE : " stringByAppendingString:totalprice]];
        [self.lblQuantity setText:qty];
    }
}

- (IBAction)btnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    }

-(void) showAlert:(NSString *)msg {
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [av show];
    
}

- (IBAction)btnSend:(id)sender {
    NSString *regexNumber = @"^[0-9]*$";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexNumber];
    
    NSString *regex = @"^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
   
    if(_txtFName.text.length<1) {
        [self showAlert:@"Please Enter First Name"];
    }
    else if(_txtLName.text.length<1) {
        [self showAlert:@"Please Enter Last Name"];
    }
    else if(_txtEmail.text.length<1) {
        [self showAlert:@"Please Enter Email"];
    }
    else if(![emailPredicate evaluateWithObject:self.txtEmail.text]) {
        [self showAlert:@"Please Enter Valid Email"];
        
    }
    else if(_txtPhone.text.length<1) {
        [self showAlert:@"Please Enter Phone no"];
    }
    else if(self.txtAddress.text.length<1) {
        [self showAlert:@"Please Enter Address"];
    }
  
    else if(_txtCity.text.length<1) {
        [self showAlert:@"Please Enter City"];
    }
    else if(_txtCountry.text.length<1) {
        [self showAlert:@"Please Enter Country"];
    }
    else if(_txtState.text.length<1) {
        [self showAlert:@"Please Enter State"];
    }
    else if(_txtPincode.text.length<1) {
        [self showAlert:@"Please Enter Pincode"];
    }
    else if(_txtQuantity.text.length<1) {
        [self showAlert:@"Please Enter Quantity"];
    }
    else if(![mobilePredicate evaluateWithObject:self.txtPincode.text]) {
        [self showAlert:@"Please Enter Valid Pincode"];
    }
    else if(![mobilePredicate evaluateWithObject:self.txtPhone.text]) {
        [self showAlert:@"Please Enter Valid Phone no"];
    }
    else if(![mobilePredicate evaluateWithObject:self.txtQuantity.text]) {
        [self showAlert:@"Please Enter Quantity in digits"];
    }
    
    else{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
     NSString* WebServiceURL = @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/OrderPaymentDetails";
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    NSString *fname =self.txtFName.text;
   // NSString *lname =self.txtLName.text;
    NSString *email =self.txtEmail.text;
    NSString *phone =self.txtPhone.text;
    NSString *address =self.txtAddress.text;
    NSString *city =self.txtAddress.text;
    NSString *state =self.txtState.text;
   // NSString *country =self.txtCountry.text;
    NSString *pincode =self.txtPincode.text;
    
    NSString *passcode=[def objectForKey:@"passcode"];
    NSString *shippingFess=@"0";
   // NSString *totalPrice1=[self.lblTotalPrice text];
    NSString *totalProduct=@"1";
  //  NSString *totlaQty=[self.lblQuantity text];
    
    NSString *productId=[def objectForKey:@"productId"];
   // NSString *productPrice=[self.lblUnitPrice text];
    
    NSDictionary *products = [NSDictionary dictionaryWithObjectsAndKeys:
                              productId,@"ProductID",
                              unitprice,@"ProductPrice",
                              qty,@"Qty",
                              nil];
    NSMutableArray *productList = [[NSMutableArray alloc] init];
    [productList addObject:products];

    params=[NSDictionary dictionaryWithObjectsAndKeys:@"NULL",@"Address1",address,@"Address2",city,@"City",email,@"EmailId",fname,@"Name",passcode,@"PassCode",phone,@"PhoneNo",pincode,@"Pincode",productList,@"Products",shippingFess,@"ShippingFees",state,@"State",tprice,@"TotalPrice",totalProduct,@"TotalProducts",qty,@"TotalQty",@"0",@"VAT", nil];
    
    
    NSLog(@"param::--%@",params);
   
    //[manager POST:@"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/OrderPaymentDetails" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"json array %@",params);
    NSString *jsonString = [[NSString alloc] init];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"String is %@",jsonString);
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        
        // Load the JSON string from our web serivce (in a background thread)
       
       NSDictionary *jsonResponse= [JSONHelper loadJSONDataFromPostURL:WebServiceURL postData:jsonString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[SVProgressHUD dismiss];
            NSLog(@"Reply from webservice is : %@",jsonResponse);
            NSDictionary *dc=jsonResponse[@"PaymentResp"];
            NSLog(@"---->>%@",dc[@"OrderId"]);
            [[NSUserDefaults standardUserDefaults] setObject:dc[@"OrderId"] forKey:@"orderId"];
            //[self Pay];
            
            [self PaymentService2];
        });
    });
    
    }
}
-(void)Pay
{
    NSString *productName=[[NSUserDefaults standardUserDefaults]objectForKey:@"productName"];
    
    // Note: For purposes of illustration, this example shows a payment that includes
    //       both payment details (subtotal, shipping, tax) and multiple items.
    //       You would only specify these if appropriate to your situation.
    //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
    //       and simply set payment.amount to your total charge.
    
    // Optional: include multiple items
       //double dqty=[[[NSUserDefaults standardUserDefaults]objectForKey:@""] doubleValue];
    // double duprice=[[[NSUserDefaults standardUserDefaults]objectForKey:@"productUnitPrice"] doubleValue];
    PayPalItem *item1 = [PayPalItem itemWithName:productName
                                    withQuantity:[qty intValue]
                                       withPrice:[NSDecimalNumber decimalNumberWithString:tprice]
                                    withCurrency:@"EUR"
                                         withSku:@"Hip-00037"];
    //  PayPalItem *item2 = [PayPalItem itemWithName:@"Free rainbow patch"
    //                                  withQuantity:1
    //                                     withPrice:[NSDecimalNumber decimalNumberWithString:@"0.00"]
    //                                  withCurrency:@"USD"
    //                                       withSku:@"Hip-00066"];
    //  PayPalItem *item3 = [PayPalItem itemWithName:@"Long-sleeve plaid shirt (mustache not included)"
    //                                  withQuantity:1
    //                                     withPrice:[NSDecimalNumber decimalNumberWithString:@"37.99"]
    //                                  withCurrency:@"USD"
    //                                       withSku:@"Hip-00291"];
    NSArray *items = @[item1];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"00.00"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"0.00"];
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"EUR";
    payment.shortDescription = @"FusionDrink Store";
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    
    
    if (!payment.processable) {
        
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = YES;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:(id)self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
    
    
}
#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    
    NSDictionary *resultDict = completedPayment.confirmation;
    
    
    NSDictionary *responseDict = [resultDict objectForKey:@"response"];
    
    NSLog(@"Paypal Transaction ID : %@",[responseDict objectForKey:@"id"]);
    NSString *example=[responseDict objectForKey:@"id"];
    
    [self confirmPayment:example];
    
}

-(void) confirmPayment:(NSString *)transactionId {
   //** NSString *tID=transactionId;
    //[SVProgressHUD showWithStatus:@"Loading..."];
    //http://46.163.104.177:180/Order.svc/json/SubmitOrder
    //old
    //http://46.163.104.177:180/Order.svc/json/ConfirmPayment
    //    NSString* WebServiceURL = @"http://46.163.104.177:180/Order.svc/json/ConfirmPayment";
    
    NSString *orderId=[[NSUserDefaults standardUserDefaults]objectForKey:@"orderId"];
    NSString* WebServiceURL = @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/ConformPaymentDetails";
    NSDictionary *requestObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithBool:YES],@"Status",
                                   orderId,@"OrderID",
                                   transactionId,@"PaymentTransactionID",
                                   nil];
    
    //NSLog(@"json array %@",requestObject);
    NSString *jsonString = [[NSString alloc] init];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestObject options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"String is %@",jsonString);
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        
        // Load the JSON string from our web serivce (in a background thread)
        NSDictionary *jsonResponse= [JSONHelper loadJSONDataFromPostURL:WebServiceURL postData:jsonString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // [SVProgressHUD dismiss];
            NSLog(@"Reply from webservice for confirm Order... : %@",jsonResponse);
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Payment Success"
                                                             message:[[NSString alloc] initWithFormat:@"Your order id is received for: \n Your transaction Id is:\n Your Order Id is: "]
                                  
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles: nil];
            
            [alert show];
            
        });
    });
    
    
    
    
}

-(void) PaymentService2
{
    //NSString *orderId=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"orderId"]];
    NSString *orderId=[[NSUserDefaults standardUserDefaults]objectForKey:@"orderId"];
    NSNumber *st=[NSNumber numberWithInt:1];
    NSString* WebServiceURL = @"http://ws-srv-net/Applications/Androids/FusionDrinks/FusionDrink.svc/json/ConformPaymentDetails";
    NSDictionary *requestObject = [NSDictionary dictionaryWithObjectsAndKeys:
                                   st,@"Status",
                                   orderId,@"OrderID",
                                   @"T0123456789",@"TransactionID",
                                   nil];
    
    //NSLog(@"json array %@",requestObject);
    NSString *jsonString = [[NSString alloc] init];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requestObject options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSLog(@"String is %@",jsonString);
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        
        // Load the JSON string from our web serivce (in a background thread)
        NSDictionary *jsonResponse= [JSONHelper loadJSONDataFromPostURL:WebServiceURL postData:jsonString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // [SVProgressHUD dismiss];
            NSLog(@"Reply from webservice for confirm Order... : %@",jsonResponse);
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Payment Successful"
                                                             message:nil
                                  
                                                            delegate:self
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"OK", nil];
            [alert setTag:2];
            [alert show];
            
        });
    });
    
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==2) {
        if (buttonIndex==0) {
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"1"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"Order History" forKey:@"title"];
            }
            else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"languageStatus"]isEqualToString:@"2"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"Bestellverlauf" forKey:@"title"];
            }
            [[NSUserDefaults standardUserDefaults]setObject:@"HISTORY" forKey:@"storyboardId"];
            UIViewController *viewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"PARENT"];
            [self presentViewController:viewcontroller animated:YES completion:nil];
        }
    }
    if (buttonIndex==0)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
