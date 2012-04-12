#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"
#import "PredicateParser.h"
#import "IgorQueryScanner.h"

@implementation InstanceParser {
    ClassParser *classParser;
    PredicateParser *predicateParser;
}

- (InstanceParser *)initWithClassParser:(ClassParser *)theClassParser predicateParser:(PredicateParser *)thePredicateParser {
    if (self = [super init]) {
        classParser = theClassParser;
        predicateParser = thePredicateParser;
    }
    return self;
}

- (id<SubjectMatcher>)parseInstanceMatcherFromQuery:(id <IgorQueryScanner>)query {
    NSMutableArray* simpleMatchers = [NSMutableArray array];
    [classParser parseClassMatcherFromQuery:query intoArray:simpleMatchers];
    [predicateParser parsePredicateMatcherFromQuery:query intoArray:simpleMatchers];
    return [InstanceMatcher withSimpleMatchers:simpleMatchers];
}

+ (InstanceParser *)parserWithClassParser:(ClassParser *)classParser predicateParser:(PredicateParser *)predicateParser {
    return [[self alloc] initWithClassParser:classParser predicateParser:predicateParser];
}


@end
