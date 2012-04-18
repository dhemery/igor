#import "BranchMatcher.h"
#import "Combinator.h"
#import "IdentityMatcher.h"
#import "CombinatorMatcher.h"

@implementation BranchMatcher

@synthesize subjectMatcher = _subjectMatcher;
@synthesize combinators = _combinators;
@synthesize relativeMatcher = _relativeMatcher;
@synthesize subjectIdentityMatcher = _subjectIdentityMatcher;

+ (BranchMatcher *)matcherWithSubjectMatcher:(id <Matcher>)subjectMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher];
}

- (BranchMatcher *)initWithSubjectMatcher:(id <Matcher>)subjectMatcher {
    self = [super init];
    if (self) {
        _subjectMatcher = subjectMatcher;
        _combinators = [NSMutableArray array];
        _subjectIdentityMatcher = [IdentityMatcher matcherWithView:nil description:@"$$"];
        _relativeMatcher = [CombinatorMatcher matcherWithSubjectMatcher:_subjectIdentityMatcher];
    }
    return self;
}

- (void)appendCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher {
    [self.combinators addObject:combinator];
    [self.relativeMatcher appendCombinator:combinator matcher:matcher];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@%@)", self.subjectMatcher, self.relativeMatcher];
}

- (BOOL)matchesView:(UIView *)subject {
    if (![self.subjectMatcher matchesView:subject]) return NO;

    if ([self.combinators count] == 0) return YES;

    NSMutableArray *scope = [NSMutableArray arrayWithObject:subject];

    for (id<Combinator> combinator in self.combinators) {
        NSMutableArray *previousScope = scope;
        scope = [NSMutableArray array];
        for (UIView *view in previousScope) {
            NSArray *newRelatives = [combinator relativesOfView:view];
            [scope addObjectsFromArray:newRelatives];
        }
    }

    for (UIView *relative in scope) {
        self.subjectIdentityMatcher.targetView = subject;
        if ([self.relativeMatcher matchesView:relative]) return YES;
    }
    return NO;
}

@end
