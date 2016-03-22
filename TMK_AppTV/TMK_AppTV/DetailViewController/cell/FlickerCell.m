//
//  FlickerCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/21/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "FlickerCell.h"
#import "Core.h"
#import "Event.h"
#import "ContentViewCell.h"
#import <FlickrKit.h>
#import <UIImageView+AFNetworking.h>


@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@interface FlickerCell ()
@end

@implementation FlickerCell

- (void)setEventWithID:(NSString *)objectID;
{
    NSParameterAssert(objectID);
    Event *event = nil;
    NSSet *fetchObject = [[Core sharedInstance].databaseManager fetchObjectsForEntityName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"id == %@", objectID]];
    if ([fetchObject count] == 1)
    {
        event = (Event *)[fetchObject anyObject];
    }
    
    NSParameterAssert(event);
    
    
    NSString *tags = [event.name stringByReplacingOccurrencesOfString:@" " withString:@","];
//    tags = [tags stringByAppendingFormat:@",%@", event.genres.allObjects.firstObject.name];
    
    NSString *unfilteredString = event.name;//@"!@#$%^&*()_+|abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@" abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    NSString *resultString = [[unfilteredString componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
    NSLog (@"Result: %@", resultString);
    
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    NSDictionary *args = @{@"api_key": fk.apiKey,
                           @"text": event.name,
                           @"tags": tags,
                           @"tag_mode": @"AND"};
    
    [fk call:@"flickr.photos.search" args:args completion:^(NSDictionary *response, NSError *error) {
        
        if (response)
        {
            NSMutableArray *photoURLs = [NSMutableArray array];
            
            for (NSDictionary *photoData in [response valueForKeyPath:@"photos.photo"])
            {
                NSURL *url = [fk photoURLForSize:FKPhotoSizeSmall320 fromPhotoDictionary:photoData];
                [photoURLs addObject:url];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // Any GUI related operations here
                
                [self setObjects:photoURLs];
            });
        }
        else if (error)
        {
            NSLog(@"Flicker ERROR: %@", error.localizedDescription);
        }
    }];
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = self.objects[indexPath.row];
    [cell.imageView setImageWithURL:url];
}

@end
