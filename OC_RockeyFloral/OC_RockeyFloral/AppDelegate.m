//
//  AppDelegate.m
//  OC_RockeyFloral
//
//  Created by Rockey on 16/6/24.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "NavigationController.h"


#import "HomeViewController.h"
#import "MallsViewController.h"
#import "ProfileViewController.h"

/** URLProtocol */
#import "RURLProtocol.h"
#import <objc/runtime.h>

@interface AppDelegate ()

@end

extern void instrumentObjcMessageSends(BOOL);
void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /** 打印崩溃日志：避免崩溃时候，总是停留在 main  */
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    /** 记录方法调用：Hook函数 */
    instrumentObjcMessageSends(YES); 

    BOOL regist = [NSURLProtocol registerClass:[RURLProtocol class]];
    if (regist) {
        NSLog(@"regist  success");
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"selfAuthor" ofType:@"plist"]];
   [UserInfo sharedInstance].author = [MTLJSONAdapter modelOfClass:[Author class] fromJSONDictionary:dic error:nil];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    MainViewController *main = [[MainViewController alloc] init];
    main.bNetworkReachability = YES;
    _window.rootViewController = main;
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    dispatch_async(dispatch_get_main_queue(), ^{
        UILocalNotification * localNotification = [[UILocalNotification alloc] init];
        if (localNotification) {
            localNotification.fireDate= [[[NSDate alloc] init] dateByAddingTimeInterval:3];
            localNotification.timeZone=[NSTimeZone defaultTimeZone];
            localNotification.alertBody = @"缘起缘灭，慈心不变";
            localNotification.alertAction = @" 升级 ";
            localNotification.soundName = @"";
            [application scheduleLocalNotification:localNotification];
        }
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Rockey.OC_RockeyFloral" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OC_RockeyFloral" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OC_RockeyFloral.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
