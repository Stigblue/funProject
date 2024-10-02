//
//  Employee+CoreDataProperties.m
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//
//

#import "Employee+CoreDataProperties.h"

@implementation Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
}

@dynamic check_in_date_time;
@dynamic company;

@end
