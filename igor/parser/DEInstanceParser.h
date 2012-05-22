#import "DEPatternParser.h"

@interface DEInstanceParser : NSObject <DEPatternParser>

@property(strong) id <DEPatternParser> classParser;
@property(strong) NSArray *simpleParsers;


+ (id <DEPatternParser>)parserWithClassParser:(id <DEPatternParser>)classParser simpleParsers:(NSArray *)simplerParsers;
@end
