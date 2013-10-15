#import "DEMatcher.h"

@interface DETagMatcher : NSObject<DEMatcher>

@property(nonatomic) NSInteger targetTag;

+ (id <DEMatcher>)matcherWithTag:(NSInteger)tag;
@end
