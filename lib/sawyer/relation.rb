module Sawyer
  class Relation
    class Map
      # Tracks the available next actions for a resource, and
      # issues requests for them.
      def initialize
        @map = {}
      end

      # Adds a Relation to the map.
      #
      # rel - A Relation.
      #
      # Returns nothing.
      def <<(rel)
        @map[rel.name] = rel
      end

      # Gets the raw Relation by its name.
      #
      # key - The Symbol name of the Relation.
      #
      # Returns a Relation.
      def [](key)
        @map[key.to_sym]
      end
    end

    attr_reader :name,
      :href,
      :method

    # Public: Builds an index of Relations from the value of a `_links`
    # property in a resource.
    #
    # index - The Hash mapping Relation names to the Hash Relation
    #         options.
    #
    # Returns a Relation::Map
    def self.from_links(index)
      rels = Map.new

      index.each do |name, options|
        rels << from_link(name, options)
      end

      rels
    end

    # Public: Builds a single Relation from the given options.  These are
    # usually taken from a `_links` property in a resource.
    #
    # name    - The Symbol name of the Relation.
    # options - A Hash containing the other Relation properties.
    #           :_href   - The String URL of the next action's location.
    #           :_method - The optional String HTTP method.
    #
    # Returns a Relation.
    def self.from_link(name, options)
      new name, options[:_href], options[:_method]
    end

    # Public: A Relation represents an available next action for a resource.
    #
    # name   - The Symbol name of the relation.
    # href   - The String URL of the location of the next action.
    # method - The Symbol HTTP method.  Default: :get
    def initialize(name, href, method = nil)
      @name = name.to_sym
      @href = href.to_s

      if method.is_a? String
        if method.size.zero?
          method = nil
        else
          method.downcase!
        end
      end

      @method = (method || :get).to_sym
    end
  end
end