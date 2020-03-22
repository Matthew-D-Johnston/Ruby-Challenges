# circular_buffer.rb

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
