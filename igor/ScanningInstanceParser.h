#import "InstanceParser.h"
@protocol SimplePatternParser;

@interface ScanningInstanceParser : NSObject<InstanceParser>

+ (id<InstanceParser>)parserWithSimplePatternParsers:(NSArray*)simplePatternParsers;

@end
