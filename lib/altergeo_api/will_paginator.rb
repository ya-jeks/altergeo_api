require 'will_paginate/collection'

module AltergeoApi

  module WillPaginator

    def paginate(options = {})
      page = options[:page] || 1
      per_page = options[:per_page] || WillPaginate.per_page
      total = options[:total_entries] || self.length
      WillPaginate::Collection.create(page, per_page, total) do |pager|
        pager.replace self[pager.offset, pager.per_page].to_a
      end
    end

  end
end