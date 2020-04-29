#line 1 "Tweak.xm"
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


CGRect subFrame;
bool addedView;
UIView *touchView;
HBPreferences *file;
bool activated;
UILabel *countDownLabel;
CGRect oldFrame;




bool enabled;
int chosenMode;
int alignment;
int font;
NSDate *myDate;


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBFLockScreenDateView; @class CSCoverSheetViewBase; @class SBFLockScreenDateSubtitleDateView; 
static void (*_logos_orig$_ungrouped$CSCoverSheetViewBase$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL CSCoverSheetViewBase* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSCoverSheetViewBase$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSCoverSheetViewBase* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$CSCoverSheetViewBase$handleSingleTap$(_LOGOS_SELF_TYPE_NORMAL CSCoverSheetViewBase* _LOGOS_SELF_CONST, SEL, UITapGestureRecognizer *); static void (*_logos_orig$_ungrouped$SBFLockScreenDateView$layoutSubviews)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$setAccessoryView$)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL, UIView *); static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$setAccessoryView$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL, UIView *); static void (*_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$setDate$)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL, NSDate *); static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$setDate$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL, NSDate *); static void (*_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$_setDate$inTimeZone$)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL, NSDate *, id); static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$_setDate$inTimeZone$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL, NSDate *, id); static id (*_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$date)(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$date(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$closeCountdown(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$openCountdown(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST, SEL); 

#line 52 "Tweak.xm"

static void _logos_method$_ungrouped$CSCoverSheetViewBase$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL CSCoverSheetViewBase* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
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

	_logos_orig$_ungrouped$CSCoverSheetViewBase$layoutSubviews(self, _cmd);
}


static void _logos_method$_ungrouped$CSCoverSheetViewBase$handleSingleTap$(_LOGOS_SELF_TYPE_NORMAL CSCoverSheetViewBase* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITapGestureRecognizer * recognizer) {
	

	if (!activated)  {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"com.counted.showCountdown" object:nil userInfo:nil];
	} else {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"com.counted.closeCountdown" object:nil userInfo:nil];
	}

}


 
static void _logos_method$_ungrouped$SBFLockScreenDateView$layoutSubviews(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	subFrame = self.frame;
	_logos_orig$_ungrouped$SBFLockScreenDateView$layoutSubviews(self, _cmd);
}




static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$setAccessoryView$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIView * arg1) {
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openCountdown) name:@"com.counted.showCountdown" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeCountdown) name:@"com.counted.closeCountdown" object:nil];
	_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$setAccessoryView$(self, _cmd, arg1);
}

static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$setDate$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSDate * arg1) {
	activated = false;
	[countDownLabel removeFromSuperview];
	_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$setDate$(self, _cmd, arg1);
}
static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$_setDate$inTimeZone$(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSDate * arg1, id arg2){
	activated = false;
	[countDownLabel removeFromSuperview];
	_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$_setDate$inTimeZone$(self, _cmd, arg1, arg2);
}
static id _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$date(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	activated = false;
	countDownLabel.text = @"";
	return _logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$date(self, _cmd);
}

static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$closeCountdown(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	[self setDate:self.date];
	self.frame = oldFrame;
	
	activated = false;
}

static void _logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$openCountdown(_LOGOS_SELF_TYPE_NORMAL SBFLockScreenDateSubtitleDateView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {

	enabled = [([file objectForKey:@"kEnabled"] ?: @(true)) boolValue];

	
	chosenMode = [([file objectForKey:@"kTextFormat"] ?: @(0)) intValue];

	
	font = [([file objectForKey:@"kFont"] ?: @(0)) intValue];

	
	alignment = [([file objectForKey:@"kAlign"] ?: @(1)) intValue];

	
	NSString *subjectString = @"[blank]";
	if ([file objectForKey:@"kSubject"] != nil) {
		subjectString = [file objectForKey:@"kSubject"];
	}

	


	
	SBUILegibilityLabel *label = MSHookIvar<SBUILegibilityLabel *>(self, "_label");
	if ([file objectForKey:@"kDate"] != nil) {
		myDate = [file objectForKey:@"kDate"];
	} else {
		myDate = [NSDate date];                      
	}
	NSDate *startDate = [NSDate date];                      
	NSTimeInterval secondsBetween = [myDate timeIntervalSinceDate:startDate];
	int numberOfDays = secondsBetween / 86400;

	
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

		
		_UILegibilitySettings *settings = label.legibilitySettings;
		countDownLabel.textColor = settings.primaryColor;

		
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




static __attribute__((constructor)) void _logosLocalCtor_7d5e59f6(int __unused argc, char __unused **argv, char __unused **envp) {
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
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CSCoverSheetViewBase = objc_getClass("CSCoverSheetViewBase"); MSHookMessageEx(_logos_class$_ungrouped$CSCoverSheetViewBase, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$CSCoverSheetViewBase$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$CSCoverSheetViewBase$layoutSubviews);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UITapGestureRecognizer *), strlen(@encode(UITapGestureRecognizer *))); i += strlen(@encode(UITapGestureRecognizer *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$CSCoverSheetViewBase, @selector(handleSingleTap:), (IMP)&_logos_method$_ungrouped$CSCoverSheetViewBase$handleSingleTap$, _typeEncoding); }Class _logos_class$_ungrouped$SBFLockScreenDateView = objc_getClass("SBFLockScreenDateView"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateView$layoutSubviews);Class _logos_class$_ungrouped$SBFLockScreenDateSubtitleDateView = objc_getClass("SBFLockScreenDateSubtitleDateView"); MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateSubtitleDateView, @selector(setAccessoryView:), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$setAccessoryView$, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$setAccessoryView$);MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateSubtitleDateView, @selector(setDate:), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$setDate$, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$setDate$);MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateSubtitleDateView, @selector(_setDate:inTimeZone:), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$_setDate$inTimeZone$, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$_setDate$inTimeZone$);MSHookMessageEx(_logos_class$_ungrouped$SBFLockScreenDateSubtitleDateView, @selector(date), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$date, (IMP*)&_logos_orig$_ungrouped$SBFLockScreenDateSubtitleDateView$date);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBFLockScreenDateSubtitleDateView, @selector(closeCountdown), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$closeCountdown, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SBFLockScreenDateSubtitleDateView, @selector(openCountdown), (IMP)&_logos_method$_ungrouped$SBFLockScreenDateSubtitleDateView$openCountdown, _typeEncoding); }} }
#line 223 "Tweak.xm"
