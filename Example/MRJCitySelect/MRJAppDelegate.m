//
//  MRJAppDelegate.m
//  MRJCitySelect
//
//  Created by mrjlovetian@gmail.com on 03/02/2018.
//  Copyright (c) 2018 mrjlovetian@gmail.com. All rights reserved.
//

#import "MRJAppDelegate.h"

@implementation MRJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    /// block内部引用外部变量，并且block被赋值，这属于NSMallocBlock
    int a = 0;
    void (^blocka)(void) = ^{
        NSLog(@"-=-=-=-=%d", a);
    };
    blocka();
    
    /// 没有引用外部变量，但是有赋值=符号，这属于NSGlobalBlock
    void (^blockb)(void) = ^{
        
    };
    
    /// 没有引用外部变量， 这属于NSGlobalBlock
    NSLog(@"=-=-=-=-=-%@", ^(){
        
    });
    
    /// 引用外部变量， 这属于NSStackBlock
    NSLog(@"=-=-=-=-=-%@", ^(){
        NSLog(@"%d", a);
    });
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
