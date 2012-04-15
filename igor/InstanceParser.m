#import "ClassParser.h"
#import "InstanceMatcher.h"
#import "InstanceParser.h"

@implementation InstanceParser {
    NSArray *simplePatternParsers;
}

- (id <SubjectPatternParser>)initWithSimplePatternParsers:(NSArray *)theSimplePatternParsers {
    self = [super init];
    if (self) {
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

- (id <SubjectMatcher>)parseSubjectMatcher {
    NSMutableArray *simpleMatchers = [NSMutableArray array];
    while([self parseSimpleMatcherIntoArray:simpleMatchers]);
    if ([simpleMatchers count] == 0) return nil;
    return [InstanceMatcher matcherWithSimpleMatchers:simpleMatchers];
}

+ (id <SubjectPatternParser>)parserWithSimplePatternParsers:(NSArray *)simplePatternParsers {
    return [[self alloc] initWithSimplePatternParsers:simplePatternParsers];
}

@end
