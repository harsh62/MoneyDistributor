//
//  MDHomeViewController.m
//  moneyDistributor
//
//  Created by SoanSaini on 27/06/14.
//  Copyright (c) 2014 Saini. All rights reserved.
//

#import "MDHomeViewController.h"
#import "MDPersonsCustomTableViewCell.h"
#import "MDPersonValue.h"
#import "MDCalculateMoneyDue.h"


@interface MDHomeViewController ()

@end

@implementation MDHomeViewController

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
    
    [MDCalculateMoneyDue sharedInstance].moneyTotalSpent = [NSNumber numberWithFloat:0.0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnScreen)];
    [self.view addGestureRecognizer:tapGesture];
    
    numberOfPersons = 0;
    [self updateTableData];
}

- (void)keyBoardWillShow:(NSNotification *)notification{
    [self.personValueTable setFrame:CGRectMake(0,156,320,190)];
}
- (void)keyBoardWillHide:(NSNotification *)notification{
    [self.personValueTable setFrame:CGRectMake(0,156,320,374)];
}


- (void) updateTableData{
    [MDCalculateMoneyDue sharedInstance].personValueArray = [[NSMutableArray alloc] init];
    
    for(int i =0; i<numberOfPersons; i++){
        MDPersonValue *obj = [[MDPersonValue alloc] init];
        obj.personName = [NSString stringWithFormat:@"Name%d",i];
        
        [[MDCalculateMoneyDue sharedInstance].personValueArray addObject:obj];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[MDCalculateMoneyDue sharedInstance].personValueArray count];
}

- (void)tapOnScreen{
    [self.view endEditing:YES];
    [self.numberOfPersonsText resignFirstResponder];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MDPersonsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonValueCellIdentifier"];
    if(cell){
        [cell.personsNameText resignFirstResponder];
        [cell.personValueSpent resignFirstResponder];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MDPersonsCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonValueCellIdentifier"];
    if(!cell)
    {
        cell = [[MDPersonsCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonValueCellIdentifier"];
    }
    
    MDPersonValue *obj = (MDPersonValue *)[[MDCalculateMoneyDue sharedInstance].personValueArray objectAtIndex:indexPath.row];
    [cell.personsNameText setText:obj.personName];
    [cell.personValueSpent setText:obj.personValueSpent];
    
    [cell.personsNameText setDelegate:self];
    [cell.personValueSpent setDelegate:self];
    
    return cell;
    
}

- (IBAction)updateNumberOfCellsWithPersons:(id)sender {
    [MDCalculateMoneyDue sharedInstance].moneyTotalSpent = [NSNumber numberWithFloat:0.0];
    [self.totalValueLabel setText:[NSString stringWithFormat:@"%.02f",[[MDCalculateMoneyDue sharedInstance].moneyTotalSpent floatValue]]];
    
    [self.numberOfPersonsText resignFirstResponder];
    numberOfPersons = self.numberOfPersonsText.text.intValue;
    [self updateTableData];
    [self.personValueTable reloadData];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag == 200){
    [MDCalculateMoneyDue sharedInstance].moneyTotalSpent = [NSNumber numberWithFloat:[[MDCalculateMoneyDue sharedInstance].moneyTotalSpent floatValue] - textField.text.intValue];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag == 200){
        [MDCalculateMoneyDue sharedInstance].moneyTotalSpent = [NSNumber numberWithFloat:[[MDCalculateMoneyDue sharedInstance].moneyTotalSpent floatValue] + textField.text.intValue];
        [self.totalValueLabel setText:[NSString stringWithFormat:@"%.02f",[[MDCalculateMoneyDue sharedInstance].moneyTotalSpent floatValue]]];
        
        MDPersonsCustomTableViewCell *cell = (MDPersonsCustomTableViewCell *) textField.superview.superview.superview;
        NSIndexPath *indexPath = [self.personValueTable indexPathForCell:cell];
        MDPersonValue *obj = (MDPersonValue *)[[MDCalculateMoneyDue sharedInstance].personValueArray objectAtIndex:indexPath.row];
        obj.personValueSpent = cell.personValueSpent.text;
    }
    else if (textField.tag == 100){
        MDPersonsCustomTableViewCell *cell = (MDPersonsCustomTableViewCell *) textField.superview.superview.superview;
        NSIndexPath *indexPath = [self.personValueTable indexPathForCell:cell];
        MDPersonValue *obj = (MDPersonValue *)[[MDCalculateMoneyDue sharedInstance].personValueArray objectAtIndex:indexPath.row];
        obj.personName = cell.personsNameText.text;
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if(textField.tag == 200){
//        textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
//        totalMoneySpent = totalMoneySpent + textField.text.intValue;
//        [self.totalValueLabel setText:[NSString stringWithFormat:@"%f",totalMoneySpent]];
//        return NO;
//    }
    
    return YES;
}

@end
