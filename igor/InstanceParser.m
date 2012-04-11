#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "IgorQueryScanner.h"

@implementation InstanceParser

+ (InstanceMatcher *)instanceMatcherFromQuery:(IgorQueryScanner *)query {
    NSMutableArray* simpleMatchers = [NSMutableArray array];
    [ClassParser addClassMatcherFromQuery:query toArray:simpleMatchers];
    [PredicateParser addPredicateMatcherFromQuery:query toArray:simpleMatchers];
    return [InstanceMatcher withSimpleMatchers:simpleMatchers];
}

@end
