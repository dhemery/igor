#import "DETagMatcher.h"


@implementation DETagMatcher

@synthesize targetTag;

- (id<DEMatcher>)initWithTag:(NSInteger)tag {
    self = [super init];
    if (self != nil) {
        targetTag = tag;
    }
    return self;
}

+ (id <DEMatcher>)matcherWithTag:(NSInteger)tag {
    return [[self alloc] initWithTag:tag];
}

- (BOOL)matchesView:(UIView *)view {
    return view.tag == self.targetTag;
}

@end
