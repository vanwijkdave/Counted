#import <Cephei/HBPreferences.h>

@interface _UILegibilitySettings
-(UIColor *)primaryColor;
@end

@interface SBUILegibilityLabel : UIView 
-(void)setString:(NSString *)arg1;
@property (assign,nonatomic) long long textAlignment; 
-(_UILegibilitySettings *)legibilitySettings;
@end


//things
CGRect subFrame;
bool addedView;
UIView *touchView;
HBPreferences *file;
bool activated;
UILabel *countDownLabel;
CGRect oldFrame;
CGRect frame;

//settings
bool enabled;
bool alwaysShowCountdown;
int chosenMode;
int alignment;
int font;
NSDate *myDate;


@interface retrieveDateStuff : NSObject 
-(NSString *)getDateString;
@end

@implementation retrieveDateStuff
-(NSString *)getDateString {
	enabled = [([file objectForKey:@"kEnabled"] ?: @(true)) boolValue];

	alwaysShowCountdown = [([file objectForKey:@"kPermanent"] ?: @(false)) boolValue];

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

	//set date shit
	if ([file objectForKey:@"kDate"] != nil) {
		myDate = [file objectForKey:@"kDate"];
	} else {
		myDate = [NSDate date];                      
	}
	NSDate *startDate = [NSDate date];                      
	NSTimeInterval secondsBetween = [myDate timeIntervalSinceDate:startDate];
	int numberOfDays = secondsBetween / 86400;

	//set it
		NSString *dateString;
		if (chosenMode == 0) {
			dateString = [NSString stringWithFormat:@"Days Till %@: %d", subjectString ,numberOfDays];
		} else if (chosenMode == 1) {
			dateString = [NSString stringWithFormat:@"Days: %d", numberOfDays];
		} else if (chosenMode == 2) {
			dateString = [NSString stringWithFormat:@"%@: %d days", subjectString, numberOfDays];
		} else if (chosenMode == 3) {
			dateString = [NSString stringWithFormat:@"%@: %dd", subjectString, numberOfDays];
		} else if (chosenMode == 4) {
			dateString = [NSString stringWithFormat:@"%d Days Till %@", numberOfDays, subjectString];
		}


	return dateString;

}

@end


@interface SBFLockScreenDateSubtitleView : UIView <UIGestureRecognizerDelegate>
-(NSString *)string;
-(void)_updateForCurrentSizeCategory;
@end

@interface SBFLockScreenDateSubtitleDateView : SBFLockScreenDateSubtitleView 
-(NSDate *)date;
-(void)setDate:(NSDate *)arg1 ;
-(void)applyCountdown;
@end

@interface BSUIScrollView : UIScrollView
@end

@interface SBFLockScreenDateView : UIView
@end
@interface CSCoverSheetViewBase : UIView 
@end

@interface CSTeachableMomentsContainerView : UIView 
@property (nonatomic,retain) SBUILegibilityLabel * callToActionLabel;                           //@synthesize callToActionLabel=_callToActionLabel - In the implementation block
@end

@interface SBUICallToActionLabel : UIView 
@property (nonatomic,copy) NSString * text;                                           //@synthesize text=_text - In the implementation block
@end
