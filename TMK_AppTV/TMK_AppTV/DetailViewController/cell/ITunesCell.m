//
//  ITunesCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/22/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ITunesCell.h"
#import "UIView+Constraint.h"

@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@interface ITunesCell ()
@property (nonatomic, strong) UIImageView *playImageView;
@end

@implementation ITunesCell

+ (CGFloat)defHeight
{
    return 300;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSMutableArray *mArray = [@[@"itunesCell", @"itunesCell1", @"itunesCell2", @"itunesCell3", @"itunesCell4", @"itunesCell5", @"itunesCell6", @"itunesCell7"] mutableCopy];
    
    // shuffle array
    NSUInteger arrayCount = [mArray count] - 1;
    for (int i=0; i < arrayCount; i++)
    {
        NSUInteger ind1 = arc4random() % arrayCount;
        NSUInteger ind2 = arc4random() % arrayCount;
        [mArray exchangeObjectAtIndex:ind1 withObjectAtIndex:ind2];
    }
    
    self.objects = [NSArray arrayWithArray:mArray];
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageName = self.objects[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
    
    self.playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play-video"]];
    [cell.contentView addSubview:self.playImageView];
    [self.playImageView addConstraintWidth:70 height:70];
    [self.playImageView addConstraintCenteringXY];
}

@end
