#import <OCHamcrestIOS/HCDescription.h>
#import "MatchesViewInTree.h"
#import "SubjectMatcher.h"


@implementation MatchesViewInTree {
    UIView *targetView;
    UIView *root;
}

- (void)describeTo:(id <HCDescription>)description {
    [[description appendText:@"Matches view "] appendDescriptionOf:targetView];
    [[description appendText:@" in tree "] appendDescriptionOf:root];
}

+ (MatchesViewInTree *)view:(UIView *)view inTree:(UIView *)tree {
    return [[self alloc] initWithView:view inTree:tree];
}

- (MatchesViewInTree *)initWithView:(UIView *)view inTree:(UIView *)tree {
    if (self = [super init]) {
        targetView = view;
        root = tree;
    }
    return self;
}

- (BOOL)matches:(id)matcher {
    return [(id <SubjectMatcher>) matcher matchesView:targetView inTree:root];
}

@end
