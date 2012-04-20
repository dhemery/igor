#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"

@implementation InstanceParser

@synthesize simpleParsers;
@synthesize classParser;


- (id <PatternParser>)initWithClassParser:(id <PatternParser>)theClassParser simpleParsers:(NSArray *)theSimpleParsers {
    self = [super init];
    if (self) {
        classParser = theClassParser;
        simpleParsers = [NSArray arrayWithArray:theSimpleParsers];
    }
    return self;
}

- (id <Matcher>)parseSimpleMatcherFromScanner:(id <QueryScanner>)scanner {
    for (id <PatternParser> parser in simpleParsers) {
        id <Matcher> matcher = [parser parseMatcherFromScanner:scanner];
        if (matcher) return matcher;
    }
    return nil;
}

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner {
    NSMutableArray *simpleMatchers = [NSMutableArray array];

    id <Matcher> matcher = [classParser parseMatcherFromScanner:scanner];
    if (matcher) [simpleMatchers addObject:matcher];

    while((matcher = [self parseSimpleMatcherFromScanner:scanner])) {
        [simpleMatchers addObject:matcher];
    }
    if ([simpleMatchers count] == 0) return nil;
    return [InstanceMatcher matcherWithSimpleMatchers:simpleMatchers];
}

+ (id <PatternParser>)parserWithClassParser:(id <PatternParser>)classParser simpleParsers:(NSArray *)simpleParsers {
    return [[self alloc] initWithClassParser:classParser simpleParsers:simpleParsers];
}
@end
