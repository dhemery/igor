#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "PredicateMatcher.h"
#import "IgorQueryScanner.h"

@implementation InstanceParser

+ (InstanceMatcher *)parse:(IgorQueryScanner *)query {
    id<ClassMatcher> classMatcher = [ClassParser parse:query];
    id<SimpleMatcher> predicateMatcher = [PredicateParser parse:query];
    return [InstanceMatcher withClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

@end
