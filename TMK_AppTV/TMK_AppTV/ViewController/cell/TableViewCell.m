//
//  TableViewCell.m
//  TestScrollView
//
//  Created by Vitalii Obertynskyi on 3/15/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)canBecomeFocused
{
    return NO;
}

- (void)setObjects:(NSArray *)value
{
    if ([value count] > 30)
    {
        value = [value subarrayWithRange:NSMakeRange(0, 30)];
    }
    
    _objects = value;
    [self.collectionView reloadData];
}

#pragma mark - Collection view
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_objects count];
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

#pragma mark - Layout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width / 5;
//    CGFloat height = [UIScreen mainScreen].bounds.size.height / 5;
//    return CGSizeMake(width, height);
//}

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
    [cell.contentView updateConstraintsIfNeeded];
    
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
