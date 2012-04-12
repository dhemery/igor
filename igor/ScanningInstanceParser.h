#import "InstanceParser.h"
@protocol ClassParser;
@protocol PredicateParser;

@interface ScanningInstanceParser : NSObject<InstanceParser>

+ (id<InstanceParser>)parserWithClassParser:(id<ClassParser>)classParser predicateParser:(id<PredicateParser>)predicateParser;

@end
