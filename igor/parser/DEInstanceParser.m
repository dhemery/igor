#import "DEClassParser.h"
#import "DEInstanceMatcher.h"
#import "DEInstanceParser.h"

@implementation DEInstanceParser

@synthesize simpleParsers;
@synthesize classParser;


- (id <DEPatternParser>)initWithClassParser:(id <DEPatternParser>)theClassParser simpleParsers:(NSArray *)theSimpleParsers {
    self = [super init];
    if (self) {
        classParser = theClassParser;
        simpleParsers = [NSArray arrayWithArray:theSimpleParsers];
    }
    return self;
}

- (id <DEMatcher>)parseSimpleMatcherFromScanner:(id <DEQueryScanner>)scanner {
    for (id <DEPatternParser> parser in simpleParsers) {
        id <DEMatcher> matcher = [parser parseMatcherFromScanner:scanner];
        if (matcher) return matcher;
    }
    return nil;
}

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    NSMutableArray *simpleMatchers = [NSMutableArray array];

    id <DEMatcher> matcher = [classParser parseMatcherFromScanner:scanner];
    if (matcher) [simpleMatchers addObject:matcher];

    while((matcher = [self parseSimpleMatcherFromScanner:scanner])) {
        [simpleMatchers addObject:matcher];
    }
    if ([simpleMatchers count] == 0) return nil;
    return [DEInstanceMatcher matcherWithSimpleMatchers:simpleMatchers];
}

+ (id <DEPatternParser>)parserWithClassParser:(id <DEPatternParser>)classParser simpleParsers:(NSArray *)simpleParsers {
    return [[self alloc] initWithClassParser:classParser simpleParsers:simpleParsers];
}
@end
