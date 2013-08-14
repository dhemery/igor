#import "DEChainMatcher.h"
#import "DEMatcher.h"

@interface DEPositionMatcher : NSObject <DEChainMatcher>

@property (nonatomic, copy) NSString* position;

- (instancetype)initWithPosition:(NSString *)position;

- (BOOL)matchesView:(UIView *)view;

+ (DEPositionMatcher *)matcherForPosition:(NSString*)position;

@end
