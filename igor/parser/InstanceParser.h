#import "PatternParser.h"

@interface InstanceParser : NSObject <PatternParser>

@property(strong) NSArray *simplePatternParsers;

+ (id <PatternParser>)parserWithSimplePatternParsers:(NSArray *)simplePatternParsers;

@end
