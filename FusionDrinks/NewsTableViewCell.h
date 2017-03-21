//
//  NewsTableViewCell.h
//  FusionDrinks
//
//  Created by webmyne systems on 21/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblNewsTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblNewsDesc;
@property (weak, nonatomic) IBOutlet UIImageView *imgNews;
@end
