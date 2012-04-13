#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "ScanningInstanceParser.h"

@implementation ScanningInstanceParser {
    NSArray*simplePatternParsers;
}

- (id<InstanceParser>)initWithSimplePatternParsers:(NSArray*)theSimplePatternParsers {
    if (self = [super init]) {
        simplePatternParsers = [NSArray arrayWithArray:theSimplePatternParsers];
    }
    return self;
}

- (void)parseSimpleMatcherIntoArray:(NSMutableArray *)array {
    for (id<SimplePatternParser> parser in simplePatternParsers) {
        [parser parseSimpleMatcherIntoArray:array];
    }
}

- (id<SubjectMatcher>)parseInstanceMatcher {
    NSMutableArray* simpleMatchers = [NSMutableArray array];
    BOOL addedSomeMatchers;
    do {
        NSUInteger originalCount = [simpleMatchers count];
        [self parseSimpleMatcherIntoArray:simpleMatchers];
        addedSomeMatchers = ([simpleMatchers count] > originalCount);
    } while(addedSomeMatchers);
    return [InstanceMatcher matcherWithSimpleMatchers:simpleMatchers];
}

+ (id<InstanceParser>)parserWithSimplePatternParsers:(NSArray *)simplePatternParsers {
    return [[self alloc] initWithSimplePatternParsers:simplePatternParsers];
}

@end
