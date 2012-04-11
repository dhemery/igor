
#import "ComplexMatcher.h"
#import "UniversalMatcher.h"
#import "InstanceMatcher.h"

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
    return [_subject matchesView:view inTree:root] && [self headMatcherMatchesAnAncestorOfView:view inTree:root];
}

+ (ComplexMatcher *)withHead:(NSArray *)head subject:(id <SubjectMatcher>)subject {
    return [self withHead:head subject:subject tail:[NSArray array]];
}

+ (ComplexMatcher *)withHead:(NSArray*)head subject:(id <SubjectMatcher>)subject tail:(NSArray*)tail {
    return [[self alloc] initWithHead:head subject:subject tail:tail];
}

+ (ComplexMatcher *)withSubject:(id <SubjectMatcher>)subject {
    return [self withHead:[NSArray array] subject:subject tail:[NSArray array]];
}

- (NSMutableArray *)ancestorsOfView:(UIView *)view {
    NSMutableArray *ancestors = [NSMutableArray array];
    id ancestor = [view superview];
    while (ancestor) {
        [ancestors addObject:ancestor];
        ancestor = [ancestor superview];
    }
    return ancestors;
}

- (NSMutableArray *)ancestorsOfView:(UIView *)view withinTree:(UIView *)root {
    NSMutableArray *ancestorsOfView = [self ancestorsOfView:view];
    [ancestorsOfView removeObjectsInArray:[self ancestorsOfView:root]];
    return ancestorsOfView;
}

- (id <SubjectMatcher>)headMatcher {
    if ([_head count] == 0) {
        return [InstanceMatcher withSimpleMatchers:[NSArray arrayWithObject:[UniversalMatcher new]]];
    }
    if ([_head count] == 1) {
        return [_head objectAtIndex:0];
    }
    return nil;
}

- (BOOL)headMatcherMatchesAnAncestorOfView:(UIView *)view inTree:(UIView *)root {
    id<SubjectMatcher> headMatcher = [self headMatcher];
    for (id ancestor in [self ancestorsOfView:view withinTree:root]) {
        if ([headMatcher matchesView:ancestor inTree:root]) {
            return true;
        }
    }
    return false;
}

@end
