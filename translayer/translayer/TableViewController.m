//
//  TableViewController.m
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController
@synthesize tableView,theQuad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
   tableView=[[UITableView alloc] initWithFrame:CGRectMake(100, 100, 600, 500) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [tableView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5]];
    
  [self.view addSubview:tableView];
    [self backButton];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setAlpha:0.5];
	// Do any additional setup after loading the view.
}
-(void)loadnewQuad:(Quad *)result{
    theQuad=result;
    [theQuad sortEventsbyDate];
    [self setTitle:[theQuad LocationName]];
    
    [tableView reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  if([[theQuad events] count]==0)
      [self.tableView setHidden:true];
    else
         [self.tableView setHidden:false];
    [self.tableView setFrame:CGRectMake(100, 100, 600, 45*[[theQuad events] count]) ];
    return [[theQuad events] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] ;
    }
    NSString *title=[[[theQuad events] objectAtIndex:indexPath.row] name] ;
    if(title.length>25)
        title=[title substringToIndex:25];
    title=[title stringByAppendingString:@"   -   "];
    cell.textLabel.text=[title stringByAppendingString:[[[theQuad events] objectAtIndex:indexPath.row] _startDate]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *newView=[[DetailViewController alloc] init];
    [newView setEvent:[[theQuad events] objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:newView animated:YES];
    
}
-(void)removeView:(id)sender
{
    [self.navigationController.view removeFromSuperview];
    
}
-(void)backButton
{
    UIBarButtonItem *HomeButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Home"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(removeView:)];
    self.navigationItem.rightBarButtonItem=HomeButton;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
