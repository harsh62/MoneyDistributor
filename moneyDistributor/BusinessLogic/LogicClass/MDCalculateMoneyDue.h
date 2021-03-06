//
//  MDCalculateMoneyDue.h
//  moneyDistributor
//
//  Created by SoanSaini on 27/06/14.
//  Copyright (c) 2014 Saini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDPayerPayee.h"

@interface MDCalculateMoneyDue : NSObject
+(MDCalculateMoneyDue*) sharedInstance;

@property (strong, nonatomic) NSMutableArray *personValueArray;

@property (strong, nonatomic) NSMutableArray *personDebtArray;


@property (nonatomic, retain) NSNumber *moneyTotalSpent;
@property (nonatomic, retain) NSNumber *individualValue;
- (void)calculateMoneyDues;
@end
