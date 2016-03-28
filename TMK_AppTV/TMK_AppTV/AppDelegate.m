//
//  AppDelegate.m
//  TMK_AppTV
//
//  Created by Vitalii Obertynskyi on 3/1/16.
//  Copyright © 2016 Vitalii Obertynskyi. All rights reserved.
//

#import "AppDelegate.h"
#import <FlickrKit.h>
#import "Core.h"

#define kFlickerApiKey @"a2e3789039074383ccca61edbc86313f"
#define kFlickerSecret @"75c0ae39b1aad727"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set app-wide shared cache (first number is megabyte value)
    NSUInteger cacheSizeMemory = 50*1024*1024; // 50 MB
    NSUInteger cacheSizeDisk = 500*1024*1024; // 500 MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory
                                                            diskCapacity:cacheSizeDisk
                                                                diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    // sleep needed for cache ((
    sleep(1);
    
    [[FlickrKit sharedFlickrKit] initializeWithAPIKey:kFlickerApiKey sharedSecret:kFlickerSecret];
    
    
    // load data
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSArray *artist = @[@"kids", @"family", @"adele", @"Red+Hot+Chili+Peppers", @"zz", @"Beyonce", @"Billy+Joe", @"Chris+Brown", @"Coldplay", @"Justin+Bieber", @"Maroon5", @"Rihanna"];
        
        for (NSString *term in artist)
        {
            [[Core sharedInstance] searchKey:term success:^(id object) {

                NSLog(@"Search: %@ : count=%lu", term, (unsigned long)[(NSArray *)object count]);
            }];
        }
    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
