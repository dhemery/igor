#import <OCHamcrestIOS/HCDescription.h>
#import "IsPredicateMatcher.h"
#import "PredicateMatcher.h"

@implementation IsPredicateMatcher {
    NSString *_expression;
}

+ (id) forExpression:(NSString *)expression{
    return [[self alloc] initWithClass:expression];
}

- (id) initWithClass:(NSString *)expression {
    if (self = [super init]) {
        _expression = expression ;
    }
    return self;
}

- (BOOL) matches:(id)item {
    if (![item isMemberOfClass:[PredicateMatcher class]]) {
        return NO;
    }
    PredicateMatcher* matcher = item;
    return [matcher.matchExpression isEqualToString:[[NSPredicate predicateWithFormat:_expression] predicateFormat]];
}

- (void) describeTo:(id<HCDescription>)description; {
    [description appendDescriptionOf:[PredicateMatcher withPredicateExpression:_expression]];
}

@end
