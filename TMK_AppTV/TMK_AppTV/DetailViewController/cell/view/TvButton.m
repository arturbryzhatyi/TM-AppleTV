//
//  TvButton.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 4/14/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "TvButton.h"

@implementation TvButton

- (void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator
{
    [super didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    
    if (context.nextFocusedView == self)
    {
        [coordinator addCoordinatedAnimations:^{
            
            self.transform = CGAffineTransformMakeScale(1.25, 1.25);
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
