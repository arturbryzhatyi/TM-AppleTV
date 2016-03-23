//
//  Event.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/14/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "Event.h"
#import "Genre.h"
#import "Segment.h"

@implementation Event

- (NSString *)segmentKey
{
    NSString *tmp = self.segment.name;
    return tmp;
}

- (NSString *)genre
{
    NSArray *a = [[self genres] allObjects];
    
    NSString *result = [(Genre *)a.firstObject name];
    
    if ([[result lowercaseString] isEqualToString:@"undefined"])
        result = @"";
    
    return result;
}

- (NSURL *)imageURL
{
    NSArray *a = [self images];
    
    a = [a sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *d1 = obj1;
        NSString *d2 = obj2;
        
        return [d2 compare:d1];
        
    }];
    
    if ([a count] > 0)
    {
        NSURL *url = [NSURL URLWithString:[a firstObject]];
        
        return url;
    }
    return nil;
}

@end
