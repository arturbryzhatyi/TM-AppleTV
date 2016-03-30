//
//  SearchViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/23/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "SearchViewController.h"
#import "ContentViewCell.h"
#import "Event.h"
#import "Core.h"
#import <UIImageView+AFNetworking.h>
#import "UIView+Constraint.h"
#import "DetailViewController.h"

@interface SearchViewController () <UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) NSArray *objects;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textField setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UIView *)preferredFocusedView
{
    return self.textField;
}

- (void)searchWithTerm:(NSString *)term
{
    [[Core sharedInstance] searchKey:term success:^(id object) {
        
        if ([object count] > 0)
        {
            NSLog(@"Search: %@ : count=%lu", term, (unsigned long)[(NSArray *)object count]);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.objects = object;
                [self.collectionView reloadData];
            });
        }
    }];
}

#pragma mark - Text field delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *term = [textField.text stringByAppendingString:string];
    if ([term length] >= 3)
    {
        [self searchWithTerm:term];
    }
    else if ([term length] == 1 && [string length] == 0)
    {
        self.objects = nil;
        [self.collectionView reloadData];
    }
    
    return YES;
}

#pragma mark - Collection View datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.objects count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ContentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    [self configureCell:cell withIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    Event *e = _objects[indexPath.row];
    
    [cell setEventID:e.id];
    [cell.textLabel setText:[e name]];
    [cell.imageView setImageWithURL:e.imageURL];
    
    NSInteger count = arc4random() % 100000 + 23;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [cell.likesLabel setText:[NSString stringWithFormat:@"❤️ %@", [formatter stringFromNumber:[NSNumber numberWithInteger:count]]]];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM/dd/yyyy"];
    [cell.dateLabel setText:[formater stringFromDate:e.localDateTime]];
    
    [cell setSlideImagesURL:e.images];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 5;
    CGFloat height = [UIScreen mainScreen].bounds.size.height / 5;
    return CGSizeMake(width, height);
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if ([segue.identifier isEqualToString:@"searchShowDetail"])
        {
            DetailViewController *controller = segue.destinationViewController;
            
            [controller setEventID:[(ContentViewCell *)sender eventID]];
        }
}

@end
