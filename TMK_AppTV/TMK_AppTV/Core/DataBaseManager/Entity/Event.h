//
//  Event.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoryItem;

NS_ASSUME_NONNULL_BEGIN

@interface Event : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (NSURL *)imageURL;

@end

NS_ASSUME_NONNULL_END

#import "Event+CoreDataProperties.h"
