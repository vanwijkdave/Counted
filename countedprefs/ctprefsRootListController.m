#include "ctprefsRootListController.h"
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#include <spawn.h>

HBPreferences *file;
UIDatePicker *datePicker;
UITableView *tableViews;
bool pickerActivated;


@implementation ctprefsRootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}


- (instancetype)init {
    self = [super init];

    if (self) {

        HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
        appearanceSettings.tintColor = [UIColor colorWithRed: 0.50 green: 0.81 blue: 0.84 alpha: 1.00];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0];
        self.hb_appearanceSettings = appearanceSettings;
		file = [[HBPreferences alloc] initWithIdentifier:@"me.daveapps.countedprefs"];

    }

    return self;
}



- (void)viewDidLoad {
     [super viewDidLoad];
    pickerActivated = false;
}


- (void)respring:(id)sender {
    pid_t pid;
    int status;
    const char* argv[] = {"sbreload", NULL};
    posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)argv, NULL);
    waitpid(pid, &status, WEXITED);
}

- (void)pickDate {
	datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,250, 325, 300)];
	[datePicker setDatePickerMode:UIDatePickerModeDate];
	[datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];

    if (@available(iOS 13, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            datePicker.backgroundColor = [UIColor blackColor];
        } else {
            datePicker.backgroundColor = [UIColor whiteColor];
        }
    } else {
        datePicker.backgroundColor = [UIColor whiteColor];
    }

	[self.view addSubview: datePicker];



	if ([file objectForKey:@"kDate"] != nil) {
		NSDate *myDate = [file objectForKey:@"kDate"];
		[datePicker setDate:myDate];

	}


	datePicker.translatesAutoresizingMaskIntoConstraints = false;
    [datePicker.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0].active = YES;
    [datePicker.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0].active = YES;
    [datePicker.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0].active = YES;
    [datePicker.heightAnchor constraintEqualToConstant:250].active = YES;

	UIButton *doneButton = [[UIButton alloc] init];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor colorWithRed: 0.50 green: 0.81 blue: 0.84 alpha: 1.00] forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    doneButton.backgroundColor = [UIColor colorWithRed: 0.60 green: 0.90 blue: 0.92 alpha: 0.30];
    doneButton.clipsToBounds = true;
    doneButton.layer.cornerRadius = 8;
	[self.view addSubview: doneButton];

	doneButton.translatesAutoresizingMaskIntoConstraints = false;
    [doneButton.bottomAnchor constraintEqualToAnchor:datePicker.topAnchor constant:-5].active = YES;
    [doneButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-15].active = YES;
    [doneButton.widthAnchor constraintEqualToConstant:70].active = YES;

	[doneButton addTarget:self action:@selector(closePicker) forControlEvents:UIControlEventTouchUpInside];

    pickerActivated = true;
}

- (void)myTwitter {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/DaveWijk"]  options:@{} completionHandler:nil];
}

- (void)myGH {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/vanwijkdave/Counted"]  options:@{} completionHandler:nil];
}

- (void)reportBug {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/vanwijkdave/Counted/issues"]  options:@{} completionHandler:nil];
}



- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker {
    // self.textField.text = [self.dateFormatter stringFromDate:datePicker.date];
	NSDate *chosen = [datePicker date];

	[file setObject:chosen forKey:@"kDate"];

}


-(void)closePicker {
	[datePicker removeFromSuperview];
}

@end
