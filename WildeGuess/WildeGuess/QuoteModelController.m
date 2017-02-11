/* This file provided by Facebook is for non-commercial testing and evaluation
 * purposes only.  Facebook reserves all rights not expressly granted.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "QuoteModelController.h"

#import <UIKit/UIColor.h>

#import "Quote.h"
#import "QuoteDisplayStyle.h"
#import "QuotesPage.h"
#import "Realm/Realm.h"


//realm changes- Creating model object starts
@interface RandomQuotesSchema : RLMObject
@property(nonatomic, copy) NSString *quoteText ;
@property(nonatomic, copy) NSString *quoteAuthor;
@end
RLM_ARRAY_TYPE(RandomQuotesSchema)

@implementation RandomQuotesSchema
@end
//realm changes- Creating model object ends


@implementation QuoteModelController
{
  NSInteger _numberOfObjects;
}

- (instancetype)init
{
  if (self = [super init]) {
    _numberOfObjects = 0;
  }
  return self;
}

-(void) clearCacheDataFromRealmbeforeInsert
{
    
    RLMRealm *defaultRealm = [RLMRealm defaultRealm];
    [defaultRealm beginWriteTransaction];
    [defaultRealm deleteAllObjects];
    [defaultRealm commitWriteTransaction];
    
    NSLog(@"Cleared all data");
}


-(void) insertDataIntoRealmWithQuotes:(NSArray*)quoteTextInput withAuthor:(NSArray *)quoteAuthorInput
{
    //Creating model object and assigning values for each field
  
    
    for (int i=0; i< quoteTextInput.count && quoteAuthorInput.count; i++)
    {
        RLMRealm *defaultRealm = [RLMRealm defaultRealm];
        RandomQuotesSchema *randomquoteObject = [[RandomQuotesSchema alloc] init];
        randomquoteObject.quoteText = quoteTextInput[i];
        randomquoteObject.quoteAuthor = quoteAuthorInput[i];
        
        NSLog(@"quoteText: %@ ",randomquoteObject.quoteText);
        NSLog(@"quoteAuther: %@ ",randomquoteObject.quoteAuthor);
    
       //writing data to the Realm DB with transaction block
        [defaultRealm beginWriteTransaction ];
        [defaultRealm addObject:randomquoteObject];
        [defaultRealm commitWriteTransaction];
    
        NSLog(@"%i record written to DB", i+1);
    }
        
    
}


- (QuotesPage *)fetchNewQuotesPageWithCount:(NSInteger)count
{
    NSAssert(count >= 1, @"Count should be a positive integer");
    NSArray * quotes = generateRandomQuotes(count);
    QuotesPage *quotesPage = [[QuotesPage alloc] initWithQuotes:quotes
                                                       position:_numberOfObjects];
    _numberOfObjects += count;
    return quotesPage;
}


#pragma mark - Random Quote Generation

static NSArray *generateRandomQuotes(NSInteger count)
{
    NSMutableArray *_quotes = [NSMutableArray new];
    RLMResults <RandomQuotesSchema *> *result = [RandomQuotesSchema allObjects];
    NSLog(@"Result array:%@",result);
    
    for (NSUInteger i = 0; i< count; i++) {
       int random_index = arc4random_uniform(12); //generate random number from 12 DB records we have
       Quote *quote  = [[Quote alloc] initWithText:result[random_index].quoteText
                                           author:result[random_index].quoteAuthor
                                           style:generateStyle(i)];
    [_quotes addObject:quote];
  }
  return _quotes;
}

static QuoteDisplayStyle generateStyle(NSUInteger index)
{
  switch (index % 4) {
    case 0:
      return QuoteDisplayStyleFrosted;
    case 1:
      return QuoteDisplayStyleMonochrome;
    case 2:
      return QuoteDisplayStyleWarm;
    case 3:
    default:
      return QuoteDisplayStyleSombre;
  }
}

@end
