//
//  QRViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/25/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "QRViewController.h"
#import "CoreDataManager.h"

@interface QRViewController ()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *qrImagView;
@end

@implementation QRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)configureController
{
    [self.titleLabel setText:self.title];


    if ([CoreDataManager isZZTOP:self.title])
    {
        [self.qrImagView setImage:[UIImage imageNamed:@"qr_zztop"]];
    }
    else if ([CoreDataManager isRIHANNA:self.title])
    {
        [self.qrImagView setImage:[UIImage imageNamed:@"qr_rihanna"]];
    }
    else
    {
        if ([_eventURL length] == 0)
        {
            _eventURL = @"http://ticketmaster.ca/";
        }
        
        self.eventURL = [self.eventURL stringByReplacingOccurrencesOfString:@"://" withString:@"://www."];
        
        NSLog(@"QR URL: %@", _eventURL);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSString *str = [NSString stringWithFormat:@"https://api.qrserver.com/v1/create-qr-code/?data=%@&size=300x300", _eventURL];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
            
            if (data)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIImage *img = [UIImage imageWithData:data];
                    [self.qrImagView setImage:img];
                });
            }
        });
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
