//
//  MDDuesViewController.h
//  moneyDistributor
//
//  Created by SoanSaini on 27/06/14.
//  Copyright (c) 2014 Saini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDDuesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *dueTable;

@end
