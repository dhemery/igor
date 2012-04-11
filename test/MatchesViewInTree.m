#import <OCHamcrestIOS/HCDescription.h>
#import "MatchesViewInTree.h"
#import "SubjectMatcher.h"


@implementation MatchesViewInTree {
    UIView* _targetView;
    UIView* _root;
}

- (void) describeTo:(id<HCDescription>)description {
    [[description appendText:@"Matches view "] appendDescriptionOf:_targetView];
    [[description appendText:@" in tree "] appendDescriptionOf:_root];
}

+ (MatchesViewInTree *) view:(UIView *)targetView inTree:(UIView *)root{
    return [[self alloc] initWithView:targetView inTree:root];
}

- (MatchesViewInTree *) initWithView:(UIView *)targetView inTree:(UIView *)root{
    if (self = [super init]) {
        _targetView = targetView;
        _root = root;
    }
    return self;
}

- (BOOL) matches:(id)matcher {
    return [(id<SubjectMatcher>)matcher matchesView:_targetView inTree:_root];
}

@end