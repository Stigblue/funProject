//
//  ViewController.h
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

#import <UIKit/UIKit.h>
#import "MainViewControllerViewModel.h"

@interface MainViewController : UIViewController
@property (nonatomic, strong, readonly) MainViewControllerViewModel *vm;
- (instancetype)initWithVM:(MainViewControllerViewModel *)vm;

@end

