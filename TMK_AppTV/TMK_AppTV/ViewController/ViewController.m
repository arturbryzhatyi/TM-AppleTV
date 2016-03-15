//
//  ViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/1/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ViewController.h"
#import "Core.h"
#import "TableViewCell.h"
#import "CarouselView.h"
#import <UIImageView+AFNetworking.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (weak, nonatomic) IBOutlet CarouselView *caruselView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[Core sharedInstance] searchKey:@"fear+the" success:^(id object) {
        
        NSLog(@">>> %@", object);
        
        [self.caruselView setObjects:object];
    }];
    
    NSSet *set = [[Core sharedInstance].databaseManager fetchObjectsForEntityName:@"Event" withPredicate:nil];
    [self.caruselView setObjects:set.allObjects];
    [self setBlur:set.anyObject];
}

- (UIView *)preferredFocusedView
{
    return self.tableView;
}

- (void)setBlur:(Event *)event
{
    if (event)
    {
        [self.blurImageView setImageWithURL:event.imageURL];
    }
}


#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    
    NSInteger count = [sectionInfo numberOfObjects];

    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Segment *item = [self.fetchedResultsController fetchedObjects][section];
    
    return item.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Segment *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell setObjects:item.event.allObjects];
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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller;
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
        {
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type;
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}
@end

