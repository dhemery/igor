#import "Matcher.h"
#import "RelationshipMatcher.h"

@class NodeMatcher;

@interface DescendantCombinatorMatcher : NSObject<RelationshipMatcher>

@property(retain) id<RelationshipMatcher> ancestorMatcher;
@property(retain) NodeMatcher *descendantMatcher;

+ (DescendantCombinatorMatcher *)withAncestorMatcher:(id<RelationshipMatcher>)ancestorMatcher descendantMatcher:(NodeMatcher *)descendantMatcher;

@end
