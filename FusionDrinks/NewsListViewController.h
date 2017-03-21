//
//  NewsListViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAnimationAndTransiotion.h"

@interface NewsListViewController : UIViewController
@property (strong,nonatomic)CustomAnimationAndTransiotion *customTransitionController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
