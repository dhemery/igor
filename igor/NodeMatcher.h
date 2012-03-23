#import "Matcher.h"

@class ClassMatcher;
@class PredicateMatcher;

@interface NodeMatcher : Matcher

@property(retain, readonly) ClassMatcher *classMatcher;
@property(retain, readonly) PredicateMatcher *predicateMatcher;

+ (NodeMatcher *)withClassMatcher:(ClassMatcher *)classMatcher predicateMatcher:(PredicateMatcher *)predicateMatcher;

@end
