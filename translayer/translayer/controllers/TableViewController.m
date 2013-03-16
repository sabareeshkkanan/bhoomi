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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.navigationController.view addGestureRecognizer:tapGesture];
    [self.navigationController.view setBackgroundColor:[UIColor colorWithRed:0.0 green:0.1 blue:0.2 alpha:0.6]];
    [self backButton];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController.navigationBar setAlpha:0.5];
    
   tableView=[[UITableView alloc] initWithFrame:CGRectMake(100, 150, 600, 500) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    [tableView setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5]];
    [tableView setRowHeight:79.f];
  [self.view addSubview:tableView];
   
	// Do any additional setup after loading the view.
}
-(void)loadnewQuad:(Landmark *)result{
    theQuad=result;
    [theQuad sortEventsbyDate];
    [self setTitle:[theQuad LocationName]];
    [tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rownumber=[[theQuad events] count];
    
    
  if(rownumber==0)
  {empty=TRUE; rownumber=1;}
    else
        empty=FALSE;
   
        [self.tableView setHidden:false];
    [self.tableView setFrame:CGRectMake(100, 150, 600, 79*rownumber) ];
    return rownumber;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier] ;
    }
    
    NSString *title;
    if(empty)
        title=@"There are no events in this landmark";
    else
    {
    title=[[[theQuad events] objectAtIndex:indexPath.row] name] ;
    if(title.length>25)
        title=[title substringToIndex:25];
    title=[title stringByAppendingString:@"   -   "];
    title=[title stringByAppendingFormat:@"%@",[[[theQuad events] objectAtIndex:indexPath.row] dates]];
    }
    cell.textLabel.text=title;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!empty){
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *newView=[[DetailViewController alloc] init];
    [newView setEvent:[[theQuad events] objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:newView animated:YES];
    }
}
-(void)removeView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController.view removeFromSuperview];
     [theQuad buttonlayer:[[UIColor darkGrayColor] CGColor]];
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
- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        [self removeView:self];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
