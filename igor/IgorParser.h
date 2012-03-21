
#import "Parser.h"

@interface IgorParser : NSObject

-(id<Matcher>) parse:(NSString*) pattern;

@end
