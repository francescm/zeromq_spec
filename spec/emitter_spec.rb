#encoding: utf-8

require_relative '../emitter'


describe Emitter do
  before(:each) do
    @endpoint = double("endpoint")
    @endpoint.should_receive(:bind)
    context = double("context")
    context.should_receive(:socket).and_return @endpoint
    ZMQ::Context.should_receive(:new).with(1).and_return context
  end

  it "executes" do
    my_data = "my_data"
    e = Emitter.new
    @endpoint.should_receive(:recv_string) do
      e.instance_variable_set("@buffer", my_data)
    end
    @endpoint.should_receive(:recv_string) do 
      e.instance_variable_set("@buffer", "__END_OF_DATA__")
    end
    e.execute
    expect(e.instance_eval("@data")).to eq [ my_data ]
  end
end
