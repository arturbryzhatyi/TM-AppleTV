//
//  DatabaseManager.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Event.h"
#import "Segment.h"
#import "Genre.h"


@interface DatabaseManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

- (void)removeOldEvents;

- (NSSet *)fetchObjectsForEntityName:(NSString *)newEntityName
                       withPredicate:(id)stringOrPredicate, ...;

- (NSSet *)fetchUniqueObjectsForEntityName:(NSString *)newEntityName;
@end
