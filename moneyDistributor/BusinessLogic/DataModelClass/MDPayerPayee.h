//
//  MDPayerPayee.h
//  moneyDistributor
//
//  Created by SoanSaini on 30/06/14.
//  Copyright (c) 2014 Saini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDPayerPayee : NSObject
@property (nonatomic, retain) NSString * payerName;
@property (nonatomic, retain) NSString * payeeName;
@property (retain,nonatomic) NSNumber * amount;
@end
