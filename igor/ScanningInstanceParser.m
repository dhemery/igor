#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "ScanningInstanceParser.h"

@implementation ScanningInstanceParser {
    id<SimplePatternParser> classParser;
    id<SimplePatternParser> predicateParser;
}

- (id<InstanceParser>)initWithClassParser:(id<SimplePatternParser>)theClassParser predicateParser:(id<SimplePatternParser>)thePredicateParser {
    if (self = [super init]) {
        classParser = theClassParser;
        predicateParser = thePredicateParser;
    }
    return self;
}

- (id<SubjectMatcher>)parseInstanceMatcher {
    NSMutableArray* simpleMatchers = [NSMutableArray array];
    [classParser parseSimpleMatcherIntoArray:simpleMatchers];
    [predicateParser parseSimpleMatcherIntoArray:simpleMatchers];
    return [InstanceMatcher matcherWithSimpleMatchers:simpleMatchers];
}

+ (id<InstanceParser>)parserWithClassParser:(id<SimplePatternParser>)classParser predicateParser:(id<SimplePatternParser>)predicateParser {
    return [[self alloc] initWithClassParser:classParser predicateParser:predicateParser];
}

@end
