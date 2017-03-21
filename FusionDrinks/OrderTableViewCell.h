//
//  OrderTableViewCell.h
//  FusionDrinks
//
//  Created by webmyne systems on 31/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UIImageView *lblImage;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;

@end
