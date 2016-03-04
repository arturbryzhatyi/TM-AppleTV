//
//  NSManagedObject+extension.h
//  cinemate
//
//  Created by miraving on 10.02.14.
//  Copyright (c) 2014 miraving. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (extension)

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)object;

@end
