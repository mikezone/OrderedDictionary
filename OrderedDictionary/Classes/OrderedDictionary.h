//
//  OrderedDictionary.h
//  OrderedDictionary
//
//  Created by Mike on 16/4/21.
//  Copyright © 2016年 Mike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderedDictionary<__covariant KeyType, __covariant ObjectType>  : NSObject

@property(nonatomic, readonly) NSUInteger count;

+ (instancetype)dictionary;

- (NSArray *)allKeys;
- (NSArray *)allValues;

- (KeyType)keyAtIndex:(NSUInteger)index;
- (ObjectType)objectAtIndex:(NSUInteger)index;
- (ObjectType)objectForKey:(KeyType)key;
- (ObjectType)objectForKeyedSubscript:(KeyType)key;

- (void)setObject:(ObjectType)anObject atIndex:(NSUInteger)atIndex;
- (void)setObject:(ObjectType)anObject forKey:(KeyType)aKey;
- (void)setObject:(ObjectType)anObject forKeyedSubscript:(KeyType <NSCopying>)aKey;

- (void)removeObjectForKey:(KeyType)aKey;
- (void)removeAllObjects;
- (void)removeObjectsForKeys:(NSArray *)keyArray;

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(KeyType key, ObjectType obj, BOOL *stop))block NS_AVAILABLE(10_6, 4_0);

@end
