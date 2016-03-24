//
//  YoutubeCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/22/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "YoutubeCell.h"
#import "UIView+Constraint.h"
#import "ItemYoutube.h"

#define kYoutubeAliKey @"AIzaSyA8Ar4X7hboaIxuOhzYeoygLp8DLeTw9iI"

@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@interface YoutubeCell ()
@property (nonatomic, strong) UIImageView *playImageView;
@property (nonnull, strong) NSString *keyword;
@end

@implementation YoutubeCell

+ (CGFloat)defHeight
{
    return 300;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    self.objects = @[@"youtubeCell", @"youtubeCell1", @"youtubeCell2", @"youtubeCell3"];
}

- (void)setKeyword:(NSString *)value
{
    NSParameterAssert(value);
    
    _keyword = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSString *stringURL = @"https://www.googleapis.com/youtube/v3/search?part=snippet&q=%@&key=%@";
        stringURL = [NSString stringWithFormat:stringURL, _keyword, kYoutubeAliKey];
        
        
        NSURL *url = [NSURL URLWithString:stringURL];
        
        NSError *err = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&err];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        if (dict)
        {
//            NSLog(@"URL: %@\nResponse: %@", url, dict);
            
            NSArray *a = [dict valueForKey:@"items"];
            
            NSMutableArray *mArray = [NSMutableArray new];
            for (NSDictionary *d in a)
            {
                ItemYoutube *item = [[ItemYoutube alloc] initWithDictionary:d];
                if (item)
                {
                    [mArray addObject:item];
                }
            }
            
            self.objects = [NSArray arrayWithArray:mArray];
        }
        else
        {
            NSLog(@"No data from Youtube");
            self.objects = @[@"youtubeCell", @"youtubeCell1", @"youtubeCell2", @"youtubeCell3", @"youtubeCell4", @"youtubeCell5", @"youtubeCell6", @"youtubeCell7"];
        }
    });
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    ItemYoutube *item = self.objects[indexPath.row];
    NSURL *url = [NSURL URLWithString:item.videoThumbURL];
    
    if (url)
        [cell.imageView setImageWithURL:url];
    else
        NSLog(@"No thumb URL");

    self.playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play-video"]];
    [cell.contentView addSubview:self.playImageView];
    [self.playImageView addConstraintWidth:70 height:70];
    [self.playImageView addConstraintCenteringXY];
}

@end
