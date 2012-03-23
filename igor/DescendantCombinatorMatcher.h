#import "Matcher.h"

@class NodeMatcher;

@interface DescendantCombinatorMatcher : Matcher

@property(retain) Matcher *ancestorMatcher;
@property(retain) NodeMatcher *descendantMatcher;

+ (DescendantCombinatorMatcher *)withAncestorMatcher:(Matcher *)ancestorMatcher descendantMatcher:(NodeMatcher *)descendantMatcher;

@end
