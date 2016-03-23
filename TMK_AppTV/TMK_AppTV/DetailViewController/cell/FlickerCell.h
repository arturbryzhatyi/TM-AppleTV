//
//  FlickerCell.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/21/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "TableViewCell.h"

@interface FlickerCell : TableViewCell

+ (CGFloat)defHeight;

- (void)setEventWithID:(NSString *)objectID;

@end
