def update_quality(items)
  items.each do |item|
    if !aged_brie?(item) && !backstage_passes?(item)
      if item.quality > 0
        if !sulfuras?(item)
          item.quality -= 1
        end
      end
    else
      if item.quality < 50
        item.quality += 1
        if backstage_passes?(item)
          if item.sell_in < 11
            if item.quality < 50
              item.quality += 1
            end
          end
          if item.sell_in < 6
            if item.quality < 50
              item.quality += 1
            end
          end
        end
      end
    end
    if !sulfuras?(item)
      item.sell_in -= 1
    end
    if item.sell_in < 0
      if !aged_brie?(item)
        if !backstage_passes?(item)
          if item.quality > 0
            if !sulfuras?(item)
              item.quality -= 1
            end
          end
        else
          item.quality = item.quality - item.quality
        end
      else
        if item.quality < 50
          item.quality += 1
        end
      end
    end
  end
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

