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

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [[Core sharedInstance] searchKey:@"rihanna" success:^(id object) {
//        
//        NSLog(@"Response: %@", object);
//    }];
}

- (UIView *)preferredFocusedView
{
    return self.collectionView;
}

#pragma mark - Collection view data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(0, 200);
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
    
    
    
    return cell;
}

#pragma mark - Collection view flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(400, 220);
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

@end








