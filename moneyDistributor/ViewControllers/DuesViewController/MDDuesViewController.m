//
//  MDDuesViewController.m
//  moneyDistributor
//
//  Created by SoanSaini on 27/06/14.
//  Copyright (c) 2014 Saini. All rights reserved.
//

#import "MDDuesViewController.h"
#import "MDCalculateMoneyDue.h"

@interface MDDuesViewController ()

@end

@implementation MDDuesViewController

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
    // Do any additional setup after loading the view.
    
    [[MDCalculateMoneyDue sharedInstance] calculateMoneyDues];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[MDCalculateMoneyDue sharedInstance].personDebtArray count];
}



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonValueCellIdentifier"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonValueCellIdentifier"];
    }
    
    NSString *debtString =(NSString *)[[MDCalculateMoneyDue sharedInstance].personDebtArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:debtString];
    
    return cell;
    
}

@end
