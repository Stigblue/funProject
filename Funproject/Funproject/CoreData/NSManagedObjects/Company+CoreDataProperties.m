//
//  Company+CoreDataProperties.m
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//
//

#import "Company+CoreDataProperties.h"

@implementation Company (CoreDataProperties)

+ (NSFetchRequest<Company *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Company"];
}

@dynamic name;
@dynamic employees;

@end
