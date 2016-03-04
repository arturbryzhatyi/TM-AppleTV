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

+ (void)parseEventJSON:(NSDictionary *)dict success:(void(^)(id objects))success
{
    NSMutableArray *mArr = [NSMutableArray new];
    
    IfDictionaryValueNotNull(dict)
    {
        NSArray *events = dict[@"_embedded"][@"events"];
        IfArrayValueNotNull(events)
        {
            for (NSDictionary *object in events)
            {
                id value = object[@"id"];
                IfStringValueNotNull(value)
                {
                    DatabaseManager *dataManager = [Core sharedInstance].databaseManager;
                    
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
                    
                    [dataManager saveContext];
                    
                    [mArr addObject:nEvent];
                }
            }
        }
    }
    
    if (success)
    {
        success([NSArray arrayWithArray:mArr]);
    }
}

@end
