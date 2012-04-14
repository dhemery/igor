#import "ChainParserState.h"
#import "SubjectMatcher.h"

@implementation ChainParserState

@synthesize matcher, combinator;

- (NSString *)description {
    return [NSString stringWithFormat:@"{%@} {%@}", matcher, combinator];
}

- (ChainParserState *)initWithMatcher:(id <SubjectMatcher>)theMatcher combinator:(id <Combinator>)theCombinator {
    self = [super init];
    if (self) {
        matcher = theMatcher;
        combinator = theCombinator;
    }
    return self;
}

- (BOOL)isDone {
    return self.started && !self.combinator;
}

- (BOOL)isStarted {
    return self.matcher != nil;
}

+ (ChainParserState *)stateWithMatcher:(id <SubjectMatcher>)matcher combinator:(id <Combinator>)combinator {
    return [[self alloc] initWithMatcher:matcher combinator:combinator];
}
@end