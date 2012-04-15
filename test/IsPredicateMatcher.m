#import <OCHamcrestIOS/HCDescription.h>
#import "IsPredicateMatcher.h"
#import "PredicateMatcher.h"

@implementation IsPredicateMatcher {
    NSPredicate *predicate;
}

+ (IsPredicateMatcher *)forExpression:(NSString *)expression {
    return [[self alloc] initWithExpression:expression];
}

- (IsPredicateMatcher *)initWithExpression:(NSString *)expression {
    self = [super init];
    if (self) {
        predicate = [NSPredicate predicateWithFormat:expression];
    }
    return self;
}

- (BOOL)matches:(id)item {
    if (![item isMemberOfClass:[PredicateMatcher class]]) {
        return NO;
    }
    PredicateMatcher *matcher = item;
    return [matcher.expression isEqualToString:[predicate predicateFormat]];
}

- (void)describeTo:(id <HCDescription>)description; {
    [description appendDescriptionOf:predicate];
}

@end
