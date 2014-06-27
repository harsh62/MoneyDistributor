//
//  MDHomeViewController.h
//  moneyDistributor
//
//  Created by SoanSaini on 27/06/14.
//  Copyright (c) 2014 Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDHomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSInteger numberOfPersons;
}
@property (weak, nonatomic) IBOutlet UITextField *numberOfPersonsText;
@property (weak, nonatomic) IBOutlet UITableView *personValueTable;
@property (weak, nonatomic) IBOutlet UILabel *totalValueLabel;
@end
