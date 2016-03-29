//
//  PhotoViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureController];
}

- (void)configureController
{
    [self.imageView setImage:self.image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
