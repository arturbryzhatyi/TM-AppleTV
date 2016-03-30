//
//  CoreDataManager.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/30/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

+ (NSString *)concertIDRandom;
+ (NSString *)concertIDWithTerm:(NSString *)term;
@end
