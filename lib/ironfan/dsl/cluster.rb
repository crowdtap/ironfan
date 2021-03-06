module Ironfan
  class Dsl

    class Cluster < Ironfan::Dsl::Compute
      collection :facets,       Ironfan::Dsl::Facet,   :resolver => :deep_resolve

      def initialize(attrs={},&block)
        super
        self.cluster_role       Ironfan::Dsl::Role.new(:name => "#{attrs[:name]}_cluster")
      end

      # Utility method to reference all servers from constituent facets
      def servers
        result = Gorillib::ModelCollection.new(:item_type => Ironfan::Dsl::Server, :key_method => :full_name)
        facets.each {|f| f.servers.each {|s| result << s} }
        result
      end

      def cluster_name()        name;   end
    end

  end
end