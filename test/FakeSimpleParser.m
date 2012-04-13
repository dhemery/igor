#import "FakeSimpleParser.h"

@implementation FakeSimpleParser {
    NSUInteger index;
    NSArray *simpleMatchers;
}

- (FakeSimpleParser *)initWithSimpleMatchers:(NSArray *)theSimpleMatchers {
    self = [super init];
    if (self) {
        simpleMatchers = [NSArray arrayWithArray:theSimpleMatchers];
        index = 0;
    }
    return self;
}

- (BOOL)parseSimpleMatcherIntoArray:(NSMutableArray *)array {
    if (index < [simpleMatchers count]) {
        [array addObject:[simpleMatchers objectAtIndex:index++]];
        return YES;
    }
    return NO;
}

+ (FakeSimpleParser *)parserThatYieldsNoSimpleMatchers {
    return [self parserThatYieldsSimpleMatchers:[NSArray array]];
}

+ (FakeSimpleParser *)parserThatYieldsSimpleMatcher:(id <SimpleMatcher>)matcher {
    return [self parserThatYieldsSimpleMatchers:[NSArray arrayWithObject:matcher]];
}

+ (FakeSimpleParser *)parserThatYieldsSimpleMatchers:(NSArray *)simpleMatchers {
    return [[self alloc] initWithSimpleMatchers:simpleMatchers];
}

@end
