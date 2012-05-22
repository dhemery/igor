#import "DEPredicateMatcher.h"

// TODO Test
@implementation DEPredicateMatcher

@synthesize predicate;

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@]", self.expression];
}

- (DEPredicateMatcher *)initWithPredicate:(NSPredicate *)aPredicate {
    self = [super init];
    if (self) {
        predicate = aPredicate;
    }
    return self;
}

- (BOOL)matchesView:(UIView *)view {
    @try {
        return [self.predicate evaluateWithObject:view];
    }
    @catch (NSException *e) {
        return NO;
    }
}

- (NSString *)expression {
    return [self.predicate predicateFormat];
}

+ (DEPredicateMatcher *)matcherForPredicateExpression:(NSString *)expression {
    return [[DEPredicateMatcher alloc] initWithPredicate:[NSPredicate predicateWithFormat:expression]];
}

@end
