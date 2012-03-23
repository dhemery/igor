
#import "MemberOfClassMatcher.h"

@implementation MemberOfClassMatcher

-(NSString*) description {
    return [NSString stringWithFormat:@"[MemberOfClassMatcher:[matchClass:%@]]", self.matchClass];
}

+(MemberOfClassMatcher*) forClass:(Class)matchClass {
    return (MemberOfClassMatcher *)[[self alloc] initForClass:matchClass];
}

-(BOOL) matchesView:(UIView*)view {
    return [view isMemberOfClass:self.matchClass];
}

@end
