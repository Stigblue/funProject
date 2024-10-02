//
//  ViewController.m
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

#import "MainViewController.h"
//#import "Funproject-Swift.h"

@interface MainViewController ()
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *welcomeLabel;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up the view
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Welcome Label (Bonus: Show company name)
    self.welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 40)];
    self.welcomeLabel.text = @"Welcome to [Company Name]";
    self.welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.welcomeLabel];

    // Start Button
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startButton.frame = CGRectMake(100, 200, 200, 50);
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
}

- (void)startButtonTapped {
// NOTE: COMMENT THIS IN
//    // Navigate to the SwiftUI screen
//    DateTimeViewController *dateTimeVC = [[DateTimeViewController alloc] init];
//    [self.navigationController pushViewController:dateTimeVC animated:YES];
}


@end
