#import "Matcher.h"
#import "RelationshipMatcher.h"

@class ClassMatcher;
@class PredicateMatcher;

@interface NodeMatcher : NSObject<RelationshipMatcher>

@property(retain, readonly) ClassMatcher *classMatcher;
@property(retain, readonly) PredicateMatcher *predicateMatcher;

+ (NodeMatcher *)withClassMatcher:(ClassMatcher *)classMatcher predicateMatcher:(PredicateMatcher *)predicateMatcher;

@end
