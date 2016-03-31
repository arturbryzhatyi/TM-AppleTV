//
//  SearchTextField.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/31/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "SearchTextField.h"

@implementation SearchTextField

- (void)insertDictationResult:(NSArray<UIDictationPhrase *> *)dictationResult
{
    if ([self.delegate respondsToSelector:@selector(textFieldDictation:)])
    {
        [self.delegate performSelector:@selector(textFieldDictation:) withObject:dictationResult];
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
