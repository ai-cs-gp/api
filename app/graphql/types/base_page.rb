module Types
  class BasePage < BaseObject
    def self.create(node_class)
      Class.new(self) do
        graphql_name("Paginated#{node_class.graphql_name}")

        field :nodes, [node_class], null: false
        field :page, Int, null: false
        field :per, Int, null: false
        field :total, Int, null: false
        field :has_previous_page, Boolean, null: false
        field :has_next_page, Boolean, null: false
        field :pages_count, Int, null: false
      end
    end
  end
end