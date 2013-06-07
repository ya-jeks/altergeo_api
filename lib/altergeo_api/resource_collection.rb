require 'altergeo_api/resource'

module AltergeoApi
  class ResourceCollection
    include Enumerable
    extend Forwardable

    attr_accessor :collection
    def_delegators :@collection, :each, :length, :size, :count, :map, :first, :last, :to_a, :[], :empty?

    def initialize(src)
      @collection = build_array src
    end

    protected
      def resource_name
        resource_class.name.demodulize.sub('Collection','').underscore
      end

      def resource_class
        self.class.name.sub('Collection','').constantize
      end

      def build_array(src)
        (src||=[]).reject!{|__, v| !v.is_a?(Hash) }
        src.reduce([]) do |result, (__, val)|
          result << resource_class.new(val[resource_name.to_sym])
        end
      end

  end
end