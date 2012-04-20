#import "PatternParser.h"

@interface InstanceParser : NSObject <PatternParser>

@property(strong) id <PatternParser> classParser;
@property(strong) NSArray *simpleParsers;


+ (id <PatternParser>)parserWithClassParser:(id <PatternParser>)classParser simpleParsers:(NSArray *)simplerParsers;
@end
