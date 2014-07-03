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
    
    if(!isnan([[[MDCalculateMoneyDue sharedInstance] individualValue] floatValue]))
    [self.individualContributionLabel setText:[NSString stringWithFormat:@"Individual Contribution: %0.2f Bucks",[[[MDCalculateMoneyDue sharedInstance] individualValue] floatValue]]];
    else{
        [self.individualContributionLabel setText:@"Individual Contribution: 0.00 Bucks"];
    }
    [self.totalMoneyLabel setText:[NSString stringWithFormat:@"Total Money Spent: %0.2f Bucks",[[[MDCalculateMoneyDue sharedInstance] moneyTotalSpent] floatValue]]];
    
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"PersonValueCellIdentifier"];
    }
    MDPayerPayee *ObjPayerPayee =(MDPayerPayee *)[[MDCalculateMoneyDue sharedInstance].personDebtArray objectAtIndex:indexPath.row];
    
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%0.2f Bucks",[ObjPayerPayee.amount floatValue]]];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@ has to pay %@",ObjPayerPayee.payerName, ObjPayerPayee.payeeName]];
    return cell;
    
}

@end
