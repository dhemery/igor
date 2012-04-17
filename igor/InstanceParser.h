#import "PatternParser.h"

@interface InstanceParser : NSObject <PatternParser>

+ (id <PatternParser>)parserWithSimplePatternParsers:(NSArray *)simplePatternParsers;

@end
