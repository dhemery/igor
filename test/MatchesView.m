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
    if (self = [super init]) {
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

+ (MatchesViewInTree *)view:(UIView *)view inTree:(UIView *)tree {
    return [MatchesViewInTree view:view inTree:tree];
}

@end
