#import "SubjectPatternParser.h"

@interface InstanceParser : NSObject<SubjectPatternParser>

+ (id<SubjectPatternParser>)parserWithSimplePatternParsers:(NSArray*)simplePatternParsers;

@end
