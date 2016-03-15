//
//  ContentViewCell.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;


- (void)setSlideImagesURL:(NSArray *)urlArray;

@end
