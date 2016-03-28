//
//  YoutubeCell.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/22/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "YoutubeCell.h"
#import "UIView+Constraint.h"
#import <AVKit/AVKit.h>
#import <XCDYouTubeKit.h>
#import "ParserManager.h"


#define kYoutubeAliKey @"AIzaSyA8Ar4X7hboaIxuOhzYeoygLp8DLeTw9iI"

@interface TableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *objects;
@end

@interface YoutubeCell ()
@property (nonatomic, strong) UIImageView *playImageView;
@property (nonnull, strong) NSString *keyWord;
@end

@implementation YoutubeCell

+ (CGFloat)defHeight
{
    return 300;
}

- (void)setKeyword:(NSString *)value
{
    NSParameterAssert(value);
    
    _keyWord = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSString *stringURL = @"https://www.googleapis.com/youtube/v3/search?part=snippet&q=%@&key=%@";
        stringURL = [NSString stringWithFormat:stringURL, _keyWord, kYoutubeAliKey];
        NSURL *url = [NSURL URLWithString:stringURL];
        
        NSError *err = nil;
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMapped error:&err];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        
        if (dict)
        {
            NSArray *a = [dict valueForKey:@"items"];
            for (NSDictionary *d in a)
            {
                id value = [d valueForKeyPath:@"id.videoId"];
            
                [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:value completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
                    
                    if (video)
                    {
                        [self addNewVideo:video];
                    }
                }];
            }
        }
        else
        {
            NSLog(@"No data from Youtube");
        }
    });
}

- (void)addNewVideo:(XCDYouTubeVideo *)video
{
    NSParameterAssert(video);
    
    @synchronized (self.objects)
    {
        NSMutableArray *mArray = [self.objects mutableCopy];
        [mArray addObject:video];
        self.objects = [NSArray arrayWithArray:mArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.collectionView reloadData];
        });
    }
}

- (void)configureCell:(ContentViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
    XCDYouTubeVideo *item = self.objects[indexPath.row];
    
    NSURL *thumbURL = item.largeThumbnailURL;
    
    if (thumbURL.absoluteString.length == 0)
        thumbURL = item.mediumThumbnailURL;
    
    if (thumbURL.absoluteString.length == 0)
        thumbURL = item.smallThumbnailURL;
    
    
    if (thumbURL)
        [cell.imageView setImageWithURL:thumbURL];
    else
        NSLog(@"No thumb URL");

    [cell.textLabel setText:item.title];
    
    self.playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play-video"]];
    [cell.contentView addSubview:self.playImageView];
    [self.playImageView addConstraintWidth:70 height:70];
    [self.playImageView addConstraintCenteringXY];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.parentViewController isKindOfClass:[UIViewController class]])
    {
        XCDYouTubeVideo *video = self.objects[indexPath.row];
        AVPlayerViewController *playerViewController = [AVPlayerViewController new];
        [self.parentViewController presentViewController:playerViewController animated:YES completion:nil];

        NSDictionary *streamURLs = video.streamURLs;
        NSURL *streamURL = streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?:
                            streamURLs[@(XCDYouTubeVideoQualityHD720)] ?:
                            streamURLs[@(XCDYouTubeVideoQualityMedium360)] ?:
                            streamURLs[@(XCDYouTubeVideoQualitySmall240)];
        
        playerViewController.player = [AVPlayer playerWithURL:streamURL];
        [playerViewController.player play];
    }
}

- (void)playVideoWithID:(NSString *)videoID
{
    NSParameterAssert(videoID);
    
    
    
//    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:videoID];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayerPlaybackDidFinish:)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:videoPlayerViewController.moviePlayer];
//    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
}

- (void)moviePlayerPlaybackDidFinish:(NSNotification *)notification
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:notification.object];
//    MPMovieFinishReason finishReason = [notification.userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
//    if (finishReason == MPMovieFinishReasonPlaybackError)
//    {
//        NSError *error = notification.userInfo[XCDMoviePlayerPlaybackDidFinishErrorUserInfoKey];
//        // Handle error
//    }
}

@end



