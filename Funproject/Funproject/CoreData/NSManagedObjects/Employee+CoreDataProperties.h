//
//  Employee+CoreDataProperties.h
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//
//

#import "Employee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

+ (NSFetchRequest<Employee *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *check_in_date_time;
@property (nullable, nonatomic, retain) Company *company;

@end

NS_ASSUME_NONNULL_END
