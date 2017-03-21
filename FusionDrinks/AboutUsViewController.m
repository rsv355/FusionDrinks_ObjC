//
//  AboutUsViewController.m
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLabelValues];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLabelValues
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"languageStatus"] isEqualToString:@"1"]) {
        [self.lbl1 setText:@"This is LILAH."];
        [self.lbl2 setText:@"The contemporary interpretation of a traditional beverage."];
        [self.lbl3 setText:@"A soft cream liqueur flavored with selected spices from the Far East that presents the popular Chai tea as a new experience in taste."];
    }
    else  if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"languageStatus"] isEqualToString:@"2"]) {
        [self.lbl1 setText:@"Dies ist LILAH"];
        [self.lbl2 setText:@"Die moderne Interpretation eines traditionellen Getränks."];
        [self.lbl3 setText:@"Eine weiche Sahnelikör mit ausgewählten Gewürzen aus dem Fernen Osten gewürzt , das die populäre Chai Tee als neues Geschmackserlebnis präsentiert."];
    }
}
@end
