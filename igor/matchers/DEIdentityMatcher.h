#import "DEInstanceMatcher.h"

@interface DEIdentityMatcher : NSObject <DEMatcher>

@property(strong) id targetView;

+ (DEIdentityMatcher *)matcherWithView:(id)view description:(NSString *)description;

+ (DEIdentityMatcher *)matcherWithView:(id)view;

@end
