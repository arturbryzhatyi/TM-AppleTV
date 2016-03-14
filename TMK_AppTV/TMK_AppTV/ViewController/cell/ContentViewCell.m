//
//  ContentViewCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ContentViewCell.h"

@interface ContentViewCell ()
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
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

@end
