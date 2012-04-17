@protocol QueryScanner;
@protocol PatternParser;
@class ChainParser;

#import "IgorQueryParser.h"


@interface QueryParser : NSObject <IgorQueryParser>

+ (id <IgorQueryParser>)parserWithScanner:(id <QueryScanner>)scanner subjectChainParser:(ChainParser *)subjectChainParser;

@end
