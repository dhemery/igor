
#import "ClassMatcher.h"
#import "NodeMatcher.h"
#import "PredicateMatcher.h"

@implementation NodeMatcher

@synthesize simpleMatchers;

-(NSString*) description {
    return [NSString stringWithFormat:@"[CompoundMatcher:%@]", simpleMatchers];
}

-(NodeMatcher*) initWithClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(PredicateMatcher*)predicateMatcher {
    if(self = [super init]) {
        simpleMatchers = [NSArray arrayWithObjects:classMatcher, predicateMatcher, nil];
    }
    return self;
}

-(BOOL) matchesView:(UIView *)view {
    for(id<Matcher> matcher in self.simpleMatchers) {
        if(![matcher matchesView:view]) return NO;
    }
    return YES;
}

+(NodeMatcher*) withClassMatcher:(id<ClassMatcher>)classMatcher predicateMatcher:(PredicateMatcher*)predicateMatcher {
    return [[self alloc] initWithClassMatcher:classMatcher predicateMatcher:predicateMatcher];
}

@end
