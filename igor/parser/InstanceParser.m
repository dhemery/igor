#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"

@implementation InstanceParser

@synthesize simplePatternParsers;


- (id <PatternParser>)initWithSimplePatternParsers:(NSArray *)theSimplePatternParsers {
    self = [super init];
    if (self) {
        simplePatternParsers = [NSArray arrayWithArray:theSimplePatternParsers];
    }
    return self;
}

- (id <Matcher>)parseSimpleMatcherFromScanner:(id <QueryScanner>)scanner {
    for (id <PatternParser> parser in simplePatternParsers) {
        id <Matcher> matcher = [parser parseMatcherFromScanner:scanner];
        if (matcher) return matcher;
    }
    return nil;
}

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner {
    id <Matcher> matcher = [self parseSimpleMatcherFromScanner:scanner];

    if (!matcher) return nil;

    NSMutableArray *simpleMatchers = [NSMutableArray array];
    while(matcher) {
        [simpleMatchers addObject:matcher];
        matcher = [self parseSimpleMatcherFromScanner:scanner];
    }
    return [InstanceMatcher matcherWithSimpleMatchers:simpleMatchers];
}

+ (id <PatternParser>)parserWithSimplePatternParsers:(NSArray *)simplePatternParsers {
    return [[self alloc] initWithSimplePatternParsers:simplePatternParsers];
}

@end
