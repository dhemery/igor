
#import "ComplexMatcher.h"

@implementation ComplexMatcher {
    NSArray* _head;
    id <SubjectMatcher> _subject;
    NSArray* _tail;
}

@synthesize head = _head;
@synthesize subject = _subject;
@synthesize tail = _tail;

- (ComplexMatcher *)initWithHead:(NSArray*)head subject:(id <SubjectMatcher>)subject tail:(NSArray*)tail {
    if (self = [super init]) {
        _head = head;
        _subject = subject;
        _tail = tail;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view inTree:(UIView *)root {
    return YES;
}

+ (ComplexMatcher *)withSubject:(id <SubjectMatcher>)subject {
    return [self withHead:[NSArray array] subject:subject tail:[NSArray array]];
}

+ (ComplexMatcher *)withHead:(NSArray*)head subject:(id <SubjectMatcher>)subject tail:(NSArray*)tail {
    return [[self alloc] initWithHead:head subject:subject tail:tail];
}

@end
