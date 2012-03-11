//
//  SecondViewController.h
//  FlukeDatabaseTool
//
//  Created by Si Lam on 2/23/12.
//  Copyright (c) 2012 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#include "libpq-fe.h"

@interface SecondViewController : UIViewController
{
    const char *conninfo;
    PGconn     *conn;
    PGresult   *res;
    
}

//@property (nonatomic, retain) PGconn *conn;


- (IBAction)ActionSearch:(id)sender;

@end
