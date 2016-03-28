//
//  ITunesCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/22/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ITunesCell.h"
#import "UIView+Constraint.h"
#import "ParserManager.h"

#import "TextAnalyzer.h"

@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@interface ITunesCell ()
//@property (nonatomic, strong) UIImageView *playImageView;
@property (nonnull, strong) NSString *term;
@end

@implementation ITunesCell

+ (CGFloat)defHeight
{
    return 300;
}

- (void)setITunesTerm:(NSString *)value
{
    NSParameterAssert(value);
    
//    [TextAnalyzer analyze:value];
    
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
    value = [[value componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@" "];
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *components = [value componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
    
    value = [components componentsJoinedByString:@"+"];
    
    _term = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSString *stringURL = @"https://itunes.apple.com/search?term=%@&media=music&limit=20";
        
        stringURL = [NSString stringWithFormat:stringURL, _term];
        
        NSURL *url = [NSURL URLWithString:stringURL];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if (data)
        {
            NSError *err = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            
            if (dict)
            {
                NSArray *a = dict[@"results"];
                
                if ([a count] == 0)
                {
                    NSLog(@"iTunes count 0");
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        [self setITunesTerm:@"popular music"];
                    });                    
                }
                else
                {
                    NSMutableArray *mArray = [NSMutableArray new];
                    for (NSDictionary *d in a)
                    {
                        ItemITunes *item = [[ItemITunes alloc] initWithDictionary:d];
                        [mArray addObject:item];
                    }
                    
                    self.objects = [NSArray arrayWithArray:mArray];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self.collectionView reloadData];
                    });
                }
            }
        }
    });
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    ItemITunes *item = self.objects[indexPath.row];
    [cell.imageView setImageWithURL:[NSURL URLWithString:item.thumbURL]];
    [cell.textLabel setText:item.title];
    
//    self.playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play-video"]];
//    [cell.contentView addSubview:self.playImageView];
//    [self.playImageView addConstraintWidth:70 height:70];
//    [self.playImageView addConstraintCenteringXY];
}

@end


@implementation ItemITunes

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        id value = dict[@"artistName"];
        IfStringValueNotNull(value)
        {
            _title = value;
        }
        
        value = dict[@"artworkUrl100"];
        IfStringValueNotNull(value)
        {
            _thumbURL = value;
        }
        
        value = dict[@"previewUrl"];
        IfStringValueNotNull(value)
        {
            _previewAudioURL = value;
        }
    }
    return self;
}

@end