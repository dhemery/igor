#import "FakeSubjectParser.h"
#import "Matcher.h"

@implementation FakeSubjectParser {
    NSUInteger index;
    NSArray *subjectMatchers;
}

- (FakeSubjectParser *)initWithSubjectMatchers:(NSArray *)theSubjectMatchers {
    self = [super init];
    if (self) {
        subjectMatchers = [NSArray arrayWithArray:theSubjectMatchers];
        index = 0;
    }
    return self;
}

+ (FakeSubjectParser *)parserThatYieldsNoSubjectMatchers {
    return [self parserThatYieldsSubjectMatchers:[NSArray array]];
}

+ (FakeSubjectParser *)parserThatYieldsSubjectMatcher:(id <Matcher>)subjectMatcher {
    return [self parserThatYieldsSubjectMatchers:[NSArray arrayWithObject:subjectMatcher]];
}

+ (FakeSubjectParser *)parserThatYieldsSubjectMatchers:(NSArray *)subjectMatchers {
    return [[self alloc] initWithSubjectMatchers:subjectMatchers];
}

- (id <Matcher>)parseMatcher {
    if (index < [subjectMatchers count]) {
        return [subjectMatchers objectAtIndex:index++];
    }
    return nil;
}

@end
