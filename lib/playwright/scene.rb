module Playwright
  Scene = Struct.new(:sender, :receiver) do
    def self.sender_accessor(name)
      define_method(name, instance_method(:sender))
    end

    def self.receiver_accessor(name)
      define_method(name, instance_method(:receiver))
    end
  end
end
