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

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)ignored {
    if (index < [simpleMatchers count]) {
        return [simpleMatchers objectAtIndex:index++];
    }
    return nil;
}

+ (FakeSimpleParser *)parserThatYieldsNoSimpleMatchers {
    return [self parserThatYieldsSimpleMatchers:[NSArray array]];
}

+ (FakeSimpleParser *)parserThatYieldsSimpleMatcher:(id <Matcher>)matcher {
    return [self parserThatYieldsSimpleMatchers:[NSArray arrayWithObject:matcher]];
}

+ (FakeSimpleParser *)parserThatYieldsSimpleMatchers:(NSArray *)simpleMatchers {
    return [[self alloc] initWithSimpleMatchers:simpleMatchers];
}

@end
