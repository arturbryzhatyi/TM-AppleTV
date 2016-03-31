//
//  FlickerCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/21/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "FlickerCell.h"
#import <FlickrKit.h>
#import "Core.h"
#import "TextAnalyzer.h"


@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@interface FlickerCell ()
@end

@implementation FlickerCell

+ (CGFloat)defHeight
{
    return 400;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumInteritemSpacing = 10000.0f;
}

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
    
    NSString *name = @"";
    NSString *tags = @"";
    
    if ([CoreDataManager isZZTOP:event.name])
    {
        name = @"ZZ TOP";
        tags = @"rock, music, concert";
    }
    else if ([CoreDataManager isRIHANNA:event.name])
    {
        name = @"rihanna";
        tags = @"pop, rnb, music, concert";
    }
    else
    {
        NSCharacterSet *separetaCharacter = [NSCharacterSet characterSetWithCharactersInString:@"':[],!?"];
        
        NSArray *a = [event.name componentsSeparatedByCharactersInSet:separetaCharacter];
        
        name = [a firstObject];
        if ([name length] > 11)
        {
            name = [[name componentsSeparatedByString:@" "] firstObject];
        }
        
        
        tags = [[event.name componentsSeparatedByString:@" "] componentsJoinedByString:@","];
    }
    
    FlickrKit *fk = [FlickrKit sharedFlickrKit];
    NSDictionary *args = @{@"api_key": fk.apiKey,
                           @"text": name,
                           @"tags": tags,
                           @"tag_mode": @"OR",
                           @"safe_search": @"1"};
    
    [fk call:@"flickr.photos.search" args:args maxCacheAge:FKDUMaxAgeNeverCache completion:^(NSDictionary *response, NSError *error) {
        
        if (response)
        {
            NSMutableArray *photoURLs = [NSMutableArray array];
            
            NSArray *photoResponce = [response valueForKeyPath:@"photos.photo"];
        
            
            if ([photoResponce count] == 0)
                NSLog(@"Flickr: No result for = [%@]", tags);
            
            if ([photoResponce count] > 15)
            {
                photoResponce = [photoResponce subarrayWithRange:NSMakeRange(0, 15)];
            }
            
            for (NSDictionary *photoData in photoResponce)
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
            NSLog(@"Flicker ERROR: %@ [%@]", error.localizedDescription, tags);
        }
    }];
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = self.objects[indexPath.row];
    [cell.imageView setImageWithURL:url];
}

@end
