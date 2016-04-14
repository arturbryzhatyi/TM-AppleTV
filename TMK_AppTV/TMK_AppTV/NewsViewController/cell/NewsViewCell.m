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
@property (nonatomic, strong) CAGradientLayer *gradient;
@end

@implementation NewsViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.gradient = [CAGradientLayer layer];
    self.gradient.frame = self.bounds;
    self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:.3f] CGColor],
                       (id)[[UIColor colorWithRed:0.380 green:0.380 blue:0.380 alpha:.2f] CGColor], nil];
    [self.layer insertSublayer:self.gradient atIndex:0];
}


- (void)setTitleText:(NSString *)value
{
    [self.titleLabel setText:[value uppercaseString]];
    [self.imageView setImage:nil];
//    [self setTextColor:[UIColor blackColor]];
}

- (void)setImage:(UIImage *)image
{
    if (image)
    {
//        [self.imageView setImage:image];   
//        [self setTextColor:[UIColor whiteColor]];
    }
}

- (void)setTextColor:(UIColor *)color
{
    [self.titleLabel setTextColor:color];
    [self.descriptionLabel setTextColor:color];
    [self.sourceLabel setTextColor:color];
    [self.dateLabel setTextColor:color];
}

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    if (context.nextFocusedView == self)
    {
        [coordinator addCoordinatedAnimations:^{
            
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
            [self layoutIfNeeded];
            
        } completion:nil];
    }
    else if (context.previouslyFocusedView == self)
    {
        [coordinator addCoordinatedAnimations:^{
            
            self.transform = CGAffineTransformMakeScale(1, 1);
            [self layoutIfNeeded];
            
        } completion:nil];
    }
}

@end
