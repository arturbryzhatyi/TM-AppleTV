//
//  CoreDataManager.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/30/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "CoreDataManager.h"

@implementation CoreDataManager

+ (NSDictionary *)concerts
{
    return @{@"Red Hot Chili peppers Live at Slane Castle Full Concert": @"nk5YtLYcH74",
             @"Muse - Live At Rome Olympic Stadium Hd Full Concert": @"lRAm65zf0Xw",
             @"Rammstein. Live in Nimes": @"UhS5Neq79R8",
             @"Scorpions Acoustica": @"xd70A1RjcIE",
             @"AC/DC live at River Plate full concert 2009": @"Es-3H2btM48",
             @"Rihanna - Diamonds Live at The Concert For Valor 2014": @"lmPmKezTeiw",
             @"ZZ TOP Live 'Full concert' FRANCE Nimes 2014": @"2_zd7pOJ8Hc"};
}

 + (NSString *)concertIDRandom
{
    NSArray *a = [[CoreDataManager concerts] allValues];
    
    int index = arc4random() % [a count];
    
    return a[index];
}

+ (NSString *)concertIDWithTerm:(NSString *)term
{
    NSString *result = nil;
    
    NSMutableDictionary *dict = [[CoreDataManager concerts] mutableCopy];
    
    NSArray *filterKey = [[dict allKeys] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", term]];
    
    if ([filterKey count] > 0)
    {
        result = dict[filterKey.firstObject];
    }
    else
    {
        result = [CoreDataManager concertIDRandom];
    }
    
    return result;
}

+ (BOOL)isZZTOP:(NSString *)eventName
{
    NSString *tmpStr = [[eventName componentsSeparatedByString:@":"] firstObject];
    
    tmpStr = [[tmpStr lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([tmpStr isEqualToString:@"zz top"])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isRIHANNA:(NSString *)eventName
{
    NSString *tmpStr = [[eventName componentsSeparatedByString:@":"] firstObject];
    
    tmpStr = [[tmpStr lowercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([[tmpStr lowercaseString] isEqualToString:@"rihanna"])
    {
        return YES;
    }
    return NO;
}

@end