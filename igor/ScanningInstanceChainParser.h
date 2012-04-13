#import "InstanceChainParser.h"

@protocol IgorQueryScanner;
@protocol SubjectPatternParser;

@interface ScanningInstanceChainParser : NSObject <InstanceChainParser>

+ (id <InstanceChainParser>)parserWithScanner:(id <IgorQueryScanner>)scanner instanceParser:(id <SubjectPatternParser>)instanceParser;

@end
