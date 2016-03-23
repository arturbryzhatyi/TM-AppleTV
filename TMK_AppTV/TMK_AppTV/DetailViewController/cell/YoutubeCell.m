//
//  YoutubeCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/22/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "YoutubeCell.h"
#import "UIView+Constraint.h"

@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@interface YoutubeCell ()
@property (nonatomic, strong) UIImageView *playImageView;
@end

@implementation YoutubeCell

+ (CGFloat)defHeight
{
    return 300;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.objects = @[@"youtubeCell", @"youtubeCell1", @"youtubeCell2", @"youtubeCell3"];
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
