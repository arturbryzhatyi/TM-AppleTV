//
//  NSManagedObject+extension.m
//  cinemate
//
//  Created by miraving on 10.02.14.
//  Copyright (c) 2014 miraving. All rights reserved.
//

#import "NSManagedObject+extension.h"

@implementation NSManagedObject (extension)

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)object
{
	NSParameterAssert(object);
	return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:object];
}

@end
