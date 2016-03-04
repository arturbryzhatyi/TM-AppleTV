//
//  Event+CoreDataProperties.h
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Event.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *localDateTime;
@property (nullable, nonatomic, retain) id images;
@property (nullable, nonatomic, retain) NSSet<CategoryItem *> *category;

@end

@interface Event (CoreDataGeneratedAccessors)

- (void)addCategoryObject:(CategoryItem *)value;
- (void)removeCategoryObject:(CategoryItem *)value;
- (void)addCategory:(NSSet<CategoryItem *> *)values;
- (void)removeCategory:(NSSet<CategoryItem *> *)values;

@end

NS_ASSUME_NONNULL_END
