//
//  DrinkViewController.h
//  FusionDrinks
//
//  Created by webmyne systems on 18/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAnimationAndTransiotion.h"

@interface DrinkViewController : UIViewController

@property (strong,nonatomic)CustomAnimationAndTransiotion *customTransitionController;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
