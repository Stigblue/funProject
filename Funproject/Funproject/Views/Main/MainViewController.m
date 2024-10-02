//
//  MainViewController.m
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

#import "MainViewController.h"
#import "Funproject-Swift.h" // Make sure this is correct and matches your module name

@interface MainViewController ()
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *welcomeLabel;
@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"MainViewController initialized");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Debug log to ensure viewDidLoad is called
    NSLog(@"MainViewController loaded");
    
    
    
    // Set up the view
    self.view.backgroundColor = [UIColor whiteColor];  // Make sure this is visible
    
    // Welcome Label (Bonus: Show company name)
    self.welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 40)];
    self.welcomeLabel.text = @"Welcome to [Company Name]";
    self.welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel.backgroundColor = [UIColor yellowColor]; // Set background color for debugging
    [self.view addSubview:self.welcomeLabel];

    // Start Button
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startButton.frame = CGRectMake(100, 200, 200, 50);
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    self.startButton.backgroundColor = [UIColor greenColor]; // Set background color for debugging
    [self.startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    
    NSLog(@"Welcome Label Frame: %@", NSStringFromCGRect(self.welcomeLabel.frame));
    NSLog(@"Start Button Frame: %@", NSStringFromCGRect(self.startButton.frame));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchAndDisplayCompanyName];
}


- (void)startButtonTapped {
    // Debug log
    NSLog(@"Start button tapped");
    
    // Navigate to the SwiftUI screen
    DateTimePickerViewController *dateTimeVC = [[DateTimePickerViewController alloc] init];
    [self.navigationController pushViewController:dateTimeVC animated:YES];
}

- (void)fetchAndDisplayCompanyName {
    
    NSLog(@"Fetching to Display Company Name");
    NSString *companyName = [[CoreDataManager shared] fetchCompanyName];
    
    if (companyName != nil) {
        self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome to %@", companyName];
    } else {
        self.welcomeLabel.text = @"Welcome to our app";
    }
}

@end
