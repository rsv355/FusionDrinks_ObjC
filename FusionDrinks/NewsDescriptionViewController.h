//
//  NewsDescriptionViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDescriptionViewController : UIViewController
- (IBAction)btnClose:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageNews;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *lblDescription;

@end
