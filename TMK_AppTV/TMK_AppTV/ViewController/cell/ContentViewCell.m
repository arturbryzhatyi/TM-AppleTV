//
//  ContentViewCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ContentViewCell.h"
#import "Core.h"

@interface ContentViewCell ()
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation ContentViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.imageView.userInteractionEnabled = YES;
    self.imageView.adjustsImageWhenAncestorFocused = YES;
}

- (void)setSelected:(BOOL)selected
{
}

- (void)setSlideImagesURL:(NSArray *)urlArray
{
#warning TODO
    return;
    __block NSUInteger countImage = [urlArray count];
    
    self.imageArray = [[NSMutableArray alloc] initWithCapacity:countImage];
    
    for (NSString *strURL in urlArray)
    {
        if ([strURL length] > 0)
        {
            [[Core sharedInstance] downloadImage:strURL success:^(id object) {
                
                if ([object isKindOfClass:[UIImage class]])
                {
                    [_imageArray addObject:object];
                }
                
                if ([_imageArray count] == countImage && ![_imageView isAnimating])
                {
                    [self.imageView setAnimationDuration:10];
                    [self.imageView setAnimationImages:_imageArray];
                    [self.imageView startAnimating];
                }
            }];
        }
    }
}

@end
