//
//  main.c
//  HelloC
//
//  Created by Filipe Patrício on 04/05/15.
//  Copyright (c) 2015 Filipe Patrício. All rights reserved.
//

#include <stdio.h>
#include <string.h>

double factorial(int number)
{
    double result = number;
    for(int i = number - 1 ; i > 0; i--)
    {
        result *= i;
    }
    return result;
}

#define ARRAY_SIZE 10


typedef struct
{
    char name[30];
    char surname[30];
} Person;

void writeFullName (Person p)
{
    printf("Fullname: %s %s", p.name, p.surname);
}


int main(int argc, const char * argv[]){
    // insert code here...
    
    //EXERCISE 1
    int number = 20;
    printf("The factorial of %d = %f \n", number, factorial(number));
    
    //EXERCISE 2
    int intArray[ARRAY_SIZE];
    int arraySize = sizeof(intArray)/sizeof(int);
    
    for( int i = 0; i < arraySize; i++)
    {
        intArray[i] = i;
    }
    
    int sumOfArray = 0;
    for(int i = 0; i < arraySize; i++)
    {
        sumOfArray += intArray[i];
    }
    
    printf("Sum of array = %d \n", sumOfArray);
    
    //EXERCISE 3
    Person x;
    
    strcpy(x.name, "DR.X");
    strcpy(x.surname, "XX");
    
    writeFullName(x);
    
    
    
    
    return 0;
}
