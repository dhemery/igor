
#import "Matcher.h"

@protocol Parser <NSObject>

-(id<Matcher>) parse:(NSScanner*)scanner;

@end
