//
//  MainViewControllerViewModel.m
//  Funproject
//
//  Created by Stig von der Ahé on 28/10/2024.
//

#import <Foundation/Foundation.h>
#import "Funproject-Swift.h"
#import "MainViewControllerViewModel.h"

// Note: I know This naming is awful lol. Would defo rename all ViewController files to something else. And then rename these too.
@implementation MainViewControllerViewModel

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    CompanyService *companyService = [[CompanyService alloc] init];
    NSString *companyName = [companyService fetchMostRecentCompanyName];

    if (companyName != nil) {
        _welcomeLabel = [NSString stringWithFormat:@"Last saved Company: %@", companyName];
    } else {
        _welcomeLabel = @"Welcome first timer!";
    }
 
    return self;
}

@end
