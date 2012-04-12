#import "ScanningClassParser.h"
#import "InstanceMatcher.h"
#import "ScanningInstanceParser.h"
#import "ScanningPredicateParser.h"

@implementation ScanningInstanceParser {
    id<ClassParser> classParser;
    id<PredicateParser> predicateParser;
}

- (id<InstanceParser>)initWithClassParser:(id<ClassParser>)theClassParser predicateParser:(id<PredicateParser>)thePredicateParser {
    if (self = [super init]) {
        classParser = theClassParser;
        predicateParser = thePredicateParser;
    }
    return self;
}

- (id<SubjectMatcher>)parseInstanceMatcher {
    NSMutableArray* simpleMatchers = [NSMutableArray array];
    [classParser parseClassMatcherIntoArray:simpleMatchers];
    [predicateParser parsePredicateMatcherIntoArray:simpleMatchers];
    return [InstanceMatcher withSimpleMatchers:simpleMatchers];
}

+ (id<InstanceParser>)parserWithClassParser:(id<ClassParser>)classParser predicateParser:(id<PredicateParser>)predicateParser {
    return [[self alloc] initWithClassParser:classParser predicateParser:predicateParser];
}

@end
