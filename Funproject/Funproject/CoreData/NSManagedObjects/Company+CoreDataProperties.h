//
//  Company+CoreDataProperties.h
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//
//

#import "Company+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Company (CoreDataProperties)

+ (NSFetchRequest<Company *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Employee *employees;

@end

NS_ASSUME_NONNULL_END
