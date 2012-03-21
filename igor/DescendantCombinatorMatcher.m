
#import "DescendantCombinatorMatcher.h"

@implementation DescendantCombinatorMatcher

@synthesize ancestorMatcher, descendantMatcher;

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
        if([ancestorMatcher matchesView:ancestor]) {
            return true;
        }
    }
    return false;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"[DescendantCombinatorMatcher:[descendantMatcher:%@][ancestorMatcher:%@]]", descendantMatcher, ancestorMatcher];
}

-(DescendantCombinatorMatcher*) initWithAncestorMatcher:(id<Matcher>)anAncestorMatcher descendantMatcher:(id<Matcher>)aDescendantMatcher {
    if(self = [super init]) {
        self.ancestorMatcher = anAncestorMatcher;
        self.descendantMatcher = aDescendantMatcher;
    }
    return self;
}

-(BOOL) matchesView:(UIView*)view {
    return [descendantMatcher matchesView:view] && [self ancestorMatcherMatchesAnAncestorOfView:view];
}

+(DescendantCombinatorMatcher*) withAncestorMatcher:(id<Matcher>)ancestorMatcher descendantMatcher:(id<Matcher>)descendantMatcher {
    return [[self alloc] initWithAncestorMatcher:ancestorMatcher descendantMatcher:descendantMatcher];
}

@end
