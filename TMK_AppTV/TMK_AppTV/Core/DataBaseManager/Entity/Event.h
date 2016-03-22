//
//  Event.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/14/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Genre, Segment;

NS_ASSUME_NONNULL_BEGIN

@interface Event : NSManagedObject

- (NSString *)segmentKey;

- (NSString *)genre;
- (NSURL *)imageURL;

@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
