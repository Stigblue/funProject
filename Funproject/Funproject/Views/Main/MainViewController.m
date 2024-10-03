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
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.welcomeLabel = [[UILabel alloc] init];
    self.welcomeLabel.text = @"Welcome to [Company Name]";
    self.welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.welcomeLabel];
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.startButton];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.datePicker];
    
    self.datePicker.userInteractionEnabled = NO; // dont want this to be interacted with. Only for showing the date.
    
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.welcomeLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:40],
        [self.welcomeLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.welcomeLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        [self.welcomeLabel.heightAnchor constraintEqualToConstant:40]
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.startButton.topAnchor constraintEqualToAnchor:self.welcomeLabel.bottomAnchor constant:20],
        [self.startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.datePicker.topAnchor constraintEqualToAnchor:self.startButton.bottomAnchor constant:20],
        [self.datePicker.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // I want the screen to update with the recent values added and not just on app restart, so i will do this in viewWillAppear here.
    [self setDatePickerInitialValue];
    [self fetchAndDisplayCompanyName];
}


- (void)startButtonTapped {
    DateTimePickerViewController *dateTimeVC = [[DateTimePickerViewController alloc] init];
    [self.navigationController pushViewController:dateTimeVC animated:YES];
}

- (void)fetchAndDisplayCompanyName {
    NSString *companyName = [[CoreDataManager shared] fetchCompanyName];
    NSDate *lastCheckInDate = [[CoreDataManager shared] fetchInitialDate];
    
    NSLog(@"Fetched company name: %@", companyName);
    NSLog(@"Fetched last checkin date: %@", lastCheckInDate);
    
    
    NSString *lastCheckInDateString;
    if (lastCheckInDate) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        lastCheckInDateString = [dateFormatter stringFromDate:lastCheckInDate];
    } else {
        lastCheckInDateString = @"No check-in available"; // Fallback text if no date exists
    }

    if (companyName != nil) {
        self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome to %@\nLast Check-In: %@", companyName, lastCheckInDateString];
    } else {
        self.welcomeLabel.text = [NSString stringWithFormat:@"Welcome to our app\nLast Check-In: %@", lastCheckInDateString];
    }
}


- (void)setDatePickerInitialValue {
    NSDate *initialDate = [[CoreDataManager shared] fetchInitialDate];
    [self.datePicker setDate:initialDate animated:YES];
}

@end
