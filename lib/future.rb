class Future < Thread
  VERSION = "0.0.1"

  def self.all(futures)
    Future { futures.map(&:value) }
  end
end

def Future(&bk)
  Future.start(&bk)
end
