#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "IgorQueryScanner.h"

@implementation InstanceParser

+ (InstanceMatcher *)parse:(IgorQueryScanner *)query {
    NSMutableArray* simpleMatchers = [NSMutableArray array];
    [ClassParser parse:query intoArray:simpleMatchers];
    [PredicateParser parse:query intoArray:simpleMatchers];
    return [InstanceMatcher withSimpleMatchers:simpleMatchers];
}

@end
