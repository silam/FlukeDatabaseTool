//
//  FirstViewController.m
//  FlukeDatabaseTool
//
//  Created by Si Lam on 2/23/12.
//  Copyright (c) 2012 HOME. All rights reserved.
//

#import "FirstViewController.h"
#include "libpq-fe.h"

@implementation FirstViewController
@synthesize textFieldEngineId;
@synthesize textFieldEngineSn;
@synthesize textFieldCameraSn;
@synthesize textFieldModel;
@synthesize textFieldDate;
@synthesize textFieldConfigId;
@synthesize textFieldDBServer;
@synthesize textFieldUserId;
@synthesize textFieldPwd;
@synthesize textFieldDBName;
@synthesize textFieldStatus;
@synthesize switchOn;
//@synthesize secondViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Database Connection", @"Database Connection");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextFieldDBServer:nil];
    [self setTextFieldUserId:nil];
    [self setTextFieldPwd:nil];
    [self setTextFieldDBName:nil];
    [self setTextFieldStatus:nil];
    [self setSwitchOn:nil];
    [self setTextFieldEngineId:nil];
    [self setTextFieldEngineSn:nil];
    [self setTextFieldCameraSn:nil];
    [self setTextFieldModel:nil];
    [self setTextFieldDate:nil];
    [self setTextFieldConfigId:nil];
    [super viewDidUnload];
    
    [switchOn setOn:YES]; 
    
    
    
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)dealloc {
    [textFieldDBServer release];
    [textFieldUserId release];
    [textFieldPwd release];
    [textFieldDBName release];
    [textFieldStatus release];
    [switchOn release];
    [textFieldEngineId release];
    [textFieldEngineSn release];
    [textFieldCameraSn release];
    [textFieldModel release];
    [textFieldDate release];
    [textFieldConfigId release];
    [super dealloc];
}
- (IBAction)actionSwitchOn:(id)sender {
    
    
    if ( conn == NULL )
    {
        conninfo = "dbname=rmls_prod host=129.196.174.3 port=5432 user=slam password=Cat#4000";        
    
        //conninfo = "dbname=isi_test host=cal.danahertm.//com port=5432 user=slam password=Cat#4000";
        conn = PQconnectdb(conninfo);
        
    
        if (PQstatus(conn) != CONNECTION_OK)
        {
            NSString *title = @"Connection to database failed:";
            NSString *message = [[NSString alloc] initWithUTF8String:PQerrorMessage(conn)];
        
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            textFieldStatus.text =  title;
            [switchOn setOn:NO];      
            [alertView show];
            [alertView release];
            [message release];
        }
        else
        {
            NSString *title = @"Connection to database successful:";
            NSString *message = [[NSString alloc] initWithUTF8String:PQhost(conn)];
        
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            textFieldStatus.text =  title;
            [switchOn setOn:YES];
            
            [alertView show];
            [alertView release];
            [message release];    
        }
    }
    else 
    {
        if (PQstatus(conn) == CONNECTION_OK)
        {
            [switchOn setOn:NO];            
            conn = NULL;
        }
    }

}
- (IBAction)actionSearchEngine:(id)sender {
    
    
    
    
    PGresult *res;
    
    res = PQexec(conn,"BEGIN");
    
     
    
    if (!res || PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        //PQclear(res);
        NSString *title = @"Result is not successful:";
        NSString *message = [[NSString alloc] initWithUTF8String:PQhost(conn)];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];    
        [alertView show];
        [alertView release];
        [message release];     
    }
    else
    {
                
    }
    
    NSString *enginesn = textFieldEngineSn.text;
    
    NSString * querydeclare = [NSString stringWithFormat:@"DECLARE mycursor CURSOR FOR SELECT * FROM romulus.romulus_engines WHERE engine_sn = '%@' and valid_flag = true" ,enginesn ]; 
    
    /*
    NSString *title = @"Alert is successful:";
    //NSString *message = @"test";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title 
                                                        message:querydeclare delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];    
    [alertView show];
    [alertView release];
    //[message release];      
    */
    
    
    const char * query = [querydeclare UTF8String];
    
   
    res = PQexec(conn, query);
    
    if (!res || PQresultStatus(res) != PGRES_COMMAND_OK)
    {
        //PQclear(res);
        NSString *title = @"Result data is not successful:";
        NSString *message = [[NSString alloc] initWithUTF8String:PQerrorMessage(conn)];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];    
        [alertView show];
        [alertView release];
        [message release];     
    }
    else
    {
        
        
    }    
    
    res = PQexec(conn, "FETCH ALL in mycursor");
    
    if (!res || PQresultStatus(res) != PGRES_TUPLES_OK)
    {
        //PQclear(res);
        NSString *title = @"Fetch data is not successful:";
        NSString *message = [[NSString alloc] initWithUTF8String:PQhost(conn)];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];    
        [alertView show];
        [alertView release];
        [message release];     }
    else
    {
        
        
    }     
    
    
    
    int nFields = PQnfields(res);
    
    NSString * engsn = [NSString stringWithFormat:@"%s", PQgetvalue(res, 0,4)];
    NSString * validflag = [NSString stringWithFormat:@"%s", PQgetvalue(res,0, 3)];    
    
    NSString * model = [NSString stringWithFormat:@"%s", PQgetvalue(res,0, 5)];    
    NSString * camsn = [NSString stringWithFormat:@"%s", PQgetvalue(res,0, 18)];
    
    NSString * engid = [NSString stringWithFormat:@"%s", PQgetvalue(res,0, 0)];
    NSString * configid = [NSString stringWithFormat:@"%s", PQgetvalue(res,0, 19)];
    
    textFieldCameraSn.text = camsn;
    textFieldModel.text = model;
    textFieldEngineId.text = engid;
    textFieldConfigId.text = configid;
    
    
    /*
     
    //for ( int i =0; i < nFields; i++)
    //{
        
      //   PQfname(res, i);
    //}
     */
    
    /*
    NSString *title = name;
    NSString *message = [[NSString alloc] initWithUTF8String:PQhost(conn)];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];    
    [alertView show];
    [alertView release];
    [message release];
     */
    res = PQexec(conn,"END");     
}

- (IBAction)actionClearRecord:(id)sender {
}
@end
