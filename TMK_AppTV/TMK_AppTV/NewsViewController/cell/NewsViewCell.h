//
//  NewsViewCell.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
