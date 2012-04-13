@protocol IgorQueryScanner;
@protocol SubjectPatternParser;

#import "InstanceChainParser.h"
#import "IgorQueryParser.h"


@interface ScanningIgorQueryParser : NSObject <IgorQueryParser>

+ (id<IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner instanceParser:(id<SubjectPatternParser>)instanceParser instanceChainParser:(id <InstanceChainParser>)instanceChainParser;

@end
