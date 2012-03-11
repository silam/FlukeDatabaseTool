//
//  FirstViewController.h
//  FlukeDatabaseTool
//
//  Created by Si Lam on 2/23/12.
//  Copyright (c) 2012 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "libpq-fe.h"
#import "SecondViewController.h"


@interface FirstViewController : UIViewController
{
    const char *conninfo;
    PGconn     *conn;
    PGresult   *res;
    //SecondViewController    *secondViewController;
    
}

@property (retain, nonatomic) IBOutlet UITextField *textFieldEngineId;
@property (retain, nonatomic) IBOutlet UITextField *textFieldEngineSn;
@property (retain, nonatomic) IBOutlet UITextField *textFieldCameraSn;
@property (retain, nonatomic) IBOutlet UITextField *textFieldModel;
@property (retain, nonatomic) IBOutlet UITextField *textFieldDate;

@property (retain, nonatomic) IBOutlet UITextField *textFieldConfigId;

- (IBAction)actionSearchEngine:(id)sender;
- (IBAction)actionClearRecord:(id)sender;


//@property (nonatomic, retain) SecondViewController *secondViewController;
@property (retain, nonatomic) IBOutlet UITextField *textFieldDBServer;
@property (retain, nonatomic) IBOutlet UITextField *textFieldUserId;
@property (retain, nonatomic) IBOutlet UITextField *textFieldPwd;
@property (retain, nonatomic) IBOutlet UITextField *textFieldDBName;
@property (retain, nonatomic) IBOutlet UITextView *textFieldStatus;
@property (retain, nonatomic) IBOutlet UISwitch *switchOn;



- (IBAction)actionSwitchOn:(id)sender;

@end
