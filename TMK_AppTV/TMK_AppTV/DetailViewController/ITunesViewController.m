//
//  ITunesViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "ITunesViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ITunesViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) AVAudioPlayer *player;
@end

@implementation ITunesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.titleLabel setText:self.userInfo[@"title"]];
    [self.imageView setImage:self.userInfo[@"image"]];
    
    [self createAndStartAudioPlayer];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player stop];
}

- (void) createAndStartAudioPlayer
{
    NSURL *soundFileURL = [NSURL URLWithString:self.userInfo[@"url"]];
    
    __block NSData *data = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        data = [NSData dataWithContentsOfURL:soundFileURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
    
            NSError *err = nil;
            self.player = [[AVAudioPlayer alloc] initWithData:data error:&err];//ContentsOfURL:soundFileURL error:&err];
            self.player.numberOfLoops = 0;
            [self.player setDelegate:self];
            
            [self.player play];
        });
    });
}
#pragma mark - Audio player delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
