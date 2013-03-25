#import <OCHamcrestIOS/HCDescription.h>
#import "MatchesView.h"
#import "DEMatcher.h"

@implementation MatchesView {
    id targetView;
}

- (void)describeTo:(id <HCDescription>)description {
    [[description appendText:@"Matches view "] appendDescriptionOf:targetView];
}

- (id)initWithView:(id)view {
    self = [super init];
    if (self) {
        targetView = view;
    }
    return self;
}

- (BOOL)matches:(id)matcher {
    return [(id <DEMatcher>) matcher matchesView:targetView];
}

+ (id)view:(id)view {
    return [[self alloc] initWithView:view];
}

@end
