//
//  FeedViewController.m
//  SuddenMug
//
//  Created by Andrew Webb on 2/3/14.
//  Copyright (c) 2014 Andrew Webb. All rights reserved.
//

#import "FeedViewController.h"
#import "PhotoViewCell.h"

@interface FeedViewController ()
{
    
}
@end

@implementation FeedViewController

- (void)viewDidLoad
{
   // self.usersToDisplay = @[[PFUser currentUser]];

    self.parseClassName = @"Photo";
    [super viewDidLoad];
    
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.masksToBounds = YES;
}

- (void)setUsersToDisplay:(NSArray *)usersToDisplay {
    _usersToDisplay = usersToDisplay;

    if (self.isViewLoaded)
    {
        [self loadObjects];
    }
}


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }

    [query whereKey:@"user" containedIn:self.usersToDisplay];
    [query addDescendingOrder:@"createdAt"];
    return query;
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    PhotoViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCellReuseID"];
    if(!cell)
    {
        cell = [[PhotoViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ImageCellReuseID"];
    }

    cell.imageView.file = object[@"image"];
    [cell.imageView loadInBackground];
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    NSString* uploaded = [formatter stringFromDate:object.createdAt];
 
    cell.textLabel.text = [NSString stringWithFormat:@"Taken By %@ ",object[@"username"]];
    
    cell.detailTextLabel.text = uploaded;
    
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width;
}
@end
