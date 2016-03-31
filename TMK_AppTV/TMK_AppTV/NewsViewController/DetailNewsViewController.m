//
//  DetailNewsViewController.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/29/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "DetailNewsViewController.h"

@interface DetailNewsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation DetailNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureController];
    
}

- (UIView *)preferredFocusedView
{
    return self.textView;
}

- (void)configureController
{
    if ([self.stringURL length] > 0)
    {
        NSURL *url = [NSURL URLWithString:self.stringURL];
        
        Class webviewClass = NSClassFromString(@"UIWebView");
        id webview = [[webviewClass alloc] initWithFrame:self.view.frame];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webview loadRequest:request];
        [self.view addSubview:webview];
    }
}

@end
