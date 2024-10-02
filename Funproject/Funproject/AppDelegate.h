//
//  AppDelegate.h
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

