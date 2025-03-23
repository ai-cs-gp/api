require 'pagy/extras/overflow'
require 'pagy/extras/array'

module App
  class PaginateMe
    include Pagy::Backend

    DEFAULT_PAGE_SIZE = 20
    MAX_PAGE_SIZE = 500

    def initialize(all_nodes, page:, per:)
      @all_nodes = all_nodes

      @page = page
      @page = 1 if page.nil? || page < 1

      @per = if per.nil? || per < 1
        DEFAULT_PAGE_SIZE
      elsif per > MAX_PAGE_SIZE
        MAX_PAGE_SIZE
      else
        per
      end
    end

    def nodes
      result[1].to_a
    end

    def page
      @page
    end

    def per
      @per
    end

    def total
      @total ||= result[0].vars[:count].to_i
    end

    def has_next_page
      total > (@page * @per)
    end

    def has_previous_page
      @page > 1
    end

    def pages_count
      (total / @per.to_f).ceil
    end

    private

    def result
      @result ||=
        if @all_nodes.is_a?(Array)
          pagy_array(@all_nodes, items: @per, page: @page)
        else
          pagy(@all_nodes, items: @per, page: @page)
        end
    end
  end
end