#import <OCHamcrestIOS/HCDescription.h>
#import "SimpleMatcher.h"
#import "MatchesView.h"

@implementation MatchesView {
    UIView* _targetView;
}

- (void) describeTo:(id<HCDescription>)description {
    [[description appendText:@"Matches view "] appendDescriptionOf:_targetView];
}

- (MatchesView *) initWithView:(UIView *)targetView {
    if (self = [super init]) {
        _targetView = targetView;
    }
    return self;
}

- (BOOL) matches:(id)matcher {
    return [(id<SimpleMatcher>)matcher matchesView:_targetView];
}

+ (MatchesView *) view:(UIView *)targetView {
    return [[self alloc] initWithView:targetView];
}

+ (MatchesViewInTree *)view:(UIView *)targetView inTree:(UIView *)root {
    return [MatchesViewInTree view:targetView inTree:root];
}

@end
