#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "IgorQueryScanner.h"

@implementation InstanceParser

+ (InstanceMatcher *)instanceMatcherFromQuery:(id<IgorQueryScanner>)query {
    NSMutableArray* simpleMatchers = [NSMutableArray array];
    [[ClassParser parser] parseClassMatcherFromQuery:query intoArray:simpleMatchers];
    [[PredicateParser parser] parsePredicateMatcherFromQuery:query intoArray:simpleMatchers];
    return [InstanceMatcher withSimpleMatchers:simpleMatchers];
}

@end
