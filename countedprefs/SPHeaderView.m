// SPHeaderView.m

#import "SPHeaderView.h"

// SPHeaderView.m
@import CoreText;

@implementation SPHeaderView

- (id)init  {
    self = [super init];

    if (self) {
        self.backgroundColor = [UIColor colorWithRed: 0.50 green: 0.81 blue: 0.84 alpha: 1.00];;

        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, self.bounds.size.width, 118)];
        [self addSubview:self.contentView];

        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.bounds.size.width, 50)];
        self.titleLabel.text = @"Counted";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:42 weight:UIFontWeightBold];

        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];

        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 71, self.bounds.size.width, 32)];
        self.subtitleLabel.text = @"1.0";
        self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subtitleLabel.font = [UIFont systemFontOfSize:27 weight:UIFontWeightMedium];
        
        self.subtitleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        [self.contentView addSubview:self.subtitleLabel];

//        if (@available(iOS 13.0, *)) {
//            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
//                if (self.settings[@"darkHeaderColor"]) self.backgroundColor = self.settings[@"darkHeaderColor"];
//                if (self.settings[@"darkTextColor"]) {
//                    self.titleLabel.textColor = self.settings[@"darkTextColor"];
//                    self.subtitleLabel.textColor = self.settings[@"darkTextColor"];
//                }
//            } else {
//                self.backgroundColor = self.settings[@"headerColor"] ?: self.settings[@"tintColor"];
//                self.titleLabel.textColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
//                self.subtitleLabel.textColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
//            }
//        } else {
//            self.backgroundColor = self.settings[@"headerColor"] ?: self.settings[@"tintColor"];
//            self.titleLabel.textColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
//            self.subtitleLabel.textColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
//        }
    }

    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    CGFloat statusBarHeight = 20;
    // if (@available(iOS 13.0, *)) {
    //     statusBarHeight = self.window.windowScene.statusBarManager.statusBarFrame.size.height;
    // } else {
    //     statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    // }

    CGFloat offset = statusBarHeight + [self _viewControllerForAncestor].navigationController.navigationController.navigationBar.frame.size.height;

    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, (frame.size.height - offset)/2 - self.contentView.frame.size.height/2 + offset - 10, frame.size.width, self.contentView.frame.size.height);

    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, frame.size.width, self.titleLabel.frame.size.height);

    self.subtitleLabel.frame = CGRectMake(self.subtitleLabel.frame.origin.x, self.subtitleLabel.frame.origin.y, frame.size.width, self.subtitleLabel.frame.size.height);
}

- (CGFloat)contentHeightForWidth:(CGFloat)width {
    return 180;
}


@end
