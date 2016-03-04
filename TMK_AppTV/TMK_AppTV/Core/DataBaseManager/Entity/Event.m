//
//  Event.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "Event.h"
#import "CategoryItem.h"

@implementation Event

// Insert code here to add functionality to your managed object subclass

- (NSURL *)imageURL
{
    NSArray *a = self.images;
    
    return [NSURL URLWithString:a.firstObject];
}

@end
