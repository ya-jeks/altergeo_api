module AltergeoApi
  class Resource

    def initialize(src)
      src.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end

  end
end