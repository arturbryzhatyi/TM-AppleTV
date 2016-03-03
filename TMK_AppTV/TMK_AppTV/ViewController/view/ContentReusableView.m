//
//  ContentReusableView.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/2/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ContentReusableView.h"

@interface ContentReusableView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ContentReusableView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
    self.imageView.userInteractionEnabled = YES;
    self.imageView.adjustsImageWhenAncestorFocused = YES;
}

@end
