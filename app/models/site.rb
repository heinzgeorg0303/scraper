class Site < ActiveRecord::Base
  include PgSearch

  validates :rank, :url, :name, presence: true
  validates :rank, uniqueness: true

  pg_search_scope :search, 
      :against => {rank: 'A', name: 'B', url: 'C', description: 'D'},
      :using => {:tsearch => {prefix: true}}
end
