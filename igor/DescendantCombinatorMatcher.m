#import "DescendantCombinatorMatcher.h"
#import "NodeMatcher.h"

@implementation DescendantCombinatorMatcher

@synthesize ancestorMatcher = _ancestorMatcher, descendantMatcher = _descendantMatcher;

- (NSMutableArray *)ancestorsOfView:(UIView *)view withinTree:(UIView *)root {
    NSMutableArray *ancestors = [NSMutableArray array];
    id ancestor = [view superview];
    while (ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return ancestors;
}

- (BOOL)ancestorMatcherMatchesAnAncestorOfView:(UIView *)view withinTree:(UIView *)root {
    for (id ancestor in [self ancestorsOfView:view withinTree:root]) {
        if ([_ancestorMatcher matchesView:ancestor withinTree:root]) {
            return true;
        }
    }
    return false;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[DescendantCombinatorMatcher:[descendantMatcher:%@][ancestorMatcher:%@]]", _descendantMatcher, _ancestorMatcher];
}

- (DescendantCombinatorMatcher *)initWithAncestorMatcher:(id<RelationshipMatcher>)anAncestorMatcher descendantMatcher:(NodeMatcher *)aDescendantMatcher {
    self = [super init];
    if (self) {
        _ancestorMatcher = anAncestorMatcher;
        _descendantMatcher = aDescendantMatcher;
    }
    return self;
}

-(BOOL)matchesView:(UIView *)view withinTree:(UIView *)root {
    return [_descendantMatcher matchesView:view withinTree:root] && [self ancestorMatcherMatchesAnAncestorOfView:view withinTree:root];
}

+ (DescendantCombinatorMatcher *)withAncestorMatcher:(id<RelationshipMatcher>)ancestorMatcher descendantMatcher:(NodeMatcher *)descendantMatcher {
    return [[self alloc] initWithAncestorMatcher:ancestorMatcher descendantMatcher:descendantMatcher];
}

@end
