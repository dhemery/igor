#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"

@implementation InstanceParser {
    NSArray *simplePatternParsers;
}

- (id <SubjectPatternParser>)initWithSimplePatternParsers:(NSArray *)theSimplePatternParsers {
    if (self = [super init]) {
        simplePatternParsers = [NSArray arrayWithArray:theSimplePatternParsers];
    }
    return self;
}

- (BOOL)parseSimpleMatcherIntoArray:(NSMutableArray *)array {
    for (id <SimplePatternParser> parser in simplePatternParsers) {
        if ([parser parseSimpleMatcherIntoArray:array]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)parseSubjectMatcherIntoArray:(NSMutableArray *)subjectMatchers {
    NSMutableArray *simpleMatchers = [NSMutableArray array];
    BOOL foundSimpleMatchers = NO;
    while([self parseSimpleMatcherIntoArray:simpleMatchers]) {
        foundSimpleMatchers = YES;
    }
    if (foundSimpleMatchers) {
        [subjectMatchers addObject:[InstanceMatcher matcherWithSimpleMatchers:simpleMatchers]];
    }
    return foundSimpleMatchers;
}

+ (id <SubjectPatternParser>)parserWithSimplePatternParsers:(NSArray *)simplePatternParsers {
    return [[self alloc] initWithSimplePatternParsers:simplePatternParsers];
}

@end
