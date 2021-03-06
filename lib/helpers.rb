include Nanoc::Helpers::Rendering
include Nanoc3::Helpers::XMLSitemap
require 'date'

def all_formulas
  @items.select { |item| item[:kind] == "formula" }
end

def formulas
  all_formulas.select {|item| item[:draft] != true}.sort do |a, b|
    Date.parse(b[:date]) <=> Date.parse(a[:date])
  end
end

def related_formulas(category = @item[:category])
  formulas.select { |item| item[:category] == category and item != @item }
end

def formula_categories
  all_formulas.map { |item| item[:category] }.uniq
end

def category_path(category)
  @items.select { |item| item[:kind] == "category_list" && item[:category] == category}[0].path
end

def videos
  @items.select { |item| item[:kind] == "video" }.sort do |a, b|
    Date.parse(b[:date]) <=> Date.parse(a[:date])
  end
end

def related_videos(difficulty = @item[:difficulty])
  videos.select { |item| item[:difficulty] == difficulty and item != @item }
end

def video_difficulties
  videos.map { |item| item[:difficulty] }.uniq
end

def difficulty_path(difficulty)
  @items.select { |item| item[:kind] == "difficulty_list" && item[:difficulty] == difficulty}[0].path
end

def active_class?(id)
  @item.identifier.include?(id) && 'active'
end

def resources
  @items.select { |item| item[:kind] == "resource" }
end

def resources_for_category(category)
  resources.select { |item| item[:category] == category }
end

def resource_categories
  resources.map { |item| item[:category] }.uniq
end

def author(name)
  @items.detect { |item| item[:kind] == "author" && item[:name] == name}
end
