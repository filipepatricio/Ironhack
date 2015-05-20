//
//  ViewController.m
//  TestPerson
//
//  Created by Filipe Patrício on 04/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#import "PersonViewController.h"
#import "Person.h"
#import "Employee.h"
#import "PersonFactory.h"
#import "NSDictionary+CreatePerson.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    Person *p = [[Person alloc] initWithName:@"Filipe"
//                                  andSurname:@"Patricio"
//                                       andID:@"ASDASS123123"];
    
    Person *p = [PersonFactory createPersonWithName:@"Filipe" surname:@"Patricio" idNumber:@"ASDAS"];
//    Employee *employee = [PersonFactory createEmployeeWithName:@"emp1" surname:@"sur1" idNumber:@"PERSONID" employeeId:@"EMPLOYEE_ID_ADSADASDAS"];
    
    
//    NSLog(@"Description ID: %@", [PersonFactory interestingIdForPersonOrEmployee:employee]);
//    
//    NSLog(@"responds?: %d",[employee respondsToSelector: @selector(printEmployeeDescription)]);
    
//    p.delegate = self;
    
//    [p printDescription];
//    [Person changeToUpperCase:p];
//    [p printDescription];
    
    Employee *e = [[Employee alloc]initWithName:@"emp1"
                                     andSurname:@"sur1"
                                          andID:@"000"
                                  andEmployeeID:@"111"];
    
//    [e printDescription];
    
    NSMutableArray *personsArray = [[NSMutableArray alloc] init]; // OF Persons
    
    Person *carlos = [[Person alloc]initWithName:@"Carlos"];
    
    [personsArray addObject:[[Person alloc]initWithName:@"Javier"]];
    [personsArray addObject:[[Person alloc]initWithName:@"Sergio"]];
    [personsArray addObject:[[Person alloc]initWithName:@"Filipe"]];
    [personsArray addObject:carlos];

//    [self printPersonsFromArray:personsArray];
    
    [personsArray removeObject:carlos];
    
//    [self printPersonsFromArray:personsArray];
    
    
    NSArray *mixedArray = @[@1, e, @"blabla", p, carlos];
    NSMutableArray *anotherPersonsArray = [self arrayToPersonsArray:mixedArray];
    
//    [self printPersonsFromArray:anotherPersonsArray];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"resources" ofType:@"plist"]];
    
    [self convertToPersonFromDictionary:dictionary];
    
    Person *dictPerson = [dictionary convertToPerson];
    [dictPerson printDescription];
    
    
    NSMutableArray *peopleDictionaryArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"People" ofType:@"plist"]]; //OF NSDictionary
    
    NSMutableArray *peopleArray = [[NSMutableArray alloc]init];
    
    for(NSDictionary *dict in peopleDictionaryArray)
    {
        [peopleArray addObject:[dict convertToPerson]];
        //[(Person*)[peopleArray lastObject] printDescription];
    }
    
}

-(void)printPersonsFromArray:(NSMutableArray *)array
{
    for(Person *person in array)
        NSLog(@"\nPerson: %@", person.name);
}

-(NSMutableArray*)arrayToPersonsArray:(NSArray*)array
{
    NSMutableArray *personsArray = [[NSMutableArray alloc]init];
    for(id obj in array)
        if([obj isKindOfClass:[Person class]])
            [personsArray addObject:obj];
    
    
    return personsArray;
}

-(Person *)convertToPersonFromDictionary:(NSDictionary*)d
{
    return [[Person alloc]initWithName:d[@"name"] andSurname:d[@"surname"] andID:d[@"id"]];
}

#pragma mark - ChangeNameDelegate protocol

-(void)didChangeName:(NSString *)newName
{
    NSLog(@"Did change name: %@", newName);
}

@end
