
#import "DescendantCombinatorMatcher.h"
#import "NodeMatcher.h"

@implementation DescendantCombinatorMatcher

@synthesize ancestorMatcher = _ancestorMatcher, descendantMatcher = _descendantMatcher;

-(NSMutableSet*) ancestorsOfView:(UIView *)view {
    NSMutableSet* ancestors = [NSMutableSet set];
    id ancestor = [view superview];
    while(ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return ancestors;
}

-(BOOL) ancestorMatcherMatchesAnAncestorOfView:(UIView *)view {
    for(id ancestor in [self ancestorsOfView:view]) {
        if([_ancestorMatcher matchesView:ancestor]) {
            return true;
        }
    }
    return false;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"[DescendantCombinatorMatcher:[descendantMatcher:%@][ancestorMatcher:%@]]", _descendantMatcher, _ancestorMatcher];
}

-(DescendantCombinatorMatcher*) initWithAncestorMatcher:(Matcher*)anAncestorMatcher descendantMatcher:(NodeMatcher*)aDescendantMatcher {
    self = [super init];
    if(self) {
        _ancestorMatcher = anAncestorMatcher;
        _descendantMatcher = aDescendantMatcher;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return [_descendantMatcher matchesView:view] && [self ancestorMatcherMatchesAnAncestorOfView:view];
}

+(DescendantCombinatorMatcher*) withAncestorMatcher:(Matcher*)ancestorMatcher descendantMatcher:(NodeMatcher*)descendantMatcher {
    return [[self alloc] initWithAncestorMatcher:ancestorMatcher descendantMatcher:descendantMatcher];
}

@end
