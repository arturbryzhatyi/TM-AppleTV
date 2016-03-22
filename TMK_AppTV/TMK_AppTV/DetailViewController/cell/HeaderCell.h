//
//  HeaderCell.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/21/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"


@interface HeaderCell : UITableViewCell

+ (CGFloat)defHeight;

- (void)setEventWithID:(NSString *)eventID;

@end
