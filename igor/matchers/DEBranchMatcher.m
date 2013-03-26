#import "DEBranchMatcher.h"
#import "DECombinator.h"
#import "DEIdentityMatcher.h"
#import "DECombinatorMatcher.h"

@implementation DEBranchMatcher

@synthesize subjectMatcher = _subjectMatcher;
@synthesize combinators = _combinators;
@synthesize relativeMatcher = _relativeMatcher;
@synthesize subjectIdentityMatcher = _subjectIdentityMatcher;

+ (DEBranchMatcher *)matcherWithSubjectMatcher:(id <DEMatcher>)subjectMatcher {
    return [[self alloc] initWithSubjectMatcher:subjectMatcher];
}

- (DEBranchMatcher *)initWithSubjectMatcher:(id <DEMatcher>)subjectMatcher {
    self = [super init];
    if (self) {
        _subjectMatcher = subjectMatcher;
        _combinators = [NSMutableArray array];
        _subjectIdentityMatcher = [DEIdentityMatcher matcherWithView:nil description:@"$$"];
        _relativeMatcher = [DECombinatorMatcher matcherWithSubjectMatcher:_subjectIdentityMatcher];
    }
    return self;
}

- (void)appendCombinator:(id <DECombinator>)combinator matcher:(id <DEMatcher>)matcher {
    [self.combinators addObject:combinator];
    [self.relativeMatcher appendCombinator:combinator matcher:matcher];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@%@)", self.subjectMatcher, self.relativeMatcher];
}

- (BOOL)matchesView:(id)subject {
    if (![self.subjectMatcher matchesView:subject]) return NO;

    if ([self.combinators count] == 0) return YES;

    NSMutableArray *scope = [NSMutableArray arrayWithObject:subject];

    for (id<DECombinator> combinator in self.combinators) {
        NSMutableArray *previousScope = scope;
        scope = [NSMutableArray array];
        for (id view in previousScope) {
            NSArray *newRelatives = [combinator relativesOfView:view];
            [scope addObjectsFromArray:newRelatives];
        }
    }

    for (id relative in scope) {
        self.subjectIdentityMatcher.targetView = subject;
        if ([self.relativeMatcher matchesView:relative]) return YES;
    }
    return NO;
}

@end
