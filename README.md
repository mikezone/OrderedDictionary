懒老师教出勤奋的学生，懒的后端提升前端的数据解析能力。也是头一次遇到这种要求字典中的kv对顺序要和返回json一致的情况。

## Usage

### `OrderedDictionary`类型是一个有序的字典，支持字典的大部分操作

```objectivec
OrderedDictionary *dict = [OrderedDictionary dictionary];
dict[@"key1"] = @(10);
dict[@"key2"] = @(11);
NSLog(@"%@", dict[@"key1"]); // 10
NSLog(@"%zd", dict.count); // 2
NSLog(@"%@", dict.allKeys); // [key1, key2]
NSLog(@"%@", dict.allValues); // [10, 11]
[dict setObject:@(12) forKey:@"key3"]; 
NSLog(@"%@", dict); // {key1 = 10; key2 = 11; key3 = 12;}
```
注意`OrderDictionary`不区分mutable和not mutable, 支持与`NSMutableDictionary`类似的增、删、改.

### 将json中的所有字典按照有序字典`OrderedDictionary`解析

```objectivec
NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1.json" ofType:nil];
NSData *data = [NSData dataWithContentsOfFile:filePath]; 
JSONDecoder *decoder = [[JSONDecoder alloc] init];
id value = [decoder objectWithData:data error:NULL]; 
```
解析后的value中所有的字典是`OrderedDictionary`类型，kv对的顺序与json中的完全一致。