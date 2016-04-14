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

- (void)setFocus:(BOOL)flag
{
    CGFloat delata = 10;
    CGRect currFrame = self.frame;
    CGRect lRect = self.gradient.bounds;
    
    if (flag)
    {
        currFrame.origin.x -= delata;
        currFrame.origin.y -= delata;
        currFrame.size.height += delata*2;
        currFrame.size.width += delata*2;
        lRect.size = currFrame.size;
        [self.gradient setFrame:lRect];
    }
    else
    {
        currFrame.origin.x += delata;
        currFrame.origin.y += delata;
        currFrame.size.height -= delata*2;
        currFrame.size.width -= delata*2;
    }
    
    
    [UIView animateWithDuration:.2f animations:^{
    
        [self setFrame:currFrame];
    }];
    
}

@end
