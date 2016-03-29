//
//  SearchCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (BOOL)shouldUpdateFocusInContext:(UIFocusUpdateContext *)context
{
    [context.nextFocusedView updateConstraints];
    [context.previouslyFocusedView updateConstraints];
    
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
