@protocol Combinator;
@protocol Matcher;

@interface ChainStep : NSObject

@property(strong, readonly) id <Combinator> combinator;
@property(strong, readonly) id <Matcher> matcher;

+ (ChainStep *)stepWithCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher;

@end
