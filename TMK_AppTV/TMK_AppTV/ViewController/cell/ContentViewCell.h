//
//  ContentViewCell.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *eventID;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (void)setSlideImagesURL:(NSArray *)urlArray;

@end
