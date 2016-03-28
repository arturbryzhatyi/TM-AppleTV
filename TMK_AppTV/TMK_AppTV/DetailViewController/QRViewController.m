//
//  QRViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/25/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "QRViewController.h"

@interface QRViewController ()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *qrImagView;
@end

@implementation QRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.titleLabel setText:self.title];
}

- (void)setEventURL:(NSString *)value
{
    if (![_eventURL isEqualToString:value])
    {
        _eventURL = value;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            NSString *str = [NSString stringWithFormat:@"https://api.qrserver.com/v1/create-qr-code/?data=%@&size=200x200", _eventURL];
            
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
