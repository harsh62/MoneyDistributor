//
//  MDCalculateMoneyDue.m
//  moneyDistributor
//
//  Created by SoanSaini on 27/06/14.
//  Copyright (c) 2014 Saini. All rights reserved.
//

#import "MDCalculateMoneyDue.h"
#import "MDPersonValue.h"

@implementation MDCalculateMoneyDue

static MDCalculateMoneyDue *_sharedInstance = nil;


+(MDCalculateMoneyDue*) sharedInstance
{
    if(!_sharedInstance)
    {
        _sharedInstance = [[self allocWithZone:nil] init];
    }
    return _sharedInstance;
}

- (void)calculateMoneyDues{
//    self.moneyTotalSpent;
//    self.personValueArray;
    
    self.individualValue = [NSNumber numberWithFloat:[self.moneyTotalSpent floatValue] / [self.personValueArray count]];
    NSMutableArray *netDueArray = [[NSMutableArray alloc] init];
    
    self.personDebtArray = [[NSMutableArray alloc] init];
    
    for(int i =0; i< [self.personValueArray count]; i++){
        MDPersonValue *obj = (MDPersonValue *)[self.personValueArray objectAtIndex:i];
        obj.moneyDue =  [NSNumber numberWithFloat:obj.personValueSpent.intValue - [self.individualValue floatValue]];
        [netDueArray addObject:obj.moneyDue];
    }
    
    for(int i = 0; i< [netDueArray count]; i++){
        NSNumber *valueToBeReceived = [netDueArray objectAtIndex:i] ;
        if([valueToBeReceived floatValue] > 0){
            for(int j = 0; j< [netDueArray count]; j++){
                if(i != j)
                {
                    NSNumber *valueToBePaid =[netDueArray objectAtIndex:j];
                    if([valueToBePaid floatValue] < 0){
                        if(fabsf([valueToBePaid floatValue]) < [valueToBeReceived floatValue]){
                            
                            MDPayerPayee *objPayerPayee = [[MDPayerPayee alloc] init];
                            
                            MDPersonValue *objPayee = (MDPersonValue *)[self.personValueArray objectAtIndex:i];
                            MDPersonValue *objPayer = (MDPersonValue *)[self.personValueArray objectAtIndex:j];
                            objPayerPayee.payeeName = objPayee.personName;
                            objPayerPayee.payerName = objPayer.personName;
                            objPayerPayee.amount = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%0.2f",fabsf([valueToBePaid floatValue])] floatValue]] ;
                            [self.personDebtArray addObject:objPayerPayee];
                            
                            NSLog(@"%@ pays %@",objPayer.personName,objPayee.personName);
                            
                            valueToBeReceived = [NSNumber numberWithFloat:[valueToBePaid floatValue] + [valueToBeReceived floatValue]];
                            valueToBePaid = [NSNumber numberWithFloat:0.0];
                            
                            [netDueArray replaceObjectAtIndex:i withObject:valueToBeReceived];
                            [netDueArray replaceObjectAtIndex:j withObject:valueToBePaid];
                            
                        }
                        else if (fabsf([valueToBePaid floatValue]) == [valueToBeReceived floatValue]){
                            
                            MDPayerPayee *objPayerPayee = [[MDPayerPayee alloc] init];
                            
                            MDPersonValue *objPayee = (MDPersonValue *)[self.personValueArray objectAtIndex:i];
                            MDPersonValue *objPayer = (MDPersonValue *)[self.personValueArray objectAtIndex:j];
                            objPayerPayee.payeeName = objPayee.personName;
                            objPayerPayee.payerName = objPayer.personName;
                            objPayerPayee.amount = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%0.2f",fabsf([valueToBePaid floatValue])] floatValue]] ;
                            [self.personDebtArray addObject:objPayerPayee];
                            
                            
                            NSLog(@"%@ pays %@",objPayer.personName,objPayee.personName);
                            
                            valueToBeReceived = [NSNumber numberWithFloat:0.0];
                            valueToBePaid = [NSNumber numberWithFloat:0.0];
                            
                            [netDueArray replaceObjectAtIndex:i withObject:valueToBeReceived];
                            [netDueArray replaceObjectAtIndex:j withObject:valueToBePaid];
                            
                            
                            break;
                        }
                        else{
                            MDPayerPayee *objPayerPayee = [[MDPayerPayee alloc] init];
                            
                            MDPersonValue *objPayee = (MDPersonValue *)[self.personValueArray objectAtIndex:i];
                            MDPersonValue *objPayer = (MDPersonValue *)[self.personValueArray objectAtIndex:j];
                            objPayerPayee.payeeName = objPayee.personName;
                            objPayerPayee.payerName = objPayer.personName;
                            objPayerPayee.amount = [NSNumber numberWithFloat:[[NSString stringWithFormat:@"%0.2f",fabsf([valueToBeReceived floatValue])] floatValue]] ;
                            [self.personDebtArray addObject:objPayerPayee];
                            
                            NSLog(@"%@ pays %@",objPayer.personName,objPayee.personName);
                            
                            valueToBePaid = [NSNumber numberWithFloat:[valueToBePaid floatValue] + [valueToBeReceived floatValue]];
                            valueToBeReceived = [NSNumber numberWithFloat:0.0];
                            
                            
                            [netDueArray replaceObjectAtIndex:i withObject:valueToBeReceived];
                            [netDueArray replaceObjectAtIndex:j withObject:valueToBePaid];
                            
                            break;
                        }
                    }
                }
            }
        }
    }
    
}

@end
