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
#import "CarouselView.h"
#import "CategoryReusableView.h"
#import <UIImageView+AFNetworking.h>

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (weak, nonatomic) IBOutlet CarouselView *caruselView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[Core sharedInstance] searchKey:@"LA" success:^(id object) {
        
        NSLog(@">>> %@", object);
        
        [self.caruselView setObjects:object];
    }];
    
    NSSet *set = [[Core sharedInstance].databaseManager fetchObjectsForEntityName:@"Event" withPredicate:nil];
    [self.caruselView setObjects:set.allObjects];
    [self setBlur:set.anyObject];
}

- (UIView *)preferredFocusedView
{
    return self.collectionView;
}

- (void)setBlur:(Event *)event
{
    if (event)
    {
        [self.blurImageView setImageWithURL:event.imageURL];
    }
}

#pragma mark - Collection view data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger intCount = [[self.fetchedResultsController sections] count];
    return intCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSInteger count = [sectionInfo numberOfObjects];
    
    Segment *segm = [self.fetchedResultsController fetchedObjects][section];
    
    count = segm.event.count;
    
    if (count > 4)
    {
        count = 4;
    }
    
    return count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CategoryReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"categoryReusableView" forIndexPath:indexPath];
    
    Segment *seg = self.fetchedResultsController.fetchedObjects[indexPath.section];
    
    if (indexPath.section == 0)
    {
        [self setBlur:seg.event.anyObject];
    }
    
    [view.titleLabel setText:seg.name];

    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"conetentCell" forIndexPath:indexPath];
    
    [self configureCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    Segment *item = [self.fetchedResultsController fetchedObjects][indexPath.section];
    
    Event *e = item.event.allObjects[indexPath.row];
    
    [cell.textLabel setText:[e name]];
    [cell.imageView setImageWithURL:e.imageURL];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Segment" inManagedObjectContext:managedContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sort]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event.@count >= 4"];
    fetchRequest.predicate = predicate;
    
    [NSFetchedResultsController deleteCacheWithName:@"cache"];
    
    NSFetchedResultsController *theFRController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:managedContext
                                          sectionNameKeyPath:@"name"
                                                   cacheName:@"cache"];
    NSError *err = nil;
    [theFRController performFetch:&err];
    if (err)
    {
        NSLog(@"Error: %@", err.localizedDescription);
        abort();
    }
    [theFRController setDelegate:self];
    
    _fetchedResultsController = theFRController;
    
    return _fetchedResultsController;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath
{
//    return;
    switch (type)
    {
        case NSFetchedResultsChangeDelete:
        case NSFetchedResultsChangeInsert:
        case NSFetchedResultsChangeUpdate:
        {
            [self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];
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

