#import <Cephei/HBPreferences.h>


@interface _UILegibilitySettings
-(UIColor *)primaryColor;
@end

@interface SBUILegibilityLabel : UIView 
-(void)setString:(NSString *)arg1;
@property (assign,nonatomic) long long textAlignment; 
-(_UILegibilitySettings *)legibilitySettings;
@end



@interface SBFLockScreenDateSubtitleView : UIView <UIGestureRecognizerDelegate>
-(NSString *)string;
-(void)_updateForCurrentSizeCategory;
@end

@interface SBFLockScreenDateSubtitleDateView : SBFLockScreenDateSubtitleView 
-(NSDate *)date;
-(void)setDate:(NSDate *)arg1 ;
@end

@interface BSUIScrollView : UIScrollView
@end

@interface SBFLockScreenDateView : UIView
@end
@interface CSCoverSheetViewBase : UIView 
@end

//things
CGRect subFrame;
bool addedView;
UIView *touchView;
HBPreferences *file;
bool activated;
UILabel *countDownLabel;
CGRect oldFrame;



//settings
bool enabled;
int chosenMode;
int alignment;
int font;
NSDate *myDate;

%hook CSCoverSheetViewBase
-(void)layoutSubviews {
	if (!addedView) {
		touchView = [[UIView alloc] initWithFrame: subFrame];
		touchView.userInteractionEnabled = true;
		[self addSubview: touchView];
		addedView = true;

		UITapGestureRecognizer *singleFingerTap = 
		[[UITapGestureRecognizer alloc] initWithTarget:self 
			action:@selector(handleSingleTap:)];
		[touchView addGestureRecognizer:singleFingerTap];
	}

	%orig;
}

%new
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
	//send notif

	if (!activated)  {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"com.counted.showCountdown" object:nil userInfo:nil];
	} else {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"com.counted.closeCountdown" object:nil userInfo:nil];
	}

}
%end

%hook SBFLockScreenDateView 
-(void)layoutSubviews {
	subFrame = self.frame;
	%orig;
}

%end

%hook SBFLockScreenDateSubtitleDateView
-(void)setAccessoryView:(UIView *)arg1 {
	//reconize notif	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openCountdown) name:@"com.counted.showCountdown" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeCountdown) name:@"com.counted.closeCountdown" object:nil];
	%orig;
}

-(void)setDate:(NSDate *)arg1 {
	activated = false;
	[countDownLabel removeFromSuperview];
	%orig;
}
-(void)_setDate:(NSDate *)arg1 inTimeZone:(id)arg2{
	activated = false;
	[countDownLabel removeFromSuperview];
	%orig;
}
-(id)date {
	activated = false;
	countDownLabel.text = @"";
	return %orig;
}
%new
-(void)closeCountdown {
	[self setDate:self.date];
	self.frame = oldFrame;
	
	activated = false;
}
%new
-(void)openCountdown {

	enabled = [([file objectForKey:@"kEnabled"] ?: @(true)) boolValue];

	//get chosen mode
	chosenMode = [([file objectForKey:@"kTextFormat"] ?: @(0)) intValue];

	//get chosen mode
	font = [([file objectForKey:@"kFont"] ?: @(0)) intValue];

	//set alignment
	alignment = [([file objectForKey:@"kAlign"] ?: @(1)) intValue];

	//get subject
	NSString *subjectString = @"[blank]";
	if ([file objectForKey:@"kSubject"] != nil) {
		subjectString = [file objectForKey:@"kSubject"];
	}

	//get alignment


	//set date shit
	SBUILegibilityLabel *label = MSHookIvar<SBUILegibilityLabel *>(self, "_label");
	if ([file objectForKey:@"kDate"] != nil) {
		myDate = [file objectForKey:@"kDate"];
	} else {
		myDate = [NSDate date];                      
	}
	NSDate *startDate = [NSDate date];                      
	NSTimeInterval secondsBetween = [myDate timeIntervalSinceDate:startDate];
	int numberOfDays = secondsBetween / 86400;

	//set it
	if (enabled) {
		NSString *dateString;
		if (chosenMode == 0) {
			dateString = [NSString stringWithFormat:@"Days Till %@: %d", subjectString ,numberOfDays];
		} else if (chosenMode == 1) {
			dateString = [NSString stringWithFormat:@"Days: %d", numberOfDays];
		} else if (chosenMode == 2) {
			dateString = [NSString stringWithFormat:@"%@: %d days", subjectString, numberOfDays];
		} else if (chosenMode == 3) {
			dateString = [NSString stringWithFormat:@"%@: %dd", subjectString, numberOfDays];
		}

		CGRect frame = self.frame;
		oldFrame = self.frame;
		frame.size.width = 300;

		countDownLabel = [[UILabel alloc] initWithFrame:frame];
		countDownLabel.text = dateString;
		countDownLabel.textAlignment = alignment;
		[self addSubview: countDownLabel];


		countDownLabel.translatesAutoresizingMaskIntoConstraints = false;
    	[countDownLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
   		[countDownLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
		[label setString: @""];

		//set label color
		_UILegibilitySettings *settings = label.legibilitySettings;
		countDownLabel.textColor = settings.primaryColor;

		//font
		if (font == 0) {
			countDownLabel.font = [UIFont systemFontOfSize: 21];
		} else if (font == 1) {
			countDownLabel.font = [UIFont systemFontOfSize: 21 weight: UIFontWeightSemibold];
		} else if (font == 2) {
			countDownLabel.font = [UIFont systemFontOfSize: 21 weight: UIFontWeightBold];
		} else if (font == 3) {
			countDownLabel.font = [UIFont systemFontOfSize: 21 weight: UIFontWeightHeavy];
		}

		
		self.frame = frame;


		activated = true;
	}


}

%end


%ctor {
	addedView = false;
	activated = false;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:2021];
    [dateComponents setMonth:10];
    [dateComponents setDay:30];

    NSCalendar *calendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    myDate= [calendar dateFromComponents:dateComponents];
	file = [[HBPreferences alloc] initWithIdentifier:@"me.daveapps.countedprefs"];
	
}