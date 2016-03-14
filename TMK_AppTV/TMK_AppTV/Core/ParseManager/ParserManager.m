//
//  ParserManager.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/3/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ParserManager.h"
#import "NSManagedObject+extension.h"
#import "Core.h"

@implementation ParserManager

- (void)parseEventJSON:(NSDictionary *)dict success:(void(^)(id objects))success
{
    NSMutableArray *mArr = [NSMutableArray new];
    
    IfDictionaryValueNotNull(dict)
    {
        NSArray *events = dict[@"_embedded"][@"events"];
        IfArrayValueNotNull(events)
        {
            DatabaseManager *dataManager = [Core sharedInstance].databaseManager;

            for (NSDictionary *object in events)
            {
                id value = object[@"id"];
                IfStringValueNotNull(value)
                {
                    
                    NSSet *searchResult = [dataManager fetchObjectsForEntityName:@"Event"
                                                                                    withPredicate:[NSPredicate predicateWithFormat:@"id == %@", value]];
                    
                    Event *nEvent = nil;
                    
                    if ([searchResult.allObjects count] > 0) {
                        
                        continue;
                    } else {
                        
                        nEvent = [Event insertInManagedObjectContext:dataManager.managedObjectContext];
                        nEvent.id = value;
                    }
                    
                    value = object[@"name"];
                    IfStringValueNotNull(value)
                    {
                        nEvent.name = value;
                    }
                    
                    value = object[@"dates"];
                    IfDictionaryValueNotNull(value)
                    {
                        NSDictionary *d = value[@"start"];
                        NSString *strDate = d[@"localDate"];
                        NSString *strTime = d[@"localTime"];
                        
                        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                        [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date = [formater dateFromString:[strDate stringByAppendingFormat:@" %@", strTime]];
                        
                        nEvent.localDateTime = date;
                    }
                    
                    value = object[@"images"];
                    IfArrayValueNotNull(value)
                    {
                        NSMutableArray *mArray = [NSMutableArray new];
                        for (NSDictionary *image in value)
                        {
                            if ([image isKindOfClass:[NSDictionary class]])
                            {
                                [mArray addObject:image[@"url"]];
                            }
                        }
                        
                        if ([mArray count] > 0)
                        {
                            nEvent.images = [NSArray arrayWithArray:mArray];
                        }
                    }
                    
                    value = object[@"classifications"];
                    IfArrayValueNotNull(value)
                    {
                        for (NSDictionary *dict in value)
                        {
                            if (dict[@"genre"])
                            {
                                Genre *genre = [self getGenreWithID:dict[@"genre"][@"id"]];
                                if (genre == nil)
                                {
                                    genre = [Genre insertInManagedObjectContext:dataManager.managedObjectContext];
                                    genre.id = dict[@"genre"][@"id"];
                                    genre.name = dict[@"genre"][@"name"];
                                }
                                
                                [nEvent addGenresObject:genre];
                            }
                            
                            if (dict[@"segment"])
                            {
                                Segment *segment = [self getSegmentWithID:dict[@"segment"][@"id"]];
                                if (segment == nil)
                                {
                                    segment = [Segment insertInManagedObjectContext:dataManager.managedObjectContext];
                                    segment.id = dict[@"segment"][@"id"];
                                    segment.name = dict[@"segment"][@"name"];
                                }
                                
                                nEvent.segment = segment;
                            }
                            
                            if (dict[@"subGenre"])
                            {
                                Genre *genre = [self getGenreWithID:dict[@"subGenre"][@"id"]];
                                if (genre == nil)
                                {
                                    genre = [Genre insertInManagedObjectContext:dataManager.managedObjectContext];
                                    genre.id = dict[@"subGenre"][@"id"];
                                    genre.name = dict[@"subGenre"][@"name"];
                                }
                                
                                [nEvent addGenresObject:genre];
                            }
                        }
                    }
                    
                    [mArr addObject:nEvent];
                }
                
            }
            
            [dataManager saveContext];
        }
    }
    
    if (success)
    {
        success([NSArray arrayWithArray:mArr]);
    }
}

- (Segment *)getSegmentWithID:(NSString *)objectID
{
    NSSet *set = [[[Core sharedInstance] databaseManager] fetchObjectsForEntityName:@"Segment" withPredicate:[NSPredicate predicateWithFormat:@"id == %@", objectID]];
    
    if ([set count] > 0)
    {
        return set.allObjects.firstObject;
    }
    
    return nil;
}

- (Genre *)getGenreWithID:(NSString *)objectID
{
    NSSet *set = [[[Core sharedInstance] databaseManager] fetchObjectsForEntityName:@"Genre" withPredicate:[NSPredicate predicateWithFormat:@"id == %@", objectID]];
    
    if ([set count] > 0)
    {
        return set.allObjects.firstObject;
    }
    
    return nil;
}

@end
