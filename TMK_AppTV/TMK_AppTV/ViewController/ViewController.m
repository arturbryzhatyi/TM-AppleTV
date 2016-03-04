//
//  ViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/1/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ViewController.h"
#import "Core.h"
#import "ContentViewCell.h"
#import "ContentReusableView.h"
#import <UIImageView+AFNetworking.h>

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[Core sharedInstance] searchKey:@"Event" success:^(id object) {
        
//        NSLog(@">>> %@", object);
    }];
}

- (UIView *)preferredFocusedView
{
    return self.collectionView;
}

#pragma mark - Collection view data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSInteger count = [sectionInfo numberOfObjects];
    return count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(0, 450);
    }
    
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ContentReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerContentView" forIndexPath:indexPath];
    

    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"conetentCell" forIndexPath:indexPath];
    
    Event *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell.textLabel setText:[item name]];
    [cell.imageView setImageWithURL:item.imageURL];
    
    return cell;
}

#pragma mark - Collection view flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 5;
    CGFloat height = [UIScreen mainScreen].bounds.size.height / 5;
    return CGSizeMake(width, height);
}

#pragma mark - Collection view focus
- (NSIndexPath *)indexPathForPreferredFocusedViewInCollectionView:(UICollectionView *)collectionView
{
    return [NSIndexPath indexPathForRow:0 inSection:0];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldUpdateFocusInContext:(UICollectionViewFocusUpdateContext *)context
{
    ContentViewCell *cell = (ContentViewCell *)[collectionView cellForItemAtIndexPath:context.nextFocusedIndexPath];
    [collectionView bringSubviewToFront:cell];
    [cell.contentView layoutIfNeeded];
    
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath == collectionView.indexPathsForSelectedItems.firstObject)
    {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        return NO;
    }
    return YES;
}

#pragma mark - NSFetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController)
        return _fetchedResultsController;
    
    NSManagedObjectContext *managedContext = [[Core sharedInstance].databaseManager managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"localDateTime" ascending:NO];
    [fetchRequest setSortDescriptors:@[sort]];
    [fetchRequest setFetchLimit:8];
    
    [NSFetchedResultsController deleteCacheWithName:@"cache"];
    
    NSFetchedResultsController *theFRController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedContext
                                          sectionNameKeyPath:nil
                                                   cacheName:@"cache"];
    
    [theFRController performFetch:nil];
    [theFRController setDelegate:self];
    
    _fetchedResultsController = theFRController;
    
    return _fetchedResultsController;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath
{
    switch (type)
    {
        case NSFetchedResultsChangeUpdate:
        {
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }
        case NSFetchedResultsChangeDelete:
        {
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            break;
        }
        case NSFetchedResultsChangeInsert:
        {
            [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
            [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
            break;
        }
    }
}

@end








