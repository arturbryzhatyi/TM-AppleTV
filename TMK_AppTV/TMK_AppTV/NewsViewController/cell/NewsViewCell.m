//
//  NewsViewCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "NewsViewCell.h"

@interface NewsViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation NewsViewCell

- (void)setTitleText:(NSString *)value
{
    [self.titleLabel setText:value];
    [self.imageView setImage:nil];
    [self setTextColor:[UIColor blackColor]];
}

- (void)setImage:(UIImage *)image
{
    if (image)
    {
        [self.imageView setImage:image];   
        [self setTextColor:[UIColor whiteColor]];
    }
}

- (void)setTextColor:(UIColor *)color
{
    [self.titleLabel setTextColor:color];
    [self.descriptionLabel setTextColor:color];
    [self.sourceLabel setTextColor:color];
    [self.dateLabel setTextColor:color];
}

@end
