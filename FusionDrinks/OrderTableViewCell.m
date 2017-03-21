//
//  OrderTableViewCell.m
//  FusionDrinks
//
//  Created by webmyne systems on 31/03/16.
//  Copyright © 2016 webmyne systems. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.viewPopup.layer.borderWidth=1.0f;
    self.viewPopup.layer.borderColor=[UIColor colorWithRed:(242.0/255.0) green:(188.0/255.0) blue:(111.0/255.0) alpha:0.8].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
