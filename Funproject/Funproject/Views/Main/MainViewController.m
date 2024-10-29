//
//  MainViewController.m
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

#import "MainViewController.h"
#import "Funproject-Swift.h" 
#import "MainViewControllerViewModel.h"

@interface MainViewController()
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) UILabel *lastSelectedDatePickerLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation MainViewController

- (instancetype)initWithVM:(MainViewControllerViewModel *)vm {
    self = [super init];
    if (self) {
        _vm = vm; 
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.welcomeLabel = [[UILabel alloc] init];
    self.welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.welcomeLabel];
    
    self.lastSelectedDatePickerLabel = [[UILabel alloc] init];
    self.lastSelectedDatePickerLabel.text = @"Last saved date:";
    self.lastSelectedDatePickerLabel.textAlignment = NSTextAlignmentCenter;
    self.lastSelectedDatePickerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.lastSelectedDatePickerLabel];
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.startButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.startButton];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.datePicker];
    
    self.datePicker.userInteractionEnabled = NO; // dont want this to be interacted with. Only for showing the prev selected date.
    
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.welcomeLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:40],
        [self.welcomeLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.welcomeLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.welcomeLabel.heightAnchor constraintEqualToConstant:40]
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [self.lastSelectedDatePickerLabel.topAnchor constraintEqualToAnchor:self.welcomeLabel.bottomAnchor constant:20],
        [self.lastSelectedDatePickerLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.lastSelectedDatePickerLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        [self.lastSelectedDatePickerLabel.heightAnchor constraintEqualToConstant:40]
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [self.datePicker.topAnchor constraintEqualToAnchor:self.lastSelectedDatePickerLabel.bottomAnchor constant:20],
        [self.datePicker.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];
    [NSLayoutConstraint activateConstraints:@[
        [self.startButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.startButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20]
    ]];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // I want the screen to update with the recent values added and not just on app restart, so i will do this in viewWillAppear here.
    [self setDatePickerInitialValue];
    [self updateTextValues];
}


- (void)startButtonTapped {
    DateTimePickerViewController *dateTimeVC = [[DateTimePickerViewController alloc] init];
    [self.navigationController pushViewController:dateTimeVC animated:YES];
}

- (void)updateTextValues {
    self.welcomeLabel.text = self.vm.welcomeLabel;
}

- (void)setDatePickerInitialValue {
    EmployeeService *employeeService = [[EmployeeService alloc] init];
    
    [employeeService fetchMostRecentCheckInDateWithCompletion:^(NSDate *date) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.datePicker setDate:date animated:YES];
            NSLog(@"Fetched check-in date: %@", date);
            self.lastSelectedDatePickerLabel.text = [NSString stringWithFormat:@"Last Check-in:"];
        });
    }];
}




@end
