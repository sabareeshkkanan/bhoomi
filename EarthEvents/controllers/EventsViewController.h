//
//  TableViewController.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Landmark.h"

@interface EventsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    Landmark* theQuad;
    bool empty;
}
@property(nonatomic,strong)Landmark *theQuad;
@property(nonatomic,retain)UITableView *tableView;

-(void)loadnewQuad:(Landmark *)result;
@end
