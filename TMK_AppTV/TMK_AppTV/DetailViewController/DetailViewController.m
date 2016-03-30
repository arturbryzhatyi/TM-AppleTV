//
//  DetailViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/4/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "DetailViewController.h"
#import "Core.h"
#import "HeaderCell.h"
#import "FlickerCell.h"
#import "YoutubeCell.h"
#import "ITunesCell.h"
#import "QRViewController.h"
#import "PhotoViewController.h"
#import "ITunesViewController.h"
#import "DetailNewsViewController.h"
#import <UIImageView+AFNetworking.h>
#import <XCDYouTubeKit.h>
#import <AVKit/AVKit.h>



typedef NS_ENUM(NSUInteger, DetailEnumCell) {
    
    DetailHeaderCell,
    DetailITunesCell,
    DateilYoutubeCell,
    DetailFlickerCell,
    Detail_COUNT
};


@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UIImageView *backgrounImageView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) Event *currentEvent;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSParameterAssert(self.eventID);
    
    Event *event = nil;
    NSSet *fetchObject = [[Core sharedInstance].databaseManager fetchObjectsForEntityName:@"Event" withPredicate:[NSPredicate predicateWithFormat:@"id == %@", self.eventID]];
    if ([fetchObject count] == 1)
    {
        event = (Event *)[fetchObject anyObject];
        
        self.currentEvent = event;
        
        [self.backgrounImageView setImageWithURL:[event imageURL]];
    }
}

- (UIView *)preferredFocusedView
{
    return self.tableView;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Detail_COUNT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row == DetailHeaderCell)
    {
        return [UIScreen mainScreen].bounds.size.height - [FlickerCell defHeight] - 110;
    }
    else if (indexPath.row == DetailITunesCell)
    {
        if ([[self.currentEvent.segment.name lowercaseString] isEqualToString:@"music"])
        {
            return [ITunesCell defHeight];
        }
        return 0;
    }
    else if (indexPath.row == DetailFlickerCell)
    {
        return [FlickerCell defHeight];
    }
    else if (indexPath.row == DateilYoutubeCell)
    {
        return [YoutubeCell defHeight];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    UITableViewCell *cell = nil;
    
    switch (indexPath.row)
    {
        case DetailHeaderCell:
        {
            identifier = @"headerCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [(HeaderCell *)cell setEventWithID:self.eventID];
        }
            break;
        case DetailFlickerCell:
        {
            identifier = @"flickerCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [(FlickerCell *)cell setEventWithID:self.eventID];
        }
            break;
        case DetailITunesCell:
        {
            identifier = @"itunesCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [(ITunesCell *)cell setITunesTerm:self.currentEvent.name];
        }
            break;
        case DateilYoutubeCell:
        {
            identifier = @"youtubeCell";
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            [(YoutubeCell *)cell setParentViewController:self];
            [(YoutubeCell *)cell setKeyword:self.currentEvent.name];
        }
            break;
        default:
            abort();
            break;
    }
    
    return cell;
}

- (IBAction)playLiveVideo:(UIButton *)sender
{
    [sender setEnabled:NO];
    
    NSString *videoID = [CoreDataManager concertIDWithTerm:@"rihanna"];//[CoreDataManager concertIDRandom];
    
    [[XCDYouTubeClient defaultClient] getVideoWithIdentifier:videoID completionHandler:^(XCDYouTubeVideo *video, NSError *error) {
        
        if (video)
        {
            AVPlayerViewController *playerViewController = [AVPlayerViewController new];
            [self presentViewController:playerViewController animated:YES completion:nil];
            
            NSDictionary *streamURLs = video.streamURLs;
            NSURL *streamURL = streamURLs[@(XCDYouTubeVideoQualityHD720)] ?: streamURLs[@(XCDYouTubeVideoQualityMedium360)];
            
            playerViewController.player = [AVPlayer playerWithURL:streamURL];
            [playerViewController.player play];
        }
        
        [sender setEnabled:YES];
    }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showQR"])
    {
        QRViewController *controlelr = [segue destinationViewController];
        [controlelr setTitle:self.currentEvent.name];
        [controlelr setEventURL:[self.currentEvent.eventURL copy]];
    }
    else if ([segue.identifier isEqualToString:@"showPhoto"])
    {
        ContentViewCell *cell = sender;
        
        PhotoViewController *controlelr = [segue destinationViewController];
        [controlelr setImage:cell.imageView.image];
    }
    else if ([segue.identifier isEqualToString:@"playAudio"])
    {
        ContentViewCell *cell = sender;
        ITunesViewController *controller = segue.destinationViewController;
        
        NSDictionary *userInfo = @{@"title": cell.textLabel.text,
                                   @"image": cell.imageView.image,
                                   @"url": cell.eventID};
        
        [controller setUserInfo:userInfo];
    }
    else if ([segue.identifier isEqualToString:@"showWeb"])
    {
        DetailNewsViewController *controller = segue.destinationViewController;
        [controller setStringURL:self.currentEvent.eventURL];
    }
}


@end
