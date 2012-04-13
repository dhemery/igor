#import "InstanceParser.h"
@protocol SimplePatternParser;

@interface ScanningInstanceParser : NSObject<InstanceParser>

+ (id<InstanceParser>)parserWithClassParser:(id<SimplePatternParser>)classParser predicateParser:(id<SimplePatternParser>)predicateParser;

@end
