#encoding: utf-8

require 'rubygems'
require 'ffi-rzmq'

class Emitter
  def initialize
    context = ZMQ::Context.new(1)
    @receiver = context.socket(ZMQ::PULL)
    @receiver.bind ENV['EMITTER_SOCKET']
  end

  def execute
    @data = []
    continue = true


    while continue
      @receiver.recv_string(@buffer = "")
      if @buffer.eql? "__END_OF_DATA__"
      then
        continue = false
      else
        @data << @buffer
      end
    end
  end

end


