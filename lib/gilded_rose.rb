def update_quality(items)
  items.each do |item|

    this_item = NormalItem.new(item) if normal_item?(item)
    this_item = BackstagePassItem.new(item) if backstage_passes?(item)
    this_item = AgedBrie.new(item) if aged_brie?(item)
    this_item = Sulfuras.new(item) if sulfuras?(item)

    this_item = Conjured.new(item) if conjured?(item)

    this_item.update_quality
    this_item.update_sell_in
  end
end


class Conjured
  attr_accessor :item
  def initialize(item)
    @item = item
  end

  def update_quality
    if item.quality > 0
      item.quality -= 2
    end
  end

  def update_sell_in
    item.sell_in -= 1
  end
end

class NormalItem
  attr_accessor :item
  def initialize(item)
    @item = item
  end

  def update_quality
    if item.quality > 0
      item.quality -= 1
    end
  end

  def update_sell_in
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality -= 1
    end
  end
end

class BackstagePassItem
  attr_accessor :item
  def initialize(item)
    @item = item
  end

  def update_quality
    item.quality += 1 if item.quality < 50
    if item.sell_in < 11
      item.quality += 1 if item.quality < 50
    end
    if item.sell_in < 6
      item.quality += 1 if item.quality < 50
    end
  end

  def update_sell_in
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality = 0
    end
  end
end

class AgedBrie
  attr_accessor :item
  def initialize(item)
    @item = item
  end

  def update_quality
    item.quality += 1 if item.quality < 50
  end

  def update_sell_in
    item.sell_in -= 1
    if item.sell_in < 0
      item.quality += 1 if item.quality < 50
    end
  end
end

class Sulfuras
  attr_accessor :item
  def initialize(item)
    @item = item
  end

  def update_quality
  end

  def update_sell_in
  end
end

def conjured?(item)
  item.name == "Conjured Mana Cake"
end

def normal_item?(item)
  item.name == "NORMAL ITEM"
end

def aged_brie?(item)
  item.name == "Aged Brie"
end

def backstage_passes?(item)
  item.name == "Backstage passes to a TAFKAL80ETC concert"
end

def sulfuras?(item)
  item.name == "Sulfuras, Hand of Ragnaros"
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

