##### Ruby Challenges > Medium 1

---

## Circular Buffer

**Problem:**  

A circular buffer, cyclic buffer or ring buffer is a data structure that uses a single, fixed-size buffer as if it were connected end-to-end.  

A circular buffer first starts empty and of some predefined length. For example, this is an empty 7-element buffer:  

```
[ ][ ][ ][ ][ ][ ][ ]
```

Assume that a 1 is written into the middle of the buffer (exact starting location does not matter in a circular buffer):  

```
[ ][ ][ ][1][ ][ ][ ]
```

Then assume that two elements are added, or written to the buffer--2 & 3--which get appended after the 1:

```
[ ][ ][ ][1][2][3][ ]
```

If two elements are then read, or removed from the buffer, the oldest values inside the buffer are removed. The two elements removed, in this case, are 1 & 2, leaving the buffer with just a 3:

```
[ ][ ][ ][ ][ ][3][ ]
```

If the buffer has 7 elements then it is completely full:

```
[6][7][8][9][3][4][5]
```

When the buffer is full an error will be raised, alerting the client that further writes are blocked until a slot becomes free.  

The client can opt to overwrite the oldest data with a forced write. In this case, two more elements--A & B--are added and they overwrite the 3 & 4:

```
[6][7][8][9][A][B][5]
```

Finally, if two elements are now removed then what would be returned is not 3 & 4 but 5 & 6 because A & B overwrote the 3 & the 4 yielding the buffer with:

```
[ ][7][8][9][A][B][ ]
```

---

**Examples / Test Cases:**

```ruby
buffer = CircularBuffer.new(1)
buffer.write('1')
buffer.read == '1'
buffer.read # raises a CircularBuffer::BufferEmptyException


```

---

**Data Structure:**  

**_Inputs_**

* Creating a new CircularBuffer object requires passing an Integer object representing the size of the buffer.
* The `read` and `write` methods can take any object to be stored in the buffer.

**_Outputs_**

* The `write` method will add the given argument to the buffer as long as the buffer is not full.
* The `read` method will return the oldest value stored in the buffer.

---

**Algorithm:**  

* 

---

**Code:**

```ruby
class CircularBuffer
  def initialize(buffer_size)
    @buffer_size = buffer_size
    @buffer = []
  end

  def read
    raise BufferEmptyException if @buffer.empty?

    @buffer.shift
  end

  def write(arg)
    raise BufferFullException if @buffer.size == @buffer_size

    @buffer.push(arg) unless arg.nil?
  end

  def write!(arg)
    if @buffer.size == @buffer_size
      unless arg.nil?
        read
        write(arg)
      end
    else
      write(arg)
    end
  end

  def clear
    @buffer = []
  end

  class BufferFullException < StandardError; end
  class BufferEmptyException < StandardError; end
end
```

**Refactored:**

```ruby
class CircularBuffer
  def initialize(max_size)
    @max_size = max_size
    @buffer = []
  end

  def read
    @buffer.empty? ? raise(BufferEmptyException) : @buffer.shift
  end

  def write(arg)
    raise BufferFullException if @buffer.size == @max_size

    @buffer.push(arg) unless arg.nil?
  end

  def write!(arg)
    if @buffer.size == @max_size
      unless arg.nil?
        read
        write(arg)
      end
    else
      write(arg)
    end
  end

  def clear
    @buffer = []
  end

  class BufferFullException < StandardError; end
  class BufferEmptyException < StandardError; end
end
```

