# data structure in python

source:
* https://wiki.python.org/moin/TimeComplexity 
* https://realpython.com/python-data-structures/ 


=> Markdown Table Prettifier extension in vscode
* n = number of elements currently in the container
* k = either the value of a parameter or the number of elements in the parameter

## list

```python
s = ["obj1","obj3"] # init
```


| Code              |    Operation    | Complexity |
|-------------------|:---------------:|-----------:|
| `s[i]`            |    Get Item     |       O(1) |
| `len(s)`          |   Get Length    |       O(1) |
| `for i in s`      |    Iteration    |       O(n) |
| `x in s`          | check if x in s |       O(n) |
| `s.pop()`         |   Delete Item   |       O(n) |
| `s.append(obj)`   |   Append Item   |       O(n) |
| `s.insert(i,obj)` |     Insert      |       O(n) |
| `s.sort()`        |      Sort       | O(nlog(n)) |


## stacks/queue 
deque = Doubly Ended Queue is a generalization of stacks and queues
```python
from collections import deque
q = deque(["obj1","obj3"]) # init 
```

| Code                | Operation  | Complexity |
|---------------------|:----------:|-----------:|
| `q.append(obj)`     |   append   |       O(1) |
| `q.appendleft(obj)` | appendleft |       O(1) |
| `q.pop()`           |    pop     |       O(1) |
| `q.popleft()`       |  popleft   |       O(1) |
| `len(q)`            | Get Length |       O(1) |
| `q.remove(obj)`     |   remove   |       O(n) |
| `q.copy()`          |    Copy    |       O(n) |
| `tba`               |   extend   |       O(k) |
| `tba`               | extendleft |       O(k) |
| `tba`               |   rotate   |       O(k) |

## set
```python
q = {"obj1","obj2"} # init
q = set(["obj1","obj3"]) # init 
```

| Code       |            Operation             |             Complexity |                 Worst case Complexity | Notes              |
|------------|:--------------------------------:|-----------------------:|--------------------------------------:|--------------------|
| `x in s`   |         check if x in s          |                   O(1) |                                  O(n) |                    |
| `s\|t`     |              Union               |       O(len(s)+len(t)) |                                       |                    |
| `s&t`      |           Intersection           | O(min(len(s), len(t))) |                    O(len(s) * len(t)) | max if t not a set |
| `s1&..&sn` |      Multiple intersection       |                        | (n-1)*O(l), l=max(len(s1),..,len(sn)) |                    |
| `s-t `     |            Difference            |              O(len(s)) |                                       |                    |
| `s^t`      |       Symmetric Difference       |              O(len(s)) |                    O(len(s) * len(t)) |                    |
| `tba`      |      s.difference_update(t)      |              O(len(t)) |                                       |                    |
| `tba`      | s.symmetric_difference_update(t) |              O(len(t)) |                    O(len(t) * len(s)) |                    |

## dictionary

```python
from collections import defaultdict
default_d = defaultdict(list) # init  # A Default dict is a dictionary that is initialized with a default value when each key is encountered for the first time.
d = {} # init 
```
| Code                     |      Operation       | Complexity |
|--------------------------|:--------------------:|-----------:|
| `k in d `                |   check if k in d    |       O(1) |
| `d[k]`                   |       Get Item       |       O(1) |
| `d[k]=obj`               |       Set Item       |       O(1) |
| `del d[k]`               |     Delete Item      |       O(1) |
| `for k in d`             | Iteration over keys  |       O(n) |
| `for v in d.values()`    | Iteration over value |       O(n) |
| `for (k,v) in d.items()` | Iteration over item  |       O(n) |
| `d.copy()`               |         Copy         |       O(n) |

# min-heap 
min-heap : binary tree where the value of a node is smaller or equal than that of its children
* O(log(n)) to insert a new value
* O(log(n)) to extract the min and delete it from the heap
* application: Priority queues, Graph algorithms like Dijkstra’s, Sorting data in chunks, Implementing schedulers
* if all values are positive, we can simulate a max-heap by multiplying all values with -1.

```python
import heapq
h=[1,2,3]
heapq.heapify(h) # transform a list into a heap in-place in O(n)
# it is backed by a list 
```
| Code                  |       Operation        | Complexity |
|-----------------------|:----------------------:|-----------:|
| `heapq.heappush(h,k)` |     Insert element     |  O(log(n)) |
| `heapq.heappop(h)`    |  Remove smallest item  |  O(log(n)) |
| `heapq.heapify(l)`    | Convert list into heap |       O(n) |
