//
//  TableViewController.h
//  translayer
//
//  Created by sabareesh kkanan subramani on 11/21/12.
//  Copyright (c) 2012 DreamPowers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Quad.h"

@interface TableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
    Quad* theQuad;
 
}
@property(nonatomic,strong)Quad *theQuad;
@property(nonatomic,retain)UITableView *tableView;

-(void)loadnewQuad:(NSArray *)result;
@end
