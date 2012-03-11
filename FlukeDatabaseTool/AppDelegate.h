//
//  AppDelegate.h
//  FlukeDatabaseTool
//
//  Created by Si Lam on 2/23/12.
//  Copyright (c) 2012 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
const char *conninfo;
PGconn     *conn;
PGresult   *res;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UIWindow    *windows;
    UINavigationController  *navigationController;
    FirstViewController     *firstViewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) FirstViewController    *firstViewController;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
