#import <OCHamcrestIOS/HCDescription.h>
#import "SimpleMatcher.h"
#import "MatchesView.h"

@implementation MatchesView {
    UIView *targetView;
}

- (void)describeTo:(id <HCDescription>)description {
    [[description appendText:@"Matches view "] appendDescriptionOf:targetView];
}

- (MatchesView *)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        targetView = view;
    }
    return self;
}

- (BOOL)matches:(id)matcher {
    return [(id <SimpleMatcher>) matcher matchesView:targetView];
}

+ (MatchesView *)view:(UIView *)view {
    return [[self alloc] initWithView:view];
}

@end
