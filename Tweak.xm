#import <Cephei/HBPreferences.h>
#import "counted.h"

#define kSettingsChangedNotification (CFStringRef)@"me.daveapps.countedprefs.settingsChanged"

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

-(void)didMoveToWindow {
	
	%orig;
	[self applyCountdown];
}

-(void)layoutSubviews {
	%orig;
	SBUILegibilityLabel *label = MSHookIvar<SBUILegibilityLabel *>(self, "_label");
	//set label color
	_UILegibilitySettings *settings = label.legibilitySettings;
	countDownLabel.textColor = settings.primaryColor;
}



-(void)setDate:(NSDate *)arg1 {
	%orig;

	if (alwaysShowCountdown) {
		SBUILegibilityLabel *label = MSHookIvar<SBUILegibilityLabel *>(self, "_label");
		[label setString: @"                                            "];
		self.frame = frame;
	} else {
		activated = false;
		[countDownLabel removeFromSuperview];
	}
}
-(void)_setDate:(NSDate *)arg1 inTimeZone:(id)arg2{
		%orig;

	if (!alwaysShowCountdown) {
		activated = false;
		[countDownLabel removeFromSuperview];
	} else {
		self.frame = frame;
		SBUILegibilityLabel *label = MSHookIvar<SBUILegibilityLabel *>(self, "_label");
		[label setString: @"                                                   "];
		self.frame = frame;
	}
}
-(id)date {
	if (!alwaysShowCountdown) {
		activated = false;
		countDownLabel.text = @"                                            ";
		return %orig;
	} else {
		self.frame = frame;
		return nil;
	}
}
%new
-(void)closeCountdown {
	if (!alwaysShowCountdown) {
		[self setDate:self.date];
		self.frame = oldFrame;
		activated = false;
	}

}
%new
-(void)openCountdown {
	//set it
	if (enabled) {
		[self applyCountdown];
	}
}

%new 
-(void)applyCountdown {
	enabled = [([file objectForKey:@"kEnabled"] ?: @(true)) boolValue];
	SBUILegibilityLabel *label = MSHookIvar<SBUILegibilityLabel *>(self, "_label");
	retrieveDateStuff *getter = [[retrieveDateStuff alloc] init];

		NSString* dateString = [getter getDateString];

		frame = self.frame;
		oldFrame = self.frame;
		frame.size.width = 300;

		countDownLabel = [[UILabel alloc] initWithFrame:frame];
		countDownLabel.text = dateString;
		countDownLabel.textAlignment = alignment;
		[self addSubview: countDownLabel];


		countDownLabel.translatesAutoresizingMaskIntoConstraints = false;
    	[countDownLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
   		[countDownLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:0].active = YES;
		[label setString: @"    "];

		//set label color
		_UILegibilitySettings *settings = label.legibilitySettings;
		countDownLabel.textColor = settings.primaryColor;

		//font weight
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

%end


%hook CSTeachableMomentsContainerView
-(void)_layoutCallToActionLabel{

	bool replaceHint = [([file objectForKey:@"kReplaceHint"] ?: @(true)) boolValue];
	if (replaceHint) {
		retrieveDateStuff *getter = [[retrieveDateStuff alloc] init];
		NSString* dateString = [getter getDateString];
		[self.callToActionLabel setString: dateString];
	}
	%orig;
}
%end

%hook SBUICallToActionLabel
-(void)layoutSubviews {
	bool replaceHint = [([file objectForKey:@"kReplaceHint"] ?: @(true)) boolValue];
	if (replaceHint) {
		retrieveDateStuff *getter = [[retrieveDateStuff alloc] init];
		NSString* dateString = [getter getDateString];
		self.text = dateString;
	}
	%orig;
}
%end

static void reloadPrefs() {
		retrieveDateStuff *getter = [[retrieveDateStuff alloc] init];
		NSString* dateString = [getter getDateString];
		countDownLabel.text = dateString;

		//font weight
		if (font == 0) {
			countDownLabel.font = [UIFont systemFontOfSize: 21];
		} else if (font == 1) {
			countDownLabel.font = [UIFont systemFontOfSize: 21 weight: UIFontWeightSemibold];
		} else if (font == 2) {
			countDownLabel.font = [UIFont systemFontOfSize: 21 weight: UIFontWeightBold];
		} else if (font == 3) {
			countDownLabel.font = [UIFont systemFontOfSize: 21 weight: UIFontWeightHeavy];
		}

		countDownLabel.textAlignment = alignment;
}

%ctor {
	addedView = false;
	activated = false;
	alwaysShowCountdown = true;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:2021];
    [dateComponents setMonth:10];
    [dateComponents setDay:30];


    NSCalendar *calendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    myDate= [calendar dateFromComponents:dateComponents];
	file = [[HBPreferences alloc] initWithIdentifier:@"me.daveapps.countedprefs"];

	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)reloadPrefs, kSettingsChangedNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

}