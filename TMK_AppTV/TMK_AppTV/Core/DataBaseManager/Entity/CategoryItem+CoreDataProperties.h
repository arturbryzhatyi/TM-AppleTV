//
//  CategoryItem+CoreDataProperties.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CategoryItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSSet<Event *> *event;

@end

@interface CategoryItem (CoreDataGeneratedAccessors)

- (void)addEventObject:(Event *)value;
- (void)removeEventObject:(Event *)value;
- (void)addEvent:(NSSet<Event *> *)values;
- (void)removeEvent:(NSSet<Event *> *)values;

@end

NS_ASSUME_NONNULL_END
